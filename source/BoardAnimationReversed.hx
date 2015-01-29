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
class BoardAnimationReversed extends Animation
{

	public function new() 
	{
		super();
		initValues();
		initializeTilesheet();
	}
	
	/**
	 * initializes the values of the sprite sheet
	 */
	function initValues()
	{
		//number of frames, the amount of images
		frameCount = 11;
		// the width of one image
		imageWidth = 800;
		// the height of one image		
		imageHeight = 600;
		//loads the sprite sheet
		bitmapData = Assets.getBitmapData( "assets/rotationReversedSpriteSheet.png" );
	}
}