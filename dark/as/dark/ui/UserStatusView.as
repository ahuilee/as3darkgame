package dark.ui 
{
	import dark.Game;
	import flash.display.Graphics;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ahui
	 */
	public class UserStatusView extends LazyBoxSprite
	{
		public var game:Game = null;
		
		public var txtCharLevel:TextField = null;
		public var txtCharDef:TextField = null;
		public var txtCharWeighted:TextField = null;
			
		public function UserStatusView(viewWidth:int, viewHeight:int, game:Game) 
		{
			this.game = game;
			
			super(viewWidth, viewHeight, game.app);
			
			txtCharLevel =  createTextField(30, 10);
			txtCharDef =  createTextField(30, 30);
			txtCharWeighted = createTextField(30, 50);
			
			addChild(txtCharLevel);
			addChild(txtCharDef);
			addChild(txtCharWeighted);
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
			
			drawBgStyle3();
			
		}
		
	}

}