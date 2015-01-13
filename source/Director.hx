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
	
	// var to keep track of the number of cards drawn in the first phase of a turn. Starts at -8 to compensate for the starting hand drawn.
	var cardsDrawn:Int = -8;
	// var to keep track of the number of cards placed in the second phase of a turn.
	var cardsPlaced:Int = 0;
	
	
	var phase1:Sprite;
	var phase2:Sprite;
	var phase3:Sprite;
	var phaseInd:Sprite;
	
	var attackerField:Array<BoardField>;
	var defenderField:Array<BoardField>;
	var attacked:Array<Bool>;
	var attacker:Card;

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
			return true;
		}
		return false;
	}
	
	/**
	 * Funtion called when a card is placed in the second phase. 
	 * Changes phase when the second card is placed
	 * TODO keep effect and trap placement into consideration
	 */ 
	public function cardPlaced() {
		cardsPlaced ++;
		if (cardsPlaced == 2) {
			changePhase();
		}
	}
	
	/**
	 * Called when 3rd (attack) phase starts.
	 * Adds event listeners to all cards that can possibly attack.
	 */ 
	function startAttackPhase() {
		attacked = new Array<Bool>();
		if (player1.activePlayer) {
			attackerField = player1.slots;
			defenderField = player2.slots;
		} else {
			attackerField = player2.slots;
			defenderField = player1.slots;
		}
		for (slot in attackerField) {
			if (slot.characterCard != null) {
				slot.characterCard.addEventListener(MouseEvent.CLICK, readyAttack);
				attacked.push(false);
			} else {
				attacked.push(true);
			}
		}
		trace(attacked);
	}
	
	/**
	 * 
	 */ 
	public function readyAttack(event:MouseEvent) {
		attacker = event.currentTarget;
		var pos = 0;
		for (slot in attackerField) {
			if (slot.characterCard != null) {
				slot.characterCard.removeEventListener(MouseEvent.CLICK, readyAttack);
				if (slot.characterCard == attacker) {
					
					var noDefenders:Bool = true;
					attacked[pos] = true;
					if (pos == 0 || pos == 1) {
						for (i in 4...6) {
							if (defenderField[i].characterCard != null) {
								noDefenders = false;
								defenderField[i].characterCard.addEventListener(MouseEvent.CLICK, attack);
							}
						}
					} else if (pos == 2 || pos == 3) {
						for (i in 2...4) {
							if (defenderField[i].characterCard != null) {
								noDefenders = false;
								defenderField[i].characterCard.addEventListener(MouseEvent.CLICK, attack);
							}
						}
					} else if (pos == 4 || pos == 5) {
						for (i in 0...2) {
							if (defenderField[i].characterCard != null) {
								noDefenders = false;
								defenderField[i].characterCard.addEventListener(MouseEvent.CLICK, attack);
							}
						}
					}
					if (noDefenders) {
						for (i in 0...pos) {
							if (attackerField[i].characterCard != null && !attacked[i]) {
								attackerField[i].characterCard.addEventListener(MouseEvent.CLICK, readyAttack);
							}
						}
						directAttack();
						break;
					}
				}
			}
			pos++;
		}
	}
	
	public function attack(event:MouseEvent) {
		trace("battle");
		var defender:Card = event.currentTarget;
		defender.removeEventListener(MouseEvent.CLICK, attack);
		trace(attacker.cardType+" vs "+defender.cardType);
		if ((attacker.cardType == 1 && defender.cardType == 2) || 
		    (attacker.cardType == 2 && defender.cardType == 3) || 
			(attacker.cardType == 3 && defender.cardType == 1)) {
			for (slot in defenderField) {
				if (defender == slot.characterCard) {
					slot.characterCard = null;
					defender.x = 700;
					defender.y = 520;
					if (player1.activePlayer) {
						player2.grave.push(defender);
					} else {
						player1.grave.push(defender);
					}
				}
			}
		}
		var finalAttack:Bool = true;
		for (i in 0...6) {
			if (!attacked[i]) {
				finalAttack = false;
				attackerField[i].characterCard.addEventListener(MouseEvent.CLICK, readyAttack);
				break;
			}
		}
		if (finalAttack) {
			changePhase();
		}
	}
	
	public function directAttack() {
		trace("direct hit");
		if (player1.activePlayer) {
			player2.grave.push(player2.topCard);
			player2.refreshDeck();
		} else {
			player1.grave.push(player1.topCard);
			player1.refreshDeck();
		}
		var finalAttack:Bool = true;
		for (hasAttacked in attacked) {
			if (!hasAttacked) {
				finalAttack = false;
				break;
			}
		}
		if (finalAttack) {
			changePhase();
		}
	}
	
	/**
	 * called when a player wishes to change the phase of a turn.
	 * Will move to the next phase, or after attack pass the turn.
	 */
	public function changePhase() {
		if (turnPhase < 2){
			turnPhase++;
			phaseInd.x += 30;
			if (turnPhase == 2) {
				startAttackPhase();
			}
		} else {
			player1.changeActive();
			player2.changeActive();
			turnPhase = 0;
			cardsPlaced = 0;
			cardsDrawn = 0;
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