package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/BackCard.png", __ASSET__assets_backcard_png);
		type.set ("assets/BackCard.png", AssetType.IMAGE);
		className.set ("assets/BlueCard.png", __ASSET__assets_bluecard_png);
		type.set ("assets/BlueCard.png", AssetType.IMAGE);
		className.set ("assets/BoardDigital.jpg", __ASSET__assets_boarddigital_jpg);
		type.set ("assets/BoardDigital.jpg", AssetType.IMAGE);
		className.set ("assets/CardField.png", __ASSET__assets_cardfield_png);
		type.set ("assets/CardField.png", AssetType.IMAGE);
		className.set ("assets/cards/Bookworm.png", __ASSET__assets_cards_bookworm_png);
		type.set ("assets/cards/Bookworm.png", AssetType.IMAGE);
		className.set ("assets/cards/cardbackside.png", __ASSET__assets_cards_cardbackside_png);
		type.set ("assets/cards/cardbackside.png", AssetType.IMAGE);
		className.set ("assets/cards/Elephant.png", __ASSET__assets_cards_elephant_png);
		type.set ("assets/cards/Elephant.png", AssetType.IMAGE);
		className.set ("assets/cards/Golem.png", __ASSET__assets_cards_golem_png);
		type.set ("assets/cards/Golem.png", AssetType.IMAGE);
		className.set ("assets/cards/Jaba.png", __ASSET__assets_cards_jaba_png);
		type.set ("assets/cards/Jaba.png", AssetType.IMAGE);
		className.set ("assets/cards/Owl.png", __ASSET__assets_cards_owl_png);
		type.set ("assets/cards/Owl.png", AssetType.IMAGE);
		className.set ("assets/cards/Scissorman.png", __ASSET__assets_cards_scissorman_png);
		type.set ("assets/cards/Scissorman.png", AssetType.IMAGE);
		className.set ("assets/cards/Spider.png", __ASSET__assets_cards_spider_png);
		type.set ("assets/cards/Spider.png", AssetType.IMAGE);
		className.set ("assets/cards/Stickman.png", __ASSET__assets_cards_stickman_png);
		type.set ("assets/cards/Stickman.png", AssetType.IMAGE);
		className.set ("assets/cards/Stone.png", __ASSET__assets_cards_stone_png);
		type.set ("assets/cards/Stone.png", AssetType.IMAGE);
		className.set ("assets/GreenCard.png", __ASSET__assets_greencard_png);
		type.set ("assets/GreenCard.png", AssetType.IMAGE);
		className.set ("assets/PhaseIcons/Phase1.png", __ASSET__assets_phaseicons_phase1_png);
		type.set ("assets/PhaseIcons/Phase1.png", AssetType.IMAGE);
		className.set ("assets/PhaseIcons/Phase2.png", __ASSET__assets_phaseicons_phase2_png);
		type.set ("assets/PhaseIcons/Phase2.png", AssetType.IMAGE);
		className.set ("assets/PhaseIcons/Phase3.png", __ASSET__assets_phaseicons_phase3_png);
		type.set ("assets/PhaseIcons/Phase3.png", AssetType.IMAGE);
		className.set ("assets/PhaseIcons/PhaseIndicator.png", __ASSET__assets_phaseicons_phaseindicator_png);
		type.set ("assets/PhaseIcons/PhaseIndicator.png", AssetType.IMAGE);
		className.set ("assets/RedCard.png", __ASSET__assets_redcard_png);
		type.set ("assets/RedCard.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "assets/BackCard.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/BlueCard.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/BoardDigital.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/CardField.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Bookworm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/cardbackside.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Elephant.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Golem.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Jaba.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Owl.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Scissorman.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Spider.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Stickman.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/cards/Stone.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/GreenCard.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/PhaseIcons/Phase1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/PhaseIcons/Phase2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/PhaseIcons/Phase3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/PhaseIcons/PhaseIndicator.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/RedCard.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
		className.set ("assets/BackCard.png", __ASSET__assets_backcard_png);
		type.set ("assets/BackCard.png", AssetType.IMAGE);
		
		className.set ("assets/BlueCard.png", __ASSET__assets_bluecard_png);
		type.set ("assets/BlueCard.png", AssetType.IMAGE);
		
		className.set ("assets/BoardDigital.jpg", __ASSET__assets_boarddigital_jpg);
		type.set ("assets/BoardDigital.jpg", AssetType.IMAGE);
		
		className.set ("assets/CardField.png", __ASSET__assets_cardfield_png);
		type.set ("assets/CardField.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Bookworm.png", __ASSET__assets_cards_bookworm_png);
		type.set ("assets/cards/Bookworm.png", AssetType.IMAGE);
		
		className.set ("assets/cards/cardbackside.png", __ASSET__assets_cards_cardbackside_png);
		type.set ("assets/cards/cardbackside.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Elephant.png", __ASSET__assets_cards_elephant_png);
		type.set ("assets/cards/Elephant.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Golem.png", __ASSET__assets_cards_golem_png);
		type.set ("assets/cards/Golem.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Jaba.png", __ASSET__assets_cards_jaba_png);
		type.set ("assets/cards/Jaba.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Owl.png", __ASSET__assets_cards_owl_png);
		type.set ("assets/cards/Owl.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Scissorman.png", __ASSET__assets_cards_scissorman_png);
		type.set ("assets/cards/Scissorman.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Spider.png", __ASSET__assets_cards_spider_png);
		type.set ("assets/cards/Spider.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Stickman.png", __ASSET__assets_cards_stickman_png);
		type.set ("assets/cards/Stickman.png", AssetType.IMAGE);
		
		className.set ("assets/cards/Stone.png", __ASSET__assets_cards_stone_png);
		type.set ("assets/cards/Stone.png", AssetType.IMAGE);
		
		className.set ("assets/GreenCard.png", __ASSET__assets_greencard_png);
		type.set ("assets/GreenCard.png", AssetType.IMAGE);
		
		className.set ("assets/PhaseIcons/Phase1.png", __ASSET__assets_phaseicons_phase1_png);
		type.set ("assets/PhaseIcons/Phase1.png", AssetType.IMAGE);
		
		className.set ("assets/PhaseIcons/Phase2.png", __ASSET__assets_phaseicons_phase2_png);
		type.set ("assets/PhaseIcons/Phase2.png", AssetType.IMAGE);
		
		className.set ("assets/PhaseIcons/Phase3.png", __ASSET__assets_phaseicons_phase3_png);
		type.set ("assets/PhaseIcons/Phase3.png", AssetType.IMAGE);
		
		className.set ("assets/PhaseIcons/PhaseIndicator.png", __ASSET__assets_phaseicons_phaseindicator_png);
		type.set ("assets/PhaseIcons/PhaseIndicator.png", AssetType.IMAGE);
		
		className.set ("assets/RedCard.png", __ASSET__assets_redcard_png);
		type.set ("assets/RedCard.png", AssetType.IMAGE);
		*/
		var useManifest = true;
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		//return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		//else 
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_backcard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_bluecard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_boarddigital_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cardfield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_bookworm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_cardbackside_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_elephant_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_golem_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_jaba_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_owl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_scissorman_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_spider_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_stickman_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_cards_stone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_greencard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_phaseicons_phase1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_phaseicons_phase2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_phaseicons_phase3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_phaseicons_phaseindicator_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_redcard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5

#if openfl





















#end

#else

#if openfl

#end

#if (windows || mac || linux)

//
//@:bitmap("Assets/BackCard.png") class __ASSET__assets_backcard_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/BlueCard.png") class __ASSET__assets_bluecard_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/BoardDigital.jpg") class __ASSET__assets_boarddigital_jpg extends openfl.display.BitmapData {}
//@:bitmap("Assets/CardField.png") class __ASSET__assets_cardfield_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Bookworm.png") class __ASSET__assets_cards_bookworm_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/cardbackside.png") class __ASSET__assets_cards_cardbackside_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Elephant.png") class __ASSET__assets_cards_elephant_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Golem.png") class __ASSET__assets_cards_golem_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Jaba.png") class __ASSET__assets_cards_jaba_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Owl.png") class __ASSET__assets_cards_owl_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Scissorman.png") class __ASSET__assets_cards_scissorman_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Spider.png") class __ASSET__assets_cards_spider_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Stickman.png") class __ASSET__assets_cards_stickman_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/cards/Stone.png") class __ASSET__assets_cards_stone_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/GreenCard.png") class __ASSET__assets_greencard_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/PhaseIcons/Phase1.png") class __ASSET__assets_phaseicons_phase1_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/PhaseIcons/Phase2.png") class __ASSET__assets_phaseicons_phase2_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/PhaseIcons/Phase3.png") class __ASSET__assets_phaseicons_phase3_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/PhaseIcons/PhaseIndicator.png") class __ASSET__assets_phaseicons_phaseindicator_png extends openfl.display.BitmapData {}
//@:bitmap("Assets/RedCard.png") class __ASSET__assets_redcard_png extends openfl.display.BitmapData {}
//
//

#end

#end
#end
