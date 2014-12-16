package ;

import cards.*;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author Nico van Pelt
 */
class Player extends Sprite
{
	
	var deck:Array<Card>;
	var hand:Array<Card>;
	var grave:Array<Card>;
	
	var cardsLeft:TextField;
	var topCard:Card; //top card of the deck
	var main:Main;

	public function new(main:Main) 
	{
		super();
		
		this.main = main;
		
		cardsLeft = new TextField();
		main.addChild(cardsLeft);
		cardsLeft.textColor = 0xFFFFFF;
		cardsLeft.x = 30;
		cardsLeft.y = 550;
		
		deck = new Array<Card>();
		hand = new Array<Card>();
		grave = new Array<Card>();
		
		prepareDeck();
		refreshDeck();
	}
	
	/**
	 * Adds cards to deck and shuffles it.
	 */
	private function prepareDeck() {
		for ( i in 0...7){ //create 7 of each character card
			deck.push(new Character(0, this));
			deck.push(new Character(1, this));
			deck.push(new Character(2, this));
		}
	}
	
	/**
	 * displays the top card of the deck, if any.
	 */
	public function refreshDeck() {
		if (deck.length > 0) {
			topCard = deck.pop();
			topCard.x = 10;
			topCard.y = 500;
			main.addChild(topCard);
			main.removeChild(cardsLeft);
			cardsLeft.text = "" + (deck.length + 1);
			main.addChild(cardsLeft);
		}
	}
	
	public function drawCard():Bool {
		if (main.canDraw(this)) {
			hand.push(topCard);
			topCard.x = 50 + (hand.length * 70);
			refreshDeck();
			return true;
		}
		return false;
	}
	
	public function placeCard(card:Card) {
		if (main.canPlace(card, this)) {
			//TODO place card and execute effect
		} else {
			//return to hand
			card.x = 50 +((hand.indexOf(card) + 1) * 70);
			card.y = 500;
		}
	}
	
	

}