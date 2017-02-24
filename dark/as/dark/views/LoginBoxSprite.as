package dark.views 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author ahui
	 */
	public class LoginBoxSprite extends Sprite
	{
		
		private var _txtLabel1:TextField = null;
		
		public var txtUsername:TextField = null;
		
		private var  _btnSprite:Sprite = null;
		
		public var loginView:LoginView = null;
		
		public function LoginBoxSprite(loginView:LoginView) 
		{
			this.loginView = loginView;
			_initBtn();
				
			_txtLabel1 =  new TextField();
			_txtLabel1.textColor = 0xffffff;
			_txtLabel1.text = "使用者名稱:";
			_txtLabel1.selectable = false;
			
			
			txtUsername = new TextField();
			
			fmt = new TextFormat(txtUsername.defaultTextFormat.font, 21, 0x000000);
			
			txtUsername.type = "input";
			
			txtUsername.background = true;
			txtUsername.backgroundColor = 0xeeeeee;
			txtUsername.y = 35;
			txtUsername.width = 240;
			txtUsername.height = 30;
			txtUsername.wordWrap = false;
			txtUsername.defaultTextFormat = fmt;
			txtUsername.text = "";
			
			//txtUsername.addEventListener(TextEvent.TEXT_INPUT, _onTxtInput);
			
			addChild(_txtLabel1);
			
			addChild(txtUsername);
			
			
			
			drawBg();
			
			this.filters = [new GlowFilter(0xffffff, 0.2, 6, 6, 2), new GlowFilter(0xffffff, 0.2, 6, 6, 2)];
		}
		
		private var fmt:TextFormat = null;
		
		private function _onTxtInput(e:TextEvent)
		{
			txtUsername.setTextFormat(fmt, 0);
		}
		
		private function _initBtn():void		
		{
			var	_txtLabel2:TextField =  new TextField();
			_txtLabel2.textColor = 0xffffff;
			_txtLabel2.text = "登入或創造帳號";
			_txtLabel2.selectable = false;
			_btnSprite = new Sprite();
			
			addChild(_btnSprite);
			
			_btnSprite.addChild(_txtLabel2);
			_btnSprite.addEventListener(MouseEvent.MOUSE_OVER, _onBtnMouseOver);
			_btnSprite.addEventListener(MouseEvent.MOUSE_OUT, _onBtnMouseOut);
			_btnSprite.mouseChildren = false;
			
			_btnSprite.x = 150;
			_btnSprite.y = 160;
			
			_btnSprite.addEventListener(MouseEvent.CLICK, _onPressLogin);
			
			var g:Graphics = _btnSprite.graphics;
			
			g.clear();
			
			g.beginFill(0x336699, 1);
			g.drawRect(-10, -10, 120, 40);
			g.endFill();
			
		}
		
		private function _onPressLogin(e:MouseEvent)
		{
			loginView.game.gameLogin(txtUsername.text);
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
			
			g.clear();
			
			g.beginFill(0x222222, 1);
			g.drawRect(-30, -30, 320, 240);
			g.endFill();
		}
		
	}

}