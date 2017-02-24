package dark.net.commands 
{
	import flash.utils.ByteArray;
		
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	public class PlayerItemDropCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_ITEM_DROP;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public var itemId:int = 0;
		
		
		public function PlayerItemDropCommand(itemId:int)
		{
			this.itemId = itemId;
			
			bytes.writeInt(itemId);
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerItemDropCommand itemId=" + itemId + ">";
		}
		
	}

}