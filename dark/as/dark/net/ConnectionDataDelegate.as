package dark.net 
{
	import dark.IGameDataDelegate;
	import dark.MapChunkData;
	import dark.netcallbacks.*;
	import dark.net.commands.*;
	import dark.views.IGetMapChunkCallback;
	
	public class ConnectionDataDelegate implements IGameDataDelegate
	{
		
		public var conn :Connection  = null;
		
		public function ConnectionDataDelegate(conn:Connection) 
		{
			this.conn = conn;
		}
		
		
		public function getMapChunkData(mapId:int, chunkX:int, chunkY:int, callback:IGetMapChunkCallback):void
		{
			
			var cmd:MapChunkLoadCommand = new MapChunkLoadCommand(mapId, chunkX, chunkY);
			
			
			conn.writeCommand(cmd, new MapChunkLoadCallback(callback));
			
		}
		
	}

}