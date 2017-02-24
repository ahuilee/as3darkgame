package dark.ui 
{
	import flash.display.Graphics;
	import dark.Game;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ahui
	 */
	public class CharacterInfoView  extends LazyBoxSprite
	{
		
		
		public var game:Game = null;
		
		public var container:Sprite = null;
		public var txtCharStr:TextField = null;
		public var txtCharInt:TextField = null;
		public var txtCharDex:TextField = null;
		public var txtCharCon:TextField = null;
		public var txtCharSpi:TextField = null;
		
		private var _hitRect:Rectangle = new Rectangle();

			
		public function CharacterInfoView(viewWidth:int, viewHeight:int, game:Game) 
		{
			this.game = game;
			
			_hitRect.width = viewWidth;
			_hitRect.height = viewHeight;
			super(viewWidth, viewHeight, game.app);
			
			
			container = new Sprite();
			container.x = 10;
			container.y = 10;
			addChild(container);
			
			txtCharStr = createTextField(30, 60);
			txtCharDex = createTextField(30, 80);
			txtCharCon = createTextField(30, 100);
			
			txtCharInt = createTextField(120, 60);
			txtCharSpi = createTextField(120, 80);
			
			container.addChild(txtCharStr);
			container.addChild(txtCharInt);
			container.addChild(txtCharDex);
			container.addChild(txtCharCon);
			container.addChild(txtCharSpi);
		}
		
		public function checkMouseInUI():Boolean
		{
			if (visible)
			{
				if (_hitRect.contains(mouseX, mouseY))
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function createTextField(x:int, y:int):TextField
		{
			var tf:TextField =  new TextField();
			tf.textColor = 0xffffff;
			tf.selectable = false;
			tf.x = x;
			tf.y = y;
			return tf;
		}
		
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			//g.clear();
			
			drawBgStyle4();
			
		}
		
	}

}