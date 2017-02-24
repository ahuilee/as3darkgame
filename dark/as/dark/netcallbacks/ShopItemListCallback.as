package dark.netcallbacks 
{

	
	import dark.models.GameItem;
	import dark.Game;
	import dark.LazyGameShopMouseDelegate;
	import dark.net.DataByteArray;	
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	
	/**
	 * ...
	 * @author 
	 */
	public class ShopItemListCallback implements ICommandCallback
	{
		
		public var game:Game = null;
		
		public function ShopItemListCallback(game:Game) 
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
				var item:ShopItemData = new ShopItemData();			
			
				
				item.shopItemId = rd.readInt();
				item.templateId = rd.readInt24();
			
				item.name = rd.readBStr();		
			
				items.push(item);
			}
			
			game.shopItemListView.loadItems(items);
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}