package ;

import cards.*;
import openfl.display.Sprite;

/**
 * ...
 * @author Nico van Pelt
 */
class Player extends Sprite
{
	
	var deck:Array<Card>;
	var hand:Array<Card>;
	var grave:Array<Card>;
	
	var topCard:Card; //top card of the deck
	var main:Main;

	public function new(main:Main) 
	{
		super();
		
		this.main = main;
		
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
			topCard.x = 50;
			topCard.y = 500;
			main.addChild(topCard);
		}
	}
	
	public function drawCard():Bool {
		if (main.canDraw(this)) {
			hand.push(topCard);
			topCard.x = 50 + (hand.length * 60);
			refreshDeck();
			return true;
		}
		return false;
	}
	
	public function placeCard(card:Card) {
		if (main.canPlace(card, this)) {
			//TODO place card and execute effect
		} else {
			card.x = 50 +((hand.indexOf(card) + 1) * 60);
			card.y = 500;
		}
	}
	
}