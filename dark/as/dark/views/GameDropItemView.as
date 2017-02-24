package dark.views 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;	
	import flash.geom.Rectangle;
	
	import dark.net.commands.PlayerItemDropCommand;
	import dark.netcallbacks.PlayerItemDropCallback;
	import dark.netcallbacks.IPlayerItemDropCallbackDelegate;
	import dark.ui.CItemShortcutDelegate;
	import dark.ui.ItemSprite;
	import dark.IGame;	
	import dark.IGameDragEnterDelegate;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameDropItemView extends Sprite  implements IGameDragEnterDelegate
	{
		
		public var game:IGame = null;
		private var _hitTestDragEnterRect:Rectangle = null;
	
		
		public function GameDropItemView(game:IGame) 
		{
			this.game = game;
			
			_hitTestDragEnterRect = new Rectangle(0, 0, 320, 240);		
		
			
			this.addEventListener(Event.ADDED_TO_STAGE, _addToStage);
		}
		
		
		
		private function _addToStage(e:Event):void
		{
			_resize();
			draw();
			stage.addEventListener(Event.RESIZE, _onStageResize);
		}
		
		private function draw():void		
		{
			/*
			this.graphics.clear();
			this.graphics.lineStyle(2, 0xff0000);
			this.graphics.drawRect(0, 0, _hitTestDragEnterRect.width, _hitTestDragEnterRect.height);
			*/
		}
		
		private function _resize():void
		{
			if (stage != null)
			{
				_hitTestDragEnterRect.width  = stage.stageWidth;
				_hitTestDragEnterRect.height  = stage.stageHeight - 100;
			
			}
			draw();
		}
		
		private function _onStageResize(e:Event):void
		{
			_resize();		
		}
		
		
		public function setDragEnterObj(obj:*):void
		{
			
			
			if (obj is CItemShortcutDelegate)
			{	
				
				var delegate:CItemShortcutDelegate = obj as CItemShortcutDelegate;
				
				trace("Drop", delegate);
				
				var dropCmd:PlayerItemDropCommand = new PlayerItemDropCommand(delegate.gameItem.id);
				
				game.writeCommand(dropCmd, new PlayerItemDropCallback(new PlayerDropItemDelegate(delegate.gameItem, game)));
				
			}
			
		}
		
		public function hitTestDragEnter(stage:Stage):Boolean
		{
			//trace("hitTestDragEnter", _hitTestDragEnterRect.contains(mouseX, mouseY));
			if (this.visible)
			{
				if (this._hitTestDragEnterRect.contains(mouseX, mouseY))
				{
					return true;
				}
				
			}
			
			
			return false;
		}
		
	}

}