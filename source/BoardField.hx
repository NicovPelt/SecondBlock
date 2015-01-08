package ;

import cards.Card;
import cards.Character;
import openfl.display.Sprite;

/**
 * ...
 * @author Nico van Pelt
 */
class BoardField extends Sprite
{

	var characterCard:Character;
	var trapCard:Card;
	
	public function new() 
	{
		super();
		
		var bitmapData = Assets.getBitmapData ("assets/BoardDigital.jpg");
		graphics.beginBitmapFill(bitmapData);
		graphics.drawRect(0, 0, 800, 600);
		addChild(board);
		
		//Standard y coordinate goes for all fields
		this.y = 312;
	}
	
}