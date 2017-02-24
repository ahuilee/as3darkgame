package dark.net.commands 
{
	import dark.net.GameObjectKey;
	import flash.utils.ByteArray;
	
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	
	public class ShopItemListCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.SHOP_ITEM_LIST;
		}
		
		public var bytes:ByteArray = new ByteArray();		
		
		
		public function ShopItemListCommand(objKey:GameObjectKey)
		{
		
			bytes.writeInt(objKey.key1);
			bytes.writeInt(objKey.key2);
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<ShopItemListCommand >";
		}
		
	}

}