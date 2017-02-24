package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.DataByteArray;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerTalkWriteLineCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_TALK_WRITELINE;
		}
		
		public var bytes:DataByteArray = new DataByteArray();
		
		public var line:String = "";

		
		public function PlayerTalkWriteLineCommand(line:String)
		{
			this.line = line;		
		
			bytes.writeHStrUTF(line);
		
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerTalkWriteLineCommand line=" + line + ">";
		}
		
	}

}