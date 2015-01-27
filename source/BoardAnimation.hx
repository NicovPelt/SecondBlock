package;

import openfl.display.Tilesheet;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Tilesheet;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Assets;
/**
 * ...
 * @author Zhifan Yang
 */
class BoardAnimation extends Animation
{

	public function new() 
	{
		super();
		initValues();
		initializeTilesheet();
	}
	
	function initValues()
	{
		frameCount = 11;
		// the width and height of one image
		imageWidth = 800;
		imageHeight = 600;
		// the image that is currently visible
		currentImage = 0;
		
		bitmapData = Assets.getBitmapData( "assets/rotationTilesheet.png" );
	}
	override function initializeTilesheet():Void
	{
		var cols:Int = Math.floor( bitmapData.width / imageWidth );
		frameCount = Math.floor( frameCount );
	
		// create tileSheet object
		tilesheet = new Tilesheet( bitmapData );

		// loop to get all the seperate images from the sprite sheet
		for( rotationAnimationIndex in 0...frameCount )
		{
			var col:Int = rotationAnimationIndex % cols;
			var row:Int = Math.floor( rotationAnimationIndex / cols );
			// calculate the rectangle of the next board's image
			var rectangle:Rectangle = new Rectangle( imageWidth * col, imageHeight * row, imageWidth, imageHeight );

			// add the rectangle of the next image in the sprite sheet
			tilesheet.addTileRect( rectangle );
		}
	}
}