package dark.net.commands 
{
	import dark.net.CommandCode;
	import dark.net.DataByteArray;
	import dark.net.ICommand;
	import flash.utils.ByteArray;
	
	public class MapChunkLoadCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.MAP_CHUNK_LOAD;
		}
		
		public var bytes:DataByteArray = new DataByteArray();
		
		public var mapId:int = 0;
		public var chunkX:int = 0;
		public var chunkY:int = 0;
		
		public function MapChunkLoadCommand(mapId:int, chunkX:int, chunkY:int)
		{
			this.mapId = mapId;
			this.chunkX = chunkX;
			this.chunkY = chunkY;
			
			bytes.writeInt24(mapId);
			bytes.writeInt(chunkX);
			bytes.writeInt(chunkY);
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}		
		
		public function toString():String
		{
			return "<MapChunkLoadCommand x=" + chunkX + " y=" + chunkY + ">";
		}
		
	}

}