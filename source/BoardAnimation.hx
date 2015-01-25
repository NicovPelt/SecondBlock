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
class BoardAnimation extends Sprite
{
  // the total amount of images
  var boardCount:Int = 11;

  // the width and height of one image
  var boardWidth:Int = 800;
  var boardHeight:Int = 600;

  // the image that is currently visible
  var currentBoardImage:Int = 0;

  // the OpenFL tilesheet object
  var boardTilesheet:Tilesheet;

  /**
   * The constructor. 
   * Initializes things. In this case the tilesheet with the animation
   */
  public function new()
  {
    super();

    initializeTilesheet();
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
   *
   */
  function drawNextImage():Void
  {
    this.graphics.clear();

    // draw the image with 'id' currentGooseImage onto this.graphics
    // the array [ 0, 0, currentGoose ] indicates
    // * the x position (in this case zero)
    // * the y position (in this case zero)
    // * the index of the image to draw (increments from 0 to 11 by use of the modulo operator: %)
    boardTilesheet.drawTiles( this.graphics, [ 0, 0, currentBoardImage ], true );

    // point to the next index of the tile sheet's images
    currentBoardImage += 1;
  }

  /**
   * Initialize the Tilesheet instance with the images of the sprite sheet
   */
  function initializeTilesheet():Void
  {
    // start at the top left of the image
    var column:Int = 0;
    var row:Int = 0;

    // get image from assets folder and create tileSheet object
    var boardBitmapData:BitmapData = Assets.getBitmapData( "assets/rotationTilesheet.png" );
    boardTilesheet = new Tilesheet( boardBitmapData );

    // loop to get all the seperate images from the sprite sheet
    for( rotationTilesheetIndex in 0...boardCount )
    {
      // calculate the rectangle of the next board's image
      var boardRectangle:Rectangle = new Rectangle( boardWidth * column, boardHeight * row, boardWidth, boardHeight );

      // add the rectangle of the next image in the sprite sheet
      boardTilesheet.addTileRect( boardRectangle );

      // some math to recalculate the row and column for the next image of the animation
      row = Math.floor( rotationTilesheetIndex / 4 );
      column = rotationTilesheetIndex % 4;
    }
  }
}