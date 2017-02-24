package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.GameObjectKey;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class GetObjInfoCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GET_OBJINFO;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public function GetObjInfoCommand(objKeys:Array) 
		{
			
			bytes.writeShort(objKeys.length);
			for (var i:int = 0; i < objKeys.length; i++)
			{
				var key:GameObjectKey = objKeys[i];
				
				bytes.writeInt(key.key1);
				bytes.writeInt(key.key2);
			}
		
			
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}
		
	}

}