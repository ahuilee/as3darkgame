package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerWalkToCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_WALKTO;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public var x2:int = 0;
		public var y2:int = 0;
		public var direction:int = 0;
		
		public function PlayerWalkToCommand(x1:int, y1:int, direction:int, x2:int, y2:int)
		{
			this.x2 = x2;
			this.y2 = y2;
			this.direction = direction;
			
			bytes.writeInt(x1);
			bytes.writeInt(y1);
			bytes.writeByte(direction);
			
			bytes.writeInt(x2);
			bytes.writeInt(y2);
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerWalkToCommand x2=" + x2 + " y2=" + y2 + ">";
		}
		
	}

}