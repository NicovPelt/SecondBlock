package;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import cards.*;
import openfl.geom.Matrix;

class Main extends Sprite {
	
	var player1:Player;
	var player2:Player;
	var director:Director;
	
	var board:Sprite;
	
	

	public function new () {
		
		super ();
		/*
		 * initializing board
		 */
		board = new Sprite();
		var bitmapData = Assets.getBitmapData ("assets/BoardDigital.jpg");
		var scale = new Matrix(1.3333333, 0, 0, 1.333333, 0, 0);
		board.graphics.beginBitmapFill(bitmapData, scale);
		board.graphics.drawRect(0, 0, 800, 600);
		//addChild(board);
	 
		/*
		 * initializing card graphics
		 * TODO adding effect and trapcard graphics
		 * 		finalizing all card graphics
		 */
		Card.cardGraphics = new Array<BitmapData>();
		Card.cardGraphics.push(Assets.getBitmapData ("assets/RedCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/BlueCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/GreenCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/BackCard.png"));
		
		/*
		 * initializing players and director
		 * true = starting player
		 */
		director = new Director(this);
		player1 = new Player(director, this, true);
		player2 = new Player(director, this, false);
		director.player1 = player1;
		director.player2 = player2;
		
	}

	
}