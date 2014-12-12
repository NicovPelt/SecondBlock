package ;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;

/**
 * ...
 * @author ...
 */
class Card extends Sprite
{
	public static var cardGraphics:Array<BitmapData>;
	
	var cardType:Int;
	var turned:Bool = false;
	var main:Main;

	/*
	 * 0 = red
	 * 1 = blue
	 * 2 = green
	 * 3 = backside
	 */
	public function new(cardType:Int, main:Main) 
	{
		
		super();
		this.main = main;
		
		this.cardType = cardType;
		this.graphics.beginBitmapFill(cardGraphics[3]);
		this.graphics.drawRect(0, 0, cardGraphics[3].width, cardGraphics[3].height);
		
		this.addEventListener(MouseEvent.CLICK, drawCard);
	}
	
	public function drawCard( event:MouseEvent ) {
		
		if (!turned) {
			this.removeEventListener(MouseEvent.CLICK, drawCard);
			x = 200;
			this.graphics.beginBitmapFill(cardGraphics[cardType]);
			this.graphics.drawRect(0, 0, cardGraphics[cardType].width, cardGraphics[cardType].height);
			this.addEventListener( MouseEvent.MOUSE_DOWN, dragCard);
			main.refreshDeck();
		}
	}
	
	public function dragCard( event:MouseEvent ) {
		this.startDrag();
		this.addEventListener(MouseEvent.MOUSE_UP, placeCard);
	}
	
	public function placeCard( event:MouseEvent ) {
		this.stopDrag();
		this.removeEventListener(MouseEvent.MOUSE_UP, placeCard);
	}
	
}