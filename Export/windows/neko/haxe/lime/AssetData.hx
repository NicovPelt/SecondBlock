package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/BackCard.png", "assets/BackCard.png");
			type.set ("assets/BackCard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/BlueCard.png", "assets/BlueCard.png");
			type.set ("assets/BlueCard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/BoardDigital.jpg", "assets/BoardDigital.jpg");
			type.set ("assets/BoardDigital.jpg", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/CardField.png", "assets/CardField.png");
			type.set ("assets/CardField.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/GreenCard.png", "assets/GreenCard.png");
			type.set ("assets/GreenCard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/PhaseIcons/Phase1.png", "assets/PhaseIcons/Phase1.png");
			type.set ("assets/PhaseIcons/Phase1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/PhaseIcons/Phase2.png", "assets/PhaseIcons/Phase2.png");
			type.set ("assets/PhaseIcons/Phase2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/PhaseIcons/Phase3.png", "assets/PhaseIcons/Phase3.png");
			type.set ("assets/PhaseIcons/Phase3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/PhaseIcons/PhaseIndicator.png", "assets/PhaseIcons/PhaseIndicator.png");
			type.set ("assets/PhaseIcons/PhaseIndicator.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/RedCard.png", "assets/RedCard.png");
			type.set ("assets/RedCard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
