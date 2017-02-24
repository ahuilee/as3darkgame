package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.DataByteArray;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerTeleportDoneCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_TELEPORT_DONE;
		}
		
		public var bytes:DataByteArray = new DataByteArray();
		

		public function PlayerTeleportDoneCommand(mapId:int, x2:int, y2:int)
		{
			
			bytes.writeInt24(mapId);		
			bytes.writeInt(x2);		
			bytes.writeInt(y2);		
			
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerMapLoadCommand >";
		}
		
	}

}