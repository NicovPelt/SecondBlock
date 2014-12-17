package ;

import cards.*;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Nico van Pelt
 */
class Player extends Sprite
{
	
	var space:Int = 70; // space in between cards
	
	var startingHand:Bool = true;
	
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
		cardsLeft.x = 580;
		cardsLeft.y = 550;
		
		deck = new Array<Card>();
		hand = new Array<Card>();
		grave = new Array<Card>();
		
		prepareDeck();
		refreshDeck();
		
		/*
		 * Draw 4 cards as starting hand
		 */
		for (i in 0...4) {
			putInHand(topCard);
		}
		startingHand = false;
	}
	
	/**
	 * Adds cards to deck and shuffles it.
	 */
	private function prepareDeck() {
		var card:Card;
		for ( i in 0...7) { //create 7 of each character card
			card = new Character(0, this);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(1, this);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(2, this);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
		}
	}
	
	/**
	 * displays the top card of the deck, if any.
	 */
	public function refreshDeck() {
		if (deck.length > 0) {
			topCard = deck.pop();
			topCard.x = 560;
			topCard.y = 520;
			main.addChild(topCard);
			main.removeChild(cardsLeft);
			cardsLeft.text = "" + (deck.length + 1);
			main.addChild(cardsLeft);
		}
	}
	
	public function canDrawCard():Bool {
		if (main.canDraw(this)|| startingHand) {
			hand.push(topCard);
			topCard.x = 10 + ((hand.length - 1) * space);
			refreshDeck();
			return true;
		}
		return false;
	}
	
	public function playCard(card:Card) {
		if (main.canPlace(card, this)) {
			//TODO place card and execute effect
		} else {
			//return to hand
			card.x = 10 +(hand.indexOf(card) * space);
			card.y = 520;
		}
	}
	
	private function putInHand(card:Card) {
		if (canDrawCard()) {
			card.removeEventListener(MouseEvent.CLICK, drawCard);
			card.graphics.beginBitmapFill(Card.cardGraphics[card.cardType]);
			card.graphics.drawRect(0, 0, Card.cardGraphics[card.cardType].width, Card.cardGraphics[card.cardType].height);
			card.addEventListener( MouseEvent.MOUSE_DOWN, dragCard);
		}
	}
	
	public function drawCard( event:MouseEvent ) {
		var card:Card = event.currentTarget;
		putInHand(card);
	}
	
	public function dragCard( event:MouseEvent ) {
		var card:Card = event.currentTarget;
		main.addChild(card);
		card.startDrag();
		card.addEventListener(MouseEvent.MOUSE_UP, placeCard);
	}
	
	public function placeCard( event:MouseEvent ) {
		var card:Card = event.currentTarget;
		card.stopDrag();
		playCard(event.target);
		card.removeEventListener(MouseEvent.MOUSE_UP, placeCard);
	}

}