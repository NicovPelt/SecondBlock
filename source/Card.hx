package ;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author ...
 */
class Card extends Sprite
{
	public static var cardGraphics:Array<BitmapData>;
	
	var cardType:Int;
	var turned:Bool = false;

	/*
	 * 0 = red
	 * 1 = blue
	 * 2 = green
	 * 3 = backside
	 */
	public function new(cardType:Int) 
	{
		
		super();
		this.cardType = cardType;
		this.graphics.beginBitmapFill(cardGraphics[3]);
		this.graphics.drawRect(0, 0, cardGraphics[3].width, cardGraphics[3].height);
		
	}
	
	public function drawCard() {
		
		if (!turned) {
			this.graphics.beginBitmapFill(cardGraphics[cardType]);
			this.graphics.drawRect(0, 0, cardGraphics[cardType].width, cardGraphics[cardType].height);
		}
	}
	
}