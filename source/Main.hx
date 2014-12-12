package;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;

class Main extends Sprite {
	
	var deck:Array<Card>;
	var topCard:Card;
	
	public function new () {
		
		super ();
		
		deck = new Array<Card>();
		
		Card.cardGraphics = new Array<BitmapData>();
		Card.cardGraphics.push(Assets.getBitmapData ("assets/RedCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/BlueCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/GreenCard.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/BackCard.png"));
		
		deck.push(new Card(0, this));
		deck.push(new Card(1, this));
		deck.push(new Card(2, this));
		
		refreshDeck();
		//trace(Lib.current.stage.stageWidth + " " + stage.height);
	}
	
	public function refreshDeck() {
		if (deck.length > 0) {
			topCard = deck.pop();
			topCard.x = 100;
			topCard.y = 100;
			addChild(topCard);
		}
	}
}