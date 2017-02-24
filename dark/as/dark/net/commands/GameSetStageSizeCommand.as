package dark.net.commands 
{
	import flash.utils.ByteArray;
	
	import dark.net.DataByteArray;	
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	
	public class GameSetStageSizeCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GAME_SET_STAGESIZE;
		}
		
		public var bytes:DataByteArray = new DataByteArray();
		
		public function GameSetStageSizeCommand(stageWidth:int, stageHeight:int)
		{
			bytes.writeInt24(stageWidth);
			bytes.writeInt24(stageHeight);

			
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