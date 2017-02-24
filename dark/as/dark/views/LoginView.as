package dark.views 
{
	import dark.Game;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class LoginView extends Sprite
	{
		
		
		public var game:Game = null;
		
		
		public var loginBox:LoginBoxSprite = null;
		
		public function LoginView(game:Game) 
		{
			this.game = game;
			
			loginBox = new LoginBoxSprite(this);
			
			addChild(loginBox);
			
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
			
		}
		
	
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			g.beginFill(0x000000, 1);
			g.drawRect(0, 0, this.stage.stageWidth, stage.stageHeight);
			g.endFill();
		}
		
		private function _onStageResize(e:Event):void
		{
			draw();
		}
		
		
		
		private function _onRemoveFromStage(e:Event):void
		{
			stage.removeEventListener(Event.RESIZE, _onStageResize);
		}
		
		private function _onAddedToStage(e:Event):void
		{
			draw();
			stage.addEventListener(Event.RESIZE, _onStageResize);
			
			loginBox.x = stage.stageWidth / 2 - loginBox.width / 2;
			loginBox.y = stage.stageHeight * 0.2;
			
			stage.focus = loginBox.txtUsername;
			
		}
		
		
		
		
	}

}