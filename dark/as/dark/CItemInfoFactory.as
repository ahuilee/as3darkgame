package dark 
{
	
	import flash.utils.Dictionary;
	
	import dark.net.commands.PlayerItemUseCommand;
	import dark.net.ICommandCallback;
	import dark.netcallbacks.IPlayerItemUseCallbackDelegate;
	import dark.netcallbacks.PlayerItemUseCallback;
	import dark.ui.DisplayItemInfoSprite;
	import dark.models.CItemInfo;
	import dark.models.GameItem;
	import dark.net.commands.PlayerItemInfoCommand;	
	import dark.netcallbacks.PlayerItemInfoCallback2;
	/**
	 * ...
	 * @author 
	 */
	public class CItemInfoFactory 
	{
		
		public var game:Game = null;
		private var _getItemInfoById:Dictionary = new Dictionary();
		
		public function CItemInfoFactory(game:Game) 
		{
			this.game = game;
		}
		
		public function itemUse(itemId:int, delegate:IPlayerItemUseCallbackDelegate):void
		{
		
			var useCmd:PlayerItemUseCommand = new PlayerItemUseCommand(itemId);
			game.conn.writeCommand(useCmd, new PlayerItemUseCallback(delegate));
		}
		
		/*
		public function clearInfoByItemId(itemId:int):void
		{
			if (_getItemInfoById[itemId] != undefined && _getItemInfoById[itemId] == null)
			{
				delete _getItemInfoById[itemId];
			}
		}*/
		
		public function clearGetInfoDict():void
		{
			for (var key:String in _getItemInfoById)
			{
				//trace("delete _getItemInfoById", key);
				delete _getItemInfoById[key];
			}
		}
		
		public function onItemInfoCallback(itemId:int, info:CItemInfo):void
		{
			_getItemInfoById[itemId] = info;
		}
		
		
		public function displayItemInfoBySprite(infoSprite:DisplayItemInfoSprite, gameItem:GameItem, useDict:Boolean=true):void
		{
			var info:CItemInfo = null;
			
			if (useDict)
			{
				info = _getItemInfoById[gameItem.id];
			}
			
			if (info == null)
			{
				var cmd:PlayerItemInfoCommand = new PlayerItemInfoCommand(gameItem.id);
				game.conn.writeCommand(cmd, new PlayerItemInfoCallback2(infoSprite, gameItem.id, this));				
			}
			
			if (info != null)
			{
				infoSprite.setItemInfo(info);
			}
			
		}
		
	}

}