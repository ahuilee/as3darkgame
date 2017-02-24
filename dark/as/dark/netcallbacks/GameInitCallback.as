package dark.netcallbacks
{
	
	
	import dark.GameInitSet;
	import dark.models.GameInitData;
	import dark.LazyGameConnDelegate;
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import dark.net.ICommandCallback;
	import dark.net.Packet;

	import flash.utils.ByteArray;
	
	public class GameInitCallback implements ICommandCallback
	{
		
		public var initSet:GameInitSet = null;
		
		public function GameInitCallback(initSet:GameInitSet) 
		{
			this.initSet = initSet;
		}
		
		
		public function success(ask:int, packet:Packet):void
		{

			var rd:DataByteArray = packet.body;
			
			var data:GameInitData = new GameInitData();
			
			data.mapId = rd.readUInt24();
			data.mapChunkWidth = rd.readUnsignedShort();
			data.mapChunkHeight = rd.readUnsignedShort();
			
			var assetItemCount:int = rd.readUnsignedShort();
			
			var assetPks:Array = [];
			
			for (var i:int = 0; i < assetItemCount; i++)
			{
				var assetId:int = rd.readUnsignedShort();
				assetPks.push(assetId);
			}
			
			data.assetPks = assetPks;
			
			initSet.onGameInitCallback(data);
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}