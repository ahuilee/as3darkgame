package dark.net.commands 
{
	import flash.utils.ByteArray;
		
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	public class PlayerGetShortcutInfoCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_GET_SHORTCUT_INFO;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public var itemId:int = 0;
		
		
		public function PlayerGetShortcutInfoCommand()
		{
			
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerGetShortcutInfoCommand itemId=" + itemId + ">";
		}
		
	}

}