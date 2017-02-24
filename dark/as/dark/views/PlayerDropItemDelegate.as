package dark.views 
{
	import dark.IGame;
	import dark.models.GameItem;
	import dark.netcallbacks.IPlayerItemDropCallbackDelegate;
	/**
	 * ...
	 * @author 
	 */
	public class PlayerDropItemDelegate implements IPlayerItemDropCallbackDelegate
	{
		
		public var gameItem:GameItem  = null;
		public var game:IGame = null;
		
		public function PlayerDropItemDelegate(gameItem:GameItem , game:IGame) 
		{
			this.gameItem = gameItem;
			this.game = game;
		}
		
		public function onPlayerItemDropCallback(state:int):void
		{
			if (state == 0x01)
			{
				game.deleteCItem(gameItem.id);
				
			}
			
			
		}
		
	}

}