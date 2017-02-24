package dark.netcallbacks 
{
	
	import dark.models.GameItem;
	import dark.Game;
	import dark.net.DataByteArray;

	import flash.utils.ByteArray;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	
	
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerItemListCallback  implements ICommandCallback
	{
		
		public var game:Game = null;
		
		public function PlayerItemListCallback(game:Game) 
		{
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			
			var items:Array = [];
			
			var count:int = rd.readInt24();
			
			
			//trace("ItemListCallback count=", count);
			
			for (var i:int = 0; i < count; i++)
			{
				var item:GameItem = new GameItem();			
			
				
				item.id = rd.readInt();
				item.templateId = rd.readInt24();
				
				//item.countText = rd.readIntN();		
			
				//item.name = rd.readBStr();			
			
				items.push(item);
			}
			
			
			
			game.itemListView.loadItemList(items);
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}