package ;

import cards.Card;
import cards.Character;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Nico van Pelt
 */
class BoardField extends Sprite
{

	public var characterCard:Character = null;
	public var trapCard:Card = null;
	
	public function new(x:Int) 
	{
		super();
		
		var bitmapData = Assets.getBitmapData ("assets/CardField.png");
		graphics.beginBitmapFill(bitmapData);
		graphics.drawRect(0, 0, 116, 200);
		
		//Standard y coordinate goes for all fields
		this.y = 312;
		this.x = x;
	}
	
	/**
	 * Checks whether this slot is empty and therefore the card can be placed
	 * @param	Card to be placed
	 * @return  Whether the slot is empty
	 */
	public function canPlaceCard(card:Card):Bool {
		if (Type.getClassName(Type.getClass(card)) == "cards.Character" && characterCard == null) {
			return true;
		} else if ((Type.getClassName(Type.getClass(card)) == "cards.Trap" || Type.getClassName(Type.getClass(card)) == "cards.Effect") && trapCard == null) {
			return true;
		}
		return false;
	}
	
	/**
	 * Place the card in the slot
	 * @param	Card to be placed
	 */
	public function placeCard(card:Card) {
		if (Type.getClassName(Type.getClass(card)) == "cards.Character") {
			//card is character and needs to be placed in this slot
			this.characterCard = cast(card, Character);
			card.x = this.x + 10;
			card.y = this.y + 10;
		} else {
			//Card is trap of effect
		}
	}
	
}