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
	
	public var cardGraphic:Int;
	public var cardType:Int;
	var turned:Bool = false;
	public var owner:Player;

	/* cardGraphic:
	 * 0 = backside
	 * 1 = scissors
	 * 2 = scissors
	 * 3 = scissors
	 * 4 = paper
	 * 5 = paper
	 * 6 = paper
	 * 7 = rock
	 * 8 = rock
	 * 9 = rock
	 * 
	 * cardType:
	 * 1 = scissors
	 * 2 = paper
	 * 3 = rock
	 */
	public function new(cardType:Int, owner:Player, cardGraphic:Int) 
	{
		super();
		this.owner = owner;
		this.cardType = cardType;
		this.cardGraphic = cardGraphic;
		
		this.graphics.beginBitmapFill(cardGraphics[0]);
		this.graphics.drawRect(0, 0, cardGraphics[0].width, cardGraphics[0].height);
	}
	
	
	
}