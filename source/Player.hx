package ;

import cards.*;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.Lib;

/**
 * ...
 * @author Nico van Pelt
 */
class Player extends Sprite
{
	
	var space:Int = 70; // space in between cards. May be changed to allow more cards in hand.
	
	var startingHand:Bool = true;//whether the player still needs to draw their starting hand
	public var activePlayer:Bool = true;//whether it is this player's turn
	
	// arrays containing the cards in certain positions.
	public var deck:Array<Card>;
	var hand:Array<Card>;
	public var grave:Array<Card>;
	
	// 0 = leftmost slot, 5 = rightmost slot
	public var slots:Array<BoardField>;
	
	var cardsLeft:TextField; //displays the cards left in the deck
	public var topCard:Card; //top card of the deck
	
	//director and main for the game. used to call certain functions in those classes.
	var director:Director; 
	var main:Main;
	
	//var boardAnimation = new BoardAnimation();
	
	//var boardAnimationReversed = new BoardAnimationReversed();

	public function new(director:Director, main:Main, startingPlayer:Bool) 
	{
		super();
		
		this.director = director;
		this.main = main;
		
		cardsLeft = new TextField();
		addChild(cardsLeft);
		cardsLeft.textColor = 0xFFFFFF;
		cardsLeft.x = 580;
		cardsLeft.y = 550;
		
		deck = new Array<Card>();
		hand = new Array<Card>();
		grave = new Array<Card>();
		slots = new Array<BoardField>();
		
		setupField();
		prepareDeck();
		refreshDeck();
		
		/*
		 * Draw 4 cards as starting hand
		 */
		for (i in 0...4) {
			putInHand(topCard);
		}
		startingHand = false;
		
		if (!startingPlayer) {
			changeActive();
		}		
		main.addChild(this);
		
	}
	
	/**
	 * Adds cards to deck and shuffles it.
	 */
	private function prepareDeck() {
		var card:Card;
		for ( i in 0...2) { //create 2 of each character card
			card = new Character(1, this, 1);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(1, this, 2);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(1, this, 3);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(2, this, 4);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(2, this, 5);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(2, this, 6);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(3, this, 7);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(3, this, 8);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
			card = new Character(3, this, 9);
			card.addEventListener(MouseEvent.CLICK, drawCard);
			deck.push(card);
		}
		card = new Character(1, this, 1); //to get 21 cards in total
		card.addEventListener(MouseEvent.CLICK, drawCard);
		deck.push(card);
		card = new Character(2, this, 4);
		card.addEventListener(MouseEvent.CLICK, drawCard);
		deck.push(card);
		card = new Character(3, this, 7);
		card.addEventListener(MouseEvent.CLICK, drawCard);
		deck.push(card);
		deck.sort(randomSort);
	}
	
	/**
	 * Sorts two cards to random location.
	 * used for deck shuffling
	 */
	private function randomSort( a:Card, b:Card ):Int
	{
		if( Math.random() < 0.5 )
		{
			return -1;
		}
		else
		{
			return 1;
		}
	}
	
	/**
	 * adds the card slots to the field
	 */
	public function setupField() {
		slots.push(new BoardField(11));
		slots.push(new BoardField(140));
		slots.push(new BoardField(277));
		slots.push(new BoardField(407));
		slots.push(new BoardField(544));
		slots.push(new BoardField(673));
		for (fields in slots) {
			addChild(fields);
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
			addChild(topCard);
			removeChild(cardsLeft);
			cardsLeft.text = "" + (deck.length + 1);
			addChild(cardsLeft);
		}
	}
	
	/**
	 * when called, the top card of the deck is added to a player's hand if legal
	 * @param	card to be drawn
	 */
	private function putInHand(card:Card) {
		if (director.canDraw(this) || startingHand) {
			hand.push(topCard);
			topCard.x = 10 + ((hand.length - 1) * space);
			refreshDeck();
			card.removeEventListener(MouseEvent.CLICK, drawCard);
			card.graphics.beginBitmapFill(Card.cardGraphics[card.cardGraphic]);
			card.graphics.drawRect(0, 0, Card.cardGraphics[card.cardGraphic].width, Card.cardGraphics[card.cardGraphic].height);
			card.addEventListener( MouseEvent.MOUSE_DOWN, dragCard);
		}
	}
	
	/**
	 * make a player the active one or not
	 * rotations add a lot of new bugs
	 */
	public function changeActive() {
		if(activePlayer){
			rotation = 180;
			x = 800;
			y = 600;
			activePlayer = false;
			for (i in 0...hand.length) {
				hand[i].graphics.beginBitmapFill(Card.cardGraphics[0]);
				hand[i].graphics.drawRect(0, 0, Card.cardGraphics[0].width, Card.cardGraphics[0].height);
			}
			//rotationAnimation();
		} else {
			rotation = 0;
			x = 0;
			y = 0;
			activePlayer = true;
			for (i in 0...hand.length) {
				hand[i].graphics.beginBitmapFill(Card.cardGraphics[hand[i].cardGraphic]);
				hand[i].graphics.drawRect(0, 0, Card.cardGraphics[hand[i].cardGraphic].width, Card.cardGraphics[hand[i].cardGraphic].height);
			}
			//rotationReversedAnimation();
		}
	}
	
	/**
	 * Called when player tries to draw a card
	 * @param	event
	 */
	public function drawCard( event:MouseEvent ) {
		var card:Card = event.currentTarget;
		putInHand(card);
	}
	
	/**
	 * Called when a player tries to drag a card in their hand
	 * @param	event
	 */
	public function dragCard( event:MouseEvent ) {
		var card:Card = event.currentTarget;
		if(card.owner.activePlayer){
			addChild(card);
			card.startDrag();
			card.addEventListener(MouseEvent.MOUSE_UP, placeCard);
		}
	}
	
	/**
	 * Called when a player releases a card they're dragging
	 * @param	event
	 */
	public function placeCard( event:MouseEvent ) {
		var card:Card = event.currentTarget;
		card.stopDrag();
		card.removeEventListener(MouseEvent.MOUSE_UP, placeCard);
		var targetField:BoardField = null;
		var foundSlot = false;
		for (slot in slots) {
			targetField = slot;
			var rect = new Rectangle(slot.x, slot.y, slot.width, slot.height);
			if (rect.containsPoint(new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY))) {
				foundSlot = true;
				break;
			}
		}
		if (director.canPlace(card, this) && targetField.canPlaceCard(card) && foundSlot) {
			//place card and execute effect
			card.removeEventListener(MouseEvent.MOUSE_DOWN, dragCard);
			hand.remove(card);
			rearangeHand();
			targetField.placeCard(card);
			director.cardPlaced();
		} else {
			//return to hand
			card.x = 10 +(hand.indexOf(card) * space);
			card.y = 520;
		}
	}
	
	/**
	 * puts each card in hand in its propper possition
	 */
	public function rearangeHand() {
		for (card in hand) {
			card.x = 10 +(hand.indexOf(card) * space);
		}
	}
	
	private function update( event:Event ):Void
	{
	//	boardAnimation.update();
	}
	
	function rotationAnimation()
	{
	
		//addChild(BoardAnimation);
		addEventListener( Event.ENTER_FRAME, update );
	}
	
	private function updateReversed( event:Event ):Void
	{
	//	boardAnimationReversed.update();
	}
	
	function rotationReversedAnimation()
	{
	//	addChild(boardAnimationReversed);
		addEventListener( Event.ENTER_FRAME, updateReversed );
	}
}