package ;

import cards.*;

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

	public function new() 
	{
		
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
		} else {
			player1.changeActive();
			player2.changeActive();
			turnPhase = 0;
		}
	}
}