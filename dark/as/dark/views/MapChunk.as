package dark.views 
{
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import dark.GameEnums;
	
	public class MapChunk
	{
		
		public static const CHUNK2D_WIDTH:Number = GameEnums.CHUNK_NUM_CELL_X * GameEnums.MAP_TILE_WIDTH * 1.422;
		public static const CHUNK2D_HEIGHT:Number = GameEnums.CHUNK_NUM_CELL_Y * GameEnums.MAP_TILE_HEIGHT * 0.7102;
		
		public static const MAP_CELL_X_DELTA:Number =  CHUNK2D_WIDTH / 2.0;
		public static const MAP_CELL_Y_DELTA:Number = CHUNK2D_HEIGHT / 2.0;
		
		public static const MAPCHUNK_WIDTH:int  = GameEnums.MAP_TILE_WIDTH    * GameEnums.CHUNK_NUM_CELL_X;
		public static const MAPCHUNK_HEIGHT:int = GameEnums.MAP_TILE_HEIGHT   * GameEnums.CHUNK_NUM_CELL_Y;
		
		public var chunkX:int = 0;
		public var chunkY:int = 0;		
		public var chunkRect:Rectangle = null;
		
		public var gameRect:Rectangle = null;
		
		public var isLoaded:Boolean = false;
		public var isReleased:Boolean = false;
		
		public var sprite:Sprite = null;
		
		public var nodes:Array = null;
		public var blocks:Array = null;
		
		private var _isHide:Boolean = false;
		
		public var gameView:LazyGameView = null;
		
		public var gridSprite:Sprite = null;
		
		public var lastActiveTime:Number = 0;
		
		
		
		public function MapChunk(gameView:LazyGameView)
		{
			this.gameView = gameView;
		}
		
		public function hideNodes(gameView:LazyGameView, gameBound:Rectangle):void
		{
			if (!_isHide && nodes !=null)
			{				
				
				_isHide = true;
				var i:int = 0;
				//trace("hideNodes", this);
				
				for (i = 0; i < nodes.length; i++)
				{
					var node:IMapRectNode  = nodes[i];
					
					node.hide(gameView);
					
					
				}
				/*
				if (gameView.displayMapBlockGrid)
				{
					for (i = 0; i < _blockShapes.length; i++)
					{
						var shape:DisplayObject = _blockShapes[i];
						
						gameView.blockContainer.removeChild(shape);
						
					}
				
				}*/
			
				
			}
			
		}
		
		public function releaseChunk():void
		{
			//trace("releaseChunk", this);
			isReleased = true;
			if (sprite != null)			
			{
				if (this.sprite.parent != null)
				{
					this.sprite.parent.removeChild(this.sprite);
				}				
				
			}
			
			sprite = null;
			nodes = null;
			blocks = null;
			_blockShapes = [];
			this.isLoaded = false;
			
		}
		
		private var _blockShapes:Array = [];
		
		public function displayNodes(gameView:LazyGameView, gameBound:Rectangle):void
		{
			if (nodes != null)
			{
				_isHide = false;
				
				var i:int = 0;
				
				for (i = 0; i < nodes.length; i++)
				{
					var node:IMapRectNode  = nodes[i];
					
					if (node != null)
					{
						node.display(gameView, gameBound);
					}
				}
				/*
				if (gameView.displayMapBlockGrid)
				{
					if (blocks != null)
					{
						for (i = 0; i < blocks.length; i++)
						{			
							var block:Rectangle = blocks[i];
							var bgrid:Shape = new Shape();
							var g:Graphics = bgrid.graphics;
							g.lineStyle(1, 0xff0000);
							g.drawRect(0, 0, block.width, block.height);
					
					
					bgrid.rotationZ = 45;
					bgrid.height = block.height / 2;
					
					var fpt:Point = gameView.gamePtToFlashPt(block.x, block.y);
					
					bgrid.x = fpt.x;
					bgrid.y = fpt.y;
					
					trace("block2", block2, "fpt", fpt);
					
					gameView.blockContainer.addChild(bgrid);
							
					_blockShapes.push(bgrid);
					
						}
						
					}
					
					
				}*/
				
			}
			
		}
		
		
	
		
		public function toString():String
		{
			return "<Map cx=" + chunkX + " cy=" + chunkY +" gameRect=" + gameRect + " isLoaded=" +  isLoaded + ">";
		}
		
	}

}