package;

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
class Animation extends Sprite
{
  // the total amount of images
  var frameCount:Int;

  // the width and height of one image
  var imageWidth:Int;
  var imageHeight:Int;

  // the image that is currently visible
  var currentImage:Int = 0;

  // the OpenFL tilesheet object
  var tilesheet:Tilesheet;
  
  
  var bitmapData:BitmapData;

  /**
   * The constructor. 
   * Initializes things. In this case the tilesheet with the animation
   */
  public function new()
  {
    super();
  }

  /**
   * Update the board
   * Called from 'outside' hence the public access-modifier
   */
  public function update():Void
  {
    drawNextImage();
  }

  /**
   * Draw the next image up for the animation
   */
  function drawNextImage():Void
  {
    this.graphics.clear();

    // draw the image with 'id' currentGooseImage onto this.graphics
    // the array [ 0, 0, currentGoose ] indicates
    // * the x position (in this case zero)
    // * the y position (in this case zero)
    // * the index of the image to draw (increments from 0 to 11 by use of the modulo operator: %)
    tilesheet.drawTiles( this.graphics, [ 0, 0, currentImage ], true );

    // point to the next index of the tile sheet's images
    currentImage += 1;
  }

  /**
   * Initialize the Tilesheet instance with the images of the sprite sheet
   */
  function initializeTilesheet():Void
  {
	  
	var cols:Int = Math.floor( bitmapData.width / imageWidth );
	frameCount = Math.floor( frameCount );
	
    // create tileSheet object
    tilesheet = new Tilesheet( bitmapData );

    // loop to get all the seperate images from the sprite sheet
    for( imageIndex in 0...frameCount )
    {
		var col:Int = imageIndex % cols;
		var row:Int = Math.floor( imageIndex / cols );
		// calculate the rectangle of the next board's image
		var rectangle:Rectangle = new Rectangle( imageWidth * col, imageHeight * row, imageWidth, imageHeight );

		// add the rectangle of the next image in the sprite sheet
		tilesheet.addTileRect( rectangle );

    }
  }
}