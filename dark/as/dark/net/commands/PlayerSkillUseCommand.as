package dark.net.commands 
{
	import dark.IGameObject;
	import dark.net.GameObjectKey;
	import flash.utils.ByteArray;
	import dark.net.CommandCode;
	import dark.net.DataByteArray;
	import dark.net.ICommand;
	
	
	public class PlayerSkillUseCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_SKILL_USE;
		}
		
		public var bytes:DataByteArray = new DataByteArray();		
		
		
		public function PlayerSkillUseCommand(skillId:int, objKey:GameObjectKey, x2:int, y2:int, dir2:int)
		{
			bytes.writeInt24(skillId);
			
			if (objKey != null)
			{
				bytes.writeInt(objKey.key1);
				bytes.writeInt(objKey.key2);
			
			} else
			{
				bytes.writeInt(0);
				bytes.writeInt(0);
			}
			
			
			bytes.writeInt(x2);
			bytes.writeInt(y2);
			bytes.writeByte(dir2);
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<PlayerSkillUseCommand >";
		}
		
	}

}