package dark.netcallbacks 
{
	
	import dark.Game;
	import dark.views.IGetMapChunkCallback;
	import flash.geom.Rectangle;
	
	import dark.MapChunkData;
	import dark.MapChunkNode;
	import dark.net.DataByteArray;
	import dark.net.ICommandCallback;
	import dark.net.Packet;

	/**
	 * ...
	 * @author ahui
	 */
	public class MapChunkLoadCallback implements ICommandCallback
	{
		
		public var callback:IGetMapChunkCallback = null;
		
		public function MapChunkLoadCallback(callback:IGetMapChunkCallback) 
		{
			this.callback = callback;
		}
		
		
		public function success(ask:int, packet:Packet):void
		{
		
			if (callback == null)
			{
				trace(">>>>>> callback is NULL!!!!!!!!!!!!");
				return;
			}
			
			var rd:DataByteArray = packet.body;
			var tailCount:int = packet.body.readShort();
			var nodeCount:int = packet.body.readShort();
			var blockCount:int = packet.body.readShort();
			
			//trace("MapChunkLoadCallback success nodeCount=", nodeCount, "blockCount=", blockCount);
				
			var mapChunkData:MapChunkData = new MapChunkData();
			
			var i:int = 0;
			
			for (i = 0; i < tailCount; i++)
			{
				var tail:int = rd.readInt();
				mapChunkData.tails.push(tail);
				//trace("tail", i, "/", count, tail);
			}
			
			for (i = 0; i < nodeCount; i++)
			{

				var node:MapChunkNode = new MapChunkNode();
				
				node.templateId = rd.readInt();
				node.x = rd.readShort();
				node.y = rd.readShort();
				
				mapChunkData.nodes.push(node);
				//trace("tail", i, "/", count, tail);
			}
			
			for (i = 0; i < blockCount; i++)
			{
				var block:Rectangle = new Rectangle();
				block.x = rd.readInt();
				block.y = rd.readInt();
				block.width = rd.readShort();
				block.height = rd.readShort();
				
				mapChunkData.blocks.push(block);
			}
			
			
			if (callback != null)
			{
				callback.callback(mapChunkData);
			}
			
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}