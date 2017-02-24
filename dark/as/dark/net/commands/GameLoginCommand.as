package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.DataByteArray;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class GameLoginCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GAME_LOGIN;
		}
		
		public var bytes:DataByteArray = new DataByteArray();
		
		public var username:String = "";

		
		public function GameLoginCommand(username:String)
		{
			this.username = username;			
			
			bytes.writeBStr(username);		
			
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<GameLoginCommand username=" + username + ">";
		}
		
	}

}