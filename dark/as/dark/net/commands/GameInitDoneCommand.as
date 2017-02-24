package dark.net.commands 
{
	
	import flash.utils.ByteArray;
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	
	public class GameInitDoneCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GAME_INIT_DONE;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public function GameInitDoneCommand()
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