package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerItemListCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_ITEM_LIST;
		}
		
		public var bytes:ByteArray = new ByteArray();		
		
		
		public function PlayerItemListCommand()
		{
		
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerItemListCommand >";
		}
		
	}

}