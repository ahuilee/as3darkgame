package dark.ui 
{
	import dark.netcallbacks.IPlayerItemUseCallbackDelegate;
	import dark.netcallbacks.ItemUseResultOpCodes;
	/**
	 * ...
	 * @author 
	 */
	public class ItemListViewItemUseCallbackDelegate implements IPlayerItemUseCallbackDelegate
	{
		
		public var itemSprite:ItemSprite = null;
		public var listView:ItemListView = null;
		
		public function ItemListViewItemUseCallbackDelegate(itemSprite:ItemSprite, listView:ItemListView) 
		{
			this.itemSprite = itemSprite;
			this.listView = listView ;
		}
		
		
		public function onPlayerItemUseCallback(opCode:int):void
		{
			switch (opCode) 
			{
				case ItemUseResultOpCodes.RESULT_DELETE:
					listView.removeItemSprite(itemSprite);
					break;
						
				case ItemUseResultOpCodes.RESULT_GETINFO:
					listView.displayItemInfo(itemSprite.gameItem, false);
					listView.game.reloadCharInfo();
					break;
						
				case ItemUseResultOpCodes.RESULT_CLEARDICT:
					listView.game.cItemInfoFactory.clearGetInfoDict();
					break;
				default:
			}
		}
		
	}

}