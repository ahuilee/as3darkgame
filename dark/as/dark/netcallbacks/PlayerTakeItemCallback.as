package dark.netcallbacks 
{
	import dark.IGame;
	import dark.models.GameItem;
	import dark.net.DataByteArray;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerTakeItemCallback implements ICommandCallback
	{
		
		public var game:IGame = null;
		
		public function PlayerTakeItemCallback(game:IGame) 
		{
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			
			var state:int = rd.readUnsignedByte();
			
			trace("PlayerTakeItemCallback state=", state);
			
			
			switch (state) 
			{
				//APPEND
				case 1:
					var gameItem:GameItem = new GameItem();
					gameItem.id = rd.readInt();
					gameItem.templateId = rd.readUInt24();
				
					game.appendCItem(gameItem);
					break;
				//STACK
				case 2:
					var itemId  = rd.readInt();
					
					game.clearCItemInfo(itemId);
					break;
				
			}
			
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}