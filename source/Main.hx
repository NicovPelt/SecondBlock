package;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import cards.*;
import openfl.geom.Matrix;
import openfl.display.Bitmap;
import haxe.Timer;
import openfl.text.TextField;

class Main extends Sprite {
	
	var startbutton:Menubutton = new Menubutton("assets/img/MenuButtonStart.png", "assets/img/MenuButtonStartHover.png");
	var exitbutton:Menubutton = new Menubutton("assets/img/MenuButtonExit.png", "assets/img/MenuButtonExitHover.png");

	var player1:Player;
	var player2:Player;
	var director:Director;
	
	var board:Sprite;

	var animationframe:Bitmap;
	var framenumber:Int = 1;
	
	var battleText:TextField; //This is the text showing while a attack animation is playing.

	public function new()
	{
		super();

		startanimation();
		drawbackground();
		drawmenu();
		
	}	
	/*
	*startanimation function gets called when the game starts
	*it shows a 60 frame long animation
	*/
	function startanimation()
	{
		if (framenumber==1)
		{
			animationframe=new Bitmap(Assets.getBitmapData("assets/start animation/start1.png"));				
			addChild(animationframe);
			framenumber++;
			Timer.delay(startanimation,100);

		}else if(framenumber<61)
		{
			removeChild(animationframe);
			animationframe=new Bitmap(Assets.getBitmapData("assets/start animation/start"+framenumber+".png"));
			addChild (animationframe);
			framenumber++;
			Timer.delay(startanimation,100);
		}else 
		{
			removeChild(animationframe);
			framenumber=1;
		}
	
	}



	function startGame(e:MouseEvent) 
	{
		removeChildren ();
		
		/*
		 * initializing board
		 */
		board = new Sprite();
		var bitmapData = new Bitmap (Assets.getBitmapData ("assets/BoardDigital.png"));
		var scale = new Matrix(1.3333333, 0, 0, 1.333333, 0, 0);
		//board.graphics.beginBitmapFill(bitmapData, scale);
		board.graphics.drawRect(0, 0, 800, 600);
		addChild(bitmapData);
	 
		/*
		 * initializing card graphics
		 * TODO adding effect and trapcard graphics
		 * 		finalizing all card graphics
		 */
		Card.cardGraphics = new Array<BitmapData>();
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/cardbackside.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Scissorman.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Spider.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Owl.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Bookworm.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Elephant.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Stickman.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Golem.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Jaba.png"));
		Card.cardGraphics.push(Assets.getBitmapData ("assets/cards/Stone.png"));
		
		/*
		 * initializing players and director
		 * true = starting player
		 */
		director = new Director(this);
		player1 = new Player(director, this, true);
		player2 = new Player(director, this, false);
		director.player1 = player1;
		director.player2 = player2;
	}

	function exit(e:MouseEvent){
	//	Sys.exit(0);
	}

	function drawbackground(){
		var background = new Bitmap(Assets.getBitmapData("assets/img/Background.png"));
		addChild(background);
		
	}	
	
	function drawmenu(){
		startbutton.x = (stage.stageWidth - startbutton.width) / 2;
		startbutton.y = (stage.stageHeight - startbutton.height) / 2 - 25;
		
		exitbutton.x = (stage.stageWidth - exitbutton.width) / 2;
		exitbutton.y = (stage.stageHeight - exitbutton.height) / 2 + 25;
		
		addChild(startbutton);
		addChild(exitbutton);
		startbutton.addEventListener(MouseEvent.CLICK, startGame);
		exitbutton.addEventListener(MouseEvent.CLICK, exit);
	}
	
	public function drawBattleText() {
		battleText = new TextField();
		addChild(battleText);
		battleText.text = "Battle!";
		battleText.textColor = 0x000000;
		//battleText.textFieldType = Dynamic;
		//battleText.textHeight = 20;
		//battleText.textWidth = 20;
		battleText.x = 400;
		battleText.y = 35;
		Timer.delay (removeBattleText, 3000);
	}
	function removeBattleText() {
		removeChild(battleText);
	}
}