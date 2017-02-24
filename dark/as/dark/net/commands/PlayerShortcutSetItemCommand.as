package dark.net.commands 
{
	import flash.utils.ByteArray;
		
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	public class PlayerShortcutSetItemCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_SHORTCUT_SETITEM;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		
		
		
		public function PlayerShortcutSetItemCommand(idx:int, type:int, shortcutId:int)
		{		
			bytes.writeByte(idx);
			bytes.writeByte(type);
			bytes.writeInt(shortcutId);
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}
		
		public function toString():String
		{
			return "<PlayerShortcutSetItemCommand >";
		}
		
	}

}