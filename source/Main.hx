package;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import cards.*;

class Main extends Sprite {
	
	var player1:Player;
	var player2:Player;
	
	public function new () {
		
		super ();
		
		Card.cardGraphics = new Array<BitmapData>();
		Card.cardGraphics.push(Assets.getBitmapData ("assets/RedCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/BlueCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/GreenCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/BackCard.png"));
		
		player1 = new Player(this);
		
	}
	
	/**
	 * checks to see if a player is allowed to draw a card. TODO
	 * @param	The player requesting the draw
	 * @return	Whether it can be drawn or not
	 */
	public function canDraw( player:Player ):Bool {
		return true;
	}
	
	/**
	 * checks to see if a player is allowed to place the dragged card to the dragged to spot. TODO
	 * @param	The card to be placed
	 * @param	The player requesting the placement
	 * @return	Whether it can be placed or not
	 */
	public function canPlace(card:Card, player:Player):Bool {
		return false;
	}
}