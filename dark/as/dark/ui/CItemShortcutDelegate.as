package dark.ui 
{
	
	import flash.display.BitmapData;
		
	import dark.models.GameItem;
	import dark.Game;
	import dark.netcallbacks.IPlayerItemUseCallbackDelegate;
	import dark.netcallbacks.ItemUseResultOpCodes;

	/**
	 * ...
	 * @author 
	 */
	public class CItemShortcutDelegate implements IShortcutItemSource, IShortcutItemUseDelegate, IPlayerItemUseCallbackDelegate
	{
		
		public var gameItem:GameItem = null;
		public var game:Game = null;
		
		public function CItemShortcutDelegate(gameItem:GameItem, game:Game) 
		{
			this.gameItem = gameItem;
			this.game = game;
		}		
		
		
		public function getStorageType():int
		{
			return 0x02;
		}
		
		public function getStorageId():int
		{
			return gameItem.id;
		}
		
		
		public function onPlayerItemUseCallback(opCode:int):void
		{
			
			trace("onPlayerItemUseCallback", opCode);
			
			switch (opCode) 
			{
				case ItemUseResultOpCodes.RESULT_DELETE:
					
					break;
						
				case ItemUseResultOpCodes.RESULT_GETINFO:
					
					game.cItemInfoFactory.displayItemInfoBySprite(game.shortcutsItemListView.displayInfoSprite, gameItem, false);
					
					game.reloadCharInfo();
					
					break;
						
				case ItemUseResultOpCodes.RESULT_CLEARDICT:
					game.cItemInfoFactory.clearGetInfoDict();
					break;
				default:
			}
		}
		

		public function getShortcutItemUseDelegate():IShortcutItemUseDelegate
		{
			return this;
		}
		
		public	function onShortcutItemUse():void
		{
			trace("onShortcutUse", this);
			
			game.cItemInfoFactory.itemUse(gameItem.id, this);
		}
		
		public function displayShortcutItemInfo(infoSprite:DisplayItemInfoSprite):void
		{
			
			trace("displayShortcutItemInfo", infoSprite);
			
			game.cItemInfoFactory.displayItemInfoBySprite(infoSprite, gameItem, true);

		}
		
		
		public function getShortcutItemBitmapData():BitmapData
		{
			
			var key:String = game.app.makeTIKeyByTemplateId(gameItem.templateId);
			
			
			return game.app.getIconBdByKey(key);
		}
		
	}

}