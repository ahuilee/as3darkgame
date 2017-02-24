package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerCharacterInfoCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_CHARACTER_INFO;
		}
		
		public var bytes:ByteArray = new ByteArray();
		

		
		public function PlayerCharacterInfoCommand()
		{
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerCharacterInfoCommand>";
		}
		
	}

}