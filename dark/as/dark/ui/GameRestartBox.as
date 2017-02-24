package dark.ui 
{
	import dark.Game;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ahui
	 */
	public class GameRestartBox extends Sprite
	{
		
		private var _btnSprite:Sprite = null;
		
		
		public var game:Game = null;
		
		public function GameRestartBox(game:Game) 
		{
			this.game = game;	
			_initBtn();	
			drawBg();
		}
		
		
		private function _initBtn():void		
		{
			var	_txtLabel2:TextField =  new TextField();
			_txtLabel2.textColor = 0xffffff;
			
			_txtLabel2.selectable = false;
			_txtLabel2.autoSize = TextFieldAutoSize.LEFT;
			_txtLabel2.text = "重新開始";
			_txtLabel2.width = 120;
			_txtLabel2.alpha = 0.7;
			_txtLabel2.x = 50;
			
			_btnSprite = new Sprite();
			
			addChild(_btnSprite);
			
			_btnSprite.addChild(_txtLabel2);
			_btnSprite.addEventListener(MouseEvent.MOUSE_OVER, _onBtnMouseOver);
			_btnSprite.addEventListener(MouseEvent.MOUSE_OUT, _onBtnMouseOut);
			_btnSprite.mouseChildren = false;
			
			_btnSprite.x = 50;
			_btnSprite.y = 50;
			
			_btnSprite.addEventListener(MouseEvent.CLICK, _onPressBtn);
			
			var g:Graphics = _btnSprite.graphics;
			
			g.clear();
			
			g.beginFill(0x336699, 1);
			g.drawRect(-10, -10, 160, 40);
			g.endFill();
			
		
		}
		
		private function _onPressBtn(e:MouseEvent)
		{
			game.gameRestart(null);
		}
		
		
		private function _onBtnMouseOut(e:MouseEvent)
		{
			_btnSprite.filters = [];
		}
		
		private function _onBtnMouseOver(e:MouseEvent)
		{
			
			_btnSprite.filters = [new GlowFilter(0xffffff, 1, 6, 6)];
		}
		
		public function drawBg():void
		{
			var g:Graphics = this.graphics;
			
			g.beginFill(0x000000, 0.8);
			g.drawRect( -30, -30, 320, 240);
			
			g.endFill();
			
			
		}
		
	}

}