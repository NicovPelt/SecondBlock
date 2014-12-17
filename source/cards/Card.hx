package cards;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author Nico van Pelt
 */
class Card extends Sprite
{
	public static var cardGraphics:Array<BitmapData>;
	
	public var cardType:Int;
	var turned:Bool = false;
	public var owner:Player;

	/*
	 * 0 = red
	 * 1 = blue
	 * 2 = green
	 * 3 = backside
	 */
	public function new(cardType:Int, owner:Player) 
	{
		super();
		this.owner = owner;
		this.cardType = cardType;
		
		this.graphics.beginBitmapFill(cardGraphics[3]);
		this.graphics.drawRect(0, 0, cardGraphics[3].width, cardGraphics[3].height);
	}
	
	
	
}