package dark.views 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import dark.GameEnums;

	public class MapChunkIndex implements IMapChunkIndexNode
	{
		
		public static const IDX_NUMCHUNK_X:int = 128;
		public static const IDX_NUMCHUNK_Y:int = 128;		
		
		public var indexFlashViewRect:Rectangle = null;				
		public var isInit:Boolean = false;		
		public var gameView:LazyGameView = null;
		
		public var chunkXStart:int = 0;
		public var chunkYStart:int = 0;
		
		
		
		public function MapChunkIndex(chunkXStart:int, chunkYStart:int, gameView:LazyGameView)
		{
			this.chunkXStart = chunkXStart;
			this.chunkYStart = chunkYStart;
			this.gameView = gameView;
			
			//var gameRect:Rectangle = new Rectangle(chunkXStart * MAPCHUNK_WIDTH, chunkYStart * MAPCHUNK_HEIGHT, IDX_NUMCHUNK_X * MAPCHUNK_WIDTH, IDX_NUMCHUNK_Y * MAPCHUNK_HEIGHT);
			
			var pt2:Point = gameView.chunkPtToFlashPt(chunkXStart, chunkYStart);	
			
			
			indexFlashViewRect = new Rectangle(
				pt2.x, 
				pt2.y,  
				IDX_NUMCHUNK_X * MapChunk.MAPCHUNK_WIDTH * gameView.tileWidthRatio,				
				IDX_NUMCHUNK_Y * MapChunk.MAPCHUNK_HEIGHT * gameView.tileHeightRatio
			);
			
			/*
			var grid:Shape = new Shape();
			var g:Graphics = grid.graphics;
			g.lineStyle(10, 0xff0000);
			g.drawRect(indexFlashViewRect.x, indexFlashViewRect.y, indexFlashViewRect.width, indexFlashViewRect.height);
			
			gameView.front.addChild(grid);
			*/
		}
		
		public function hitTest(flashViewRect:Rectangle):Boolean
		{
			if (!isInit)
			{
				init();
				isInit = true;
			}
				
			var hit:Boolean = indexFlashViewRect.intersects(flashViewRect);
			//trace("hit", indexFlashViewRect, flashViewRect, hit);
			
			return hit;
		}
		
		public var indexNodes:Array = [];
		
		public function getMapChunks(flashViewRect:Rectangle):Array
		{
			var chunks:Array = [];
			
			for (var i:int = 0; i < indexNodes.length; i++)
			{
				var node:IMapChunkIndexNode = indexNodes[i];
				
			
				
				var chunks2:Array = node.getMapChunks(flashViewRect);
				
				//trace("getMapChunks", node, chunks2);
				if (chunks2 != null)
				{
					for (var j:int = 0; j < chunks2.length; j++)
					{
						chunks.push(chunks2[j]);
					}
				}
				
			}		
			
			
			return chunks;
		}
		
		
		
		private var _isUnload:Boolean = false;
		
		public function unload():void
		{
			if (!_isUnload) 
			{
				trace("unload", this);
				for (var i:int = 0; i < indexNodes.length; i++)
				{
					var node:IMapChunkIndexNode = indexNodes[i];
					node.unload();
				}	
				
				_isUnload = true;
				
			}
			
		}
		
		
		
		public function init()
		{
			
			indexNodes.length = 0;
			
			var numNodeX:int = IDX_NUMCHUNK_X / 16;
			var numNodeY:int = IDX_NUMCHUNK_Y / 16;
			
			for (var x:int = 0; x < numNodeX; x++)
			{
				for (var y:int = 0; y < numNodeY; y++)
				{
					var nodeChunkXStart:int = chunkXStart + x * 16;
					var nodeChunkYStart:int = chunkXStart + y * 16;
					var bound:Rectangle = new Rectangle(nodeChunkXStart, nodeChunkYStart, 16, 16);
					
					var pt2:Point = gameView.chunkPtToFlashPt(nodeChunkXStart, nodeChunkYStart);	
					
					var flashHitRect:Rectangle = new Rectangle(
						pt2.x, 
						pt2.y,  
						16 * MapChunk.MAPCHUNK_WIDTH * gameView.tileWidthRatio,
						16 * MapChunk.MAPCHUNK_HEIGHT * gameView.tileHeightRatio
						);
						
					var node:MapChunkIndexNode = new MapChunkIndexNode(bound, flashHitRect, gameView);
					
					indexNodes.push(node);
					
					//trace("CreateMapChunkNode", new Point(nodeChunkXStart, nodeChunkYStart));
				}
			}
			
			
			
			
		}
		
	}

}