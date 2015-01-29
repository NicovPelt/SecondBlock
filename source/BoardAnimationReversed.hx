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
	
	function initValues()
	{
		frameCount = 11;
		// the width and height of one image
		imageWidth = 800;
		imageHeight = 600;
		// the image that is currently visible
		currentImage = 0;
		
		bitmapData = Assets.getBitmapData( "assets/rotationReversedTilesheet.png" );
	}
}