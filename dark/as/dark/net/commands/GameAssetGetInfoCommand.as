package dark.net.commands 
{
	
	import dark.net.DataByteArray;
	import flash.utils.ByteArray;
	import dark.net.CommandCode;
	import dark.net.ICommand;
	
	
	public class GameAssetGetInfoCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.GAME_ASSET_GETINFO;
		}
		
		public var bytes:DataByteArray = null;
		
		public function GameAssetGetInfoCommand(assetPks:Array)
		{
			bytes = new DataByteArray();
			bytes.writeUInt16(assetPks.length);
			
			for (var i:int = 0; i < assetPks.length; i++)
			{
				var assetPk:int = assetPks[i];
				bytes.writeUInt16(assetPk);
			}
			
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}

		
		
		public function toString():String
		{
			return "<GameAssetGetInfoCommand >";
		}
		
	}

}