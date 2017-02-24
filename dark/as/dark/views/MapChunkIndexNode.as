package dark.views 
{
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ahui
	 */
	public class MapChunkIndexNode implements IMapChunkIndexNode
	{
		
		public var chunkBound:Rectangle = null;
		
		
		public var chunks:Array = [];
		public var indexFlashViewRect:Rectangle = null;	
		public var isInit:Boolean = false;	
		
		public var gameView:LazyGameView = null;
		
		public function MapChunkIndexNode(chunkBound:Rectangle, indexFlashViewRect:Rectangle, gameView:LazyGameView) 
		{
			
			this.chunkBound = chunkBound;
		
			this.indexFlashViewRect = indexFlashViewRect;
			this.gameView = gameView;
			isInit = false;
		}
		
		public function hitTest(flashViewRect:Rectangle):Boolean
		{
		
			var hit:Boolean = indexFlashViewRect.intersects(flashViewRect);
			trace("hit", this, indexFlashViewRect, flashViewRect, hit);
			
			return hit;
		}
		
		public function getMapChunks(flashViewRect:Rectangle):Array
		{
			
			if (!indexFlashViewRect.intersects(flashViewRect))
			{
				return new Array();
			}
			
			if (!isInit) {
				
				init();
				isInit = true;
			}
			
			trace("MapChunkIndexNode getMapChunks", this, chunks.length);
			
			var output:Array = [];
			
			if (chunks != null)
			{			
				/*
				for (var i:int = 0; i < chunks.length; i++)
				{
					var chunk:MapChunk = chunks[i];
					
					if (chunk == null) continue;
					
					trace("MapChunkIndexNode getMapChunks", i + "/" + chunks.length, "chunk.chunkRect", chunk.chunkRect);
					
					if (chunk.chunkRect.intersects(flashViewRect))
					{
						output.push(chunk);
					}				
				}*/
			}
			
			
			return output;
		}
		
		
		public function init()
		{
			
			chunks.length =  0;
		
			for (var x:int = 0; x < chunkBound.width; x++)
			{
				for (var y:int = 0; y < chunkBound.height; y++)
				{
					var mapChunk:MapChunk = new MapChunk(gameView);
					
					mapChunk.chunkX = (chunkBound.x+x);
					mapChunk.chunkY = (chunkBound.y+x);
					
					var rectX:int  = mapChunk.chunkX * MapChunk.MAPCHUNK_WIDTH;
					var rectY:int  =  mapChunk.chunkY * MapChunk.MAPCHUNK_HEIGHT;					
					
					
					mapChunk.gameRect = new Rectangle(rectX, rectY, MapChunk.MAPCHUNK_WIDTH, MapChunk.MAPCHUNK_HEIGHT);					
					//var isoPt:Point = calcIsoPt(rectX, rectY);
					
					var pt2:Point = gameView.chunkPtToFlashPt(mapChunk.chunkX, mapChunk.chunkY);					
					//pt2.x = (rectX - rectY) * 
					
					mapChunk.chunkRect = new Rectangle(pt2.x, pt2.y, MapChunk.CHUNK2D_WIDTH, MapChunk.CHUNK2D_WIDTH);	
					
					chunks.push(mapChunk);
					
					//trace("MapChunkIndexNode init create Chunk", this);			
					//mapRects.push(mapRect);
				}
			}
			
			
		}
		
		
		
		public function unload():void
		{
			
			for (var i:int = 0; i < chunks.length; i++)
			{
				var chunk:MapChunk = chunks[i];
				
				if (chunk.isLoaded)
				{
					
					var centerPt:Point = gameView.centerPt;
									
					var dist:Number = Math.sqrt(Math.pow((centerPt.x - chunk.chunkRect.x), 2) + Math.pow((centerPt.y - chunk.chunkRect.y), 2) )
									
									
					if (dist > 3000)
					{
						//trace("dist", mapChunk, dist);
						chunk.releaseChunk();									
					} else 
					{
						chunk.hideNodes(gameView, gameView.mapViewRect);
					}
				}
			
			}	
		}
		
		public function toString():String
		{
			return "<MapChunkIndexNode bound=" + chunkBound + " isInit=" + isInit + ">";
		}
		
	}

}