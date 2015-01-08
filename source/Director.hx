package ;

import cards.*;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Nico van Pelt
 */
class Director
{
	/*
	 * 0 = draw phase
	 * 1 = play phase
	 * 2 = attack phase
	 */ 
	var turnPhase:Int = 0;
	
	public var player1:Player;
	public var player2:Player;
	
	var cardsDrawn:Int = -8;
	var cardsPlaced:Int = 0;
	
	var phase1:Sprite;
	var phase2:Sprite;
	var phase3:Sprite;
	var phaseInd:Sprite;

	public function new(main:Main) 
	{
		/*
		 * initialize icons for the phases
		 */ 
		phase1 = new Sprite();
		var bitmapData = Assets.getBitmapData ("assets/PhaseIcons/Phase1.png");
		phase1.graphics.beginBitmapFill(bitmapData);
		phase1.graphics.drawRect(0, 0, 20, 20);
		phase2 = new Sprite();
		bitmapData = Assets.getBitmapData ("assets/PhaseIcons/Phase2.png");
		phase2.graphics.beginBitmapFill(bitmapData);
		phase2.graphics.drawRect(0, 0, 20, 20);
		phase3 = new Sprite();
		bitmapData = Assets.getBitmapData ("assets/PhaseIcons/Phase3.png");
		phase3.graphics.beginBitmapFill(bitmapData);
		phase3.graphics.drawRect(0, 0, 20, 20);
		phaseInd = new Sprite();
		bitmapData = Assets.getBitmapData ("assets/PhaseIcons/PhaseIndicator.png");
		phaseInd.graphics.beginBitmapFill(bitmapData);
		phaseInd.graphics.drawRect(0, 0, 20, 5);
		
		phase1.y = 290;
		phase2.y = 290;
		phase3.y = 290;
		phaseInd.y = 310;
		phase1.x = 360;
		phase2.x = 390;
		phase3.x = 420;
		phaseInd.x = 360;
		
		main.addChild(phase1);
		main.addChild(phase2);
		main.addChild(phase3);
		main.addChild(phaseInd);
		
		phase2.addEventListener(MouseEvent.CLICK, toPhase2);
		phase3.addEventListener(MouseEvent.CLICK, toPhase3);
	}
	
	/**
	 * checks to see if a player is allowed to draw a card. TODO
	 * @param	The player requesting the draw
	 * @return	Whether it can be drawn or not
	 */
	public function canDraw( player:Player ):Bool {
		if (player.activePlayer && turnPhase == 0) {
			cardsDrawn++;
			if (cardsDrawn == 2) {
				cardsDrawn = 0;
				changePhase();
			}
			return true;
		}
		return false;
	}
	
	/**
	 * checks to see if a player is allowed to place the dragged card to the dragged to spot. TODO
	 * @param	The card to be placed
	 * @param	The player requesting the placement
	 * @return	Whether it can be placed or not
	 */
	public function canPlace(card:Card, player:Player):Bool {
		if (player.activePlayer && turnPhase == 1) {
			cardsPlaced ++;
			if (cardsPlaced == 2) {
				changePhase();
			}
			return true;
		}
		return false;
	}
	
	/**
	 * called when a player wishes to change the phase of a turn.
	 * Will move to the next phase, or after attack pass the turn.
	 */
	public function changePhase() {
		if (turnPhase < 2){
			turnPhase++;
			phaseInd.x += 30;
		} else {
			player1.changeActive();
			player2.changeActive();
			turnPhase = 0;
			phaseInd.x = 360;
		}
	}
	
	public function toPhase2(event:MouseEvent) {
		if (turnPhase == 0) {
			changePhase();
		}
	}
	
	public function toPhase3(event:MouseEvent) {
		if (turnPhase == 0) {
			changePhase();
		} 
		if (turnPhase == 1) {
			changePhase();
		}
	}
}