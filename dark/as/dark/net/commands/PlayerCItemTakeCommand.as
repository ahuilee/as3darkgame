package dark.net.commands 
{
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import flash.utils.ByteArray;
		
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	public class PlayerCItemTakeCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_CITEM_TAKE;
		}
		
		public var bytes:DataByteArray = new DataByteArray();
		
		public var objKey:GameObjectKey = null;
		
		
		public function PlayerCItemTakeCommand(objKey:GameObjectKey)
		{
			this.objKey = objKey;
			
			bytes.writeObjKey(objKey);
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerCItemTakeCommand objKey=" + objKey + ">";
		}
		
	}

}