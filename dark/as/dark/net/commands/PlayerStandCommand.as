package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerStandCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_STAND;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public var x2:int = 0;
		public var y2:int = 0;
		public var direction:int = 0;
		
		public function PlayerStandCommand(x2:int, y2:int, direction:int)
		{
			this.x2 = x2;
			this.y2 = y2;
			this.direction = direction;
			
			bytes.writeInt(x2);
			bytes.writeInt(y2);
			bytes.writeByte(direction);
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		public function toString():String
		{
			return "<PlayerStandCommand x2=" + x2 + " y2=" + y2 + ">";
		}
		
	}

}