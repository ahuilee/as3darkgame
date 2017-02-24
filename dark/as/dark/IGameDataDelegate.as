package dark 
{
	
	import dark.net.GameSyncData;	
	import dark.views.IGetMapChunkCallback;
	
	public interface IGameDataDelegate 
	{
		
		function getMapChunkData(mapId:int, chunkX:int, chunkY:int, callback:IGetMapChunkCallback):void;
		
		
		
	}
	
}