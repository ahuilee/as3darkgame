package dark 
{
	import dark.net.commands.ShopItemListCommand;
	import dark.netcallbacks.ShopItemListCallback;
	
	public class LazyGameShopMouseDelegate implements IGameLazyObjMouseDelegate
	{
		
		public var objSet:LazyGameSyncObjSet = null;
		
		public function LazyGameShopMouseDelegate(objSet:LazyGameSyncObjSet) 
		{
			this.objSet = objSet;
		}
		
		
		
		
		public function calcPressWork(game:Game):Array
		{
			
			var hitTalkBound:Boolean = game.player.talkBound.contains(objSet.gamePt.x, objSet.gamePt.y);
			trace("hitTalkBound", hitTalkBound);
			if (hitTalkBound)
			{
				game.toggleShowShopItemListView(objSet.objKey);
				
			}
			
			return null;
			
		}
		
	}

}