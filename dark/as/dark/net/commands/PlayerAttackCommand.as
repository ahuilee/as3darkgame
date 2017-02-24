package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.GameObjectKey;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class PlayerAttackCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_ATTACK;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public function PlayerAttackCommand(objKey:GameObjectKey) 
		{
			bytes.writeInt(objKey.key1);
			bytes.writeInt(objKey.key2);
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}
		
	}

}