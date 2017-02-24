package dark.net.commands 
{
	
	import flash.utils.ByteArray;
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	
	public class GameInitCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GAME_INIT;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public function GameInitCommand()
		{

			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<GameLoadDoneCommand >";
		}
		
	}

}