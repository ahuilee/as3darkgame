package dark.net.commands 
{
	
	import flash.utils.ByteArray;
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	
	public class GameStartCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GAME_START;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public var characterId:int = 0;

		
		public function GameStartCommand(characterId:int)
		{
			this.characterId = characterId;			
			
			bytes.writeInt(characterId);	

			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<GameStartCommand characterId=" + characterId + ">";
		}
		
	}

}