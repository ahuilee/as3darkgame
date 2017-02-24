package dark.views 
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.Responder;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import dark.*;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyMapChunkGetDataCallback implements IGetMapChunkCallback
	{
		
		public var mapRect:MapChunk = null;
		
		public var gameView:LazyGameView = null;
		
		public function LazyMapChunkGetDataCallback(mapRect:MapChunk, gameView:LazyGameView) 
		{
			this.mapRect =  mapRect;
			this.gameView = gameView;
		}
		
		
		public function callback(data:MapChunkData):void
		{
			try
			{
			
			if (gameView == null) return;
			if (mapRect == null) return;
			
			if (mapRect.isReleased == true) 
			{
				trace("LazyMapChunkGetDataCallback Map isReleased!!");
				return;
			}
			
			var container:Sprite = new Sprite();
			
			var gridG:Graphics = null;
			
			var txtField:TextField = null;
			
			if (gameView.displayMapCellPt) 
			{
				txtField = new TextField();
				
				var fmt:TextFormat = new TextFormat(null, 12, 0xffffff, true);
				txtField.setTextFormat(fmt);
				txtField.background = true;
				txtField.backgroundColor = 0x000000;
				txtField.textColor = 0xffffff;
				txtField.autoSize = TextFieldAutoSize.LEFT;		
				txtField.scaleX = txtField.scaleY = 3;
			}		
			
			
			var grid:Sprite = new Sprite();
			mapRect.gridSprite = grid;
			
			gridG = grid.graphics;
			gridG.lineStyle(1, 0xffffff);	
			
			grid.visible = DebugSetting.isShowGameMapChunkGrids;
			
			var width2:Number = GameEnums.CHUNK_NUM_CELL_X * GameEnums.MAP_TILE_WIDTH;
			var height2:Number = GameEnums.CHUNK_NUM_CELL_Y* GameEnums.MAP_TILE_HEIGHT;
			//var chunkBd:BitmapData = new BitmapData(, , true, 0x00);
			
			var countMax:int = GameEnums.CHUNK_NUM_CELL_X * GameEnums.CHUNK_NUM_CELL_Y;
			var count:int = 0;
			
			for (var i:int = 0; i < data.tails.length; i++)
			{
				var tailN:int = data.tails[i];
				var x2:int = i % GameEnums.CHUNK_NUM_CELL_X;
				var y2:int = i / GameEnums.CHUNK_NUM_CELL_Y;
				count++;
				
				if (count > countMax)
				{
					break;
				}
				
				var tailBd:BitmapData = gameView.app.getMapTile(tailN);
			    var cellPt:Point = new Point(mapRect.chunkX * GameEnums.CHUNK_NUM_CELL_X + x2, mapRect.chunkY * GameEnums.CHUNK_NUM_CELL_Y + y2); 
				var pt2:Point = new Point(x2 * GameEnums.MAP_TILE_WIDTH, y2 * GameEnums.MAP_TILE_HEIGHT);	
			
				//chunkBd.copyPixels(tailBd, tailBd.rect, pt2, null, null, true);	
				
				
				var cellBmp:Bitmap = new Bitmap(tailBd);
				cellBmp.x = pt2.x;
				cellBmp.y = pt2.y;
				container.addChild(cellBmp);
				
				if (txtField != null) 
				{
					txtField.text = cellPt.y + ", " + cellPt.x;	
					var txtBd:BitmapData = new BitmapData(64, 64, true, 0x00);				
					txtBd.draw(txtField);				
					var txtBmp:Bitmap = new Bitmap(txtBd);
					txtBmp.x = cellBmp.x;
					txtBmp.y = cellBmp.y;
					container.addChild(txtBmp);
					//chunkBd.copyPixels(txtBd, txtBd.rect, pt2, null, null, true);			
				}
					
				if (grid != null)
				{					
					gridG.drawRect(pt2.x, pt2.y, tailBd.width, tailBd.height);
				}			
			}
			
			if (gridG != null)
			{	
				gridG.lineStyle(1, 0xff0000);			
				gridG.drawRect(0, 0, width2, height2);
			}
		
			
			
			if (grid != null) 
			{
				container.addChild(grid);
			}
			
			container.rotationZ = 45;
			container.height = container.height / 2;
		
			
			mapRect.sprite.addChild(container);		
			/*
			var shape:Shape = new Shape();
			container.addChild(shape);
			var g:Graphics = shape.graphics;
			
			g.lineStyle(1, 0xffffff);
			g.drawRect(0, 0, mapRect.sprite.width, mapRect.sprite.height);
			*/
			
			var nodes:Array = [];
			
			for each(var node:MapChunkNode in data.nodes)
			{
				var mapNodeX:Number = mapRect.gameRect.x + (node.x * GameEnums.MAP_TILE_WIDTH);
				var mapNodeY:Number = mapRect.gameRect.y + (node.y * GameEnums.MAP_TILE_HEIGHT);
				//var mapNodeX:Number =  mapRect.gameRect.x + (node.x * GameEnums.MAP_TILE_WIDTH);
				//var mapNodeY:Number = mapRect.gameRect.x + (node.y * GameEnums.MAP_TILE_HEIGHT);
				var mapNodeFlashPt:Point = gameView.calcGamePtToFlashPt(mapNodeX, mapNodeY);
				
				//trace("mapNodeFlashPt", new Point(mapNodeX, mapNodeY), mapNodeFlashPt);
				
				
				
				if (node.templateId >= GameTemplateEnums.T_TREE_START && node.templateId <= (GameTemplateEnums.T_TREE_START + 50))
				{
						
					var treeNode:MapRectTreeSprite = new MapRectTreeSprite(node.templateId, 
						new Rectangle(mapNodeX, mapNodeY, 64, 64),
						new Rectangle(mapNodeFlashPt.x, mapNodeFlashPt.y, 64, 64)
					);
						
					nodes.push(treeNode);
					
				} else if (node.templateId >= GameTemplateEnums.T_FLOWER_START && node.templateId <= (GameTemplateEnums.T_FLOWER_START + 50))
				{
					//trace("T_FLOWER_START=", node.templateId);
					
					var stoneNode:MapRectFlowerSprite = new MapRectFlowerSprite(node.templateId,
						new Rectangle(mapNodeX, mapNodeY, 64, 64),
						new Rectangle(mapNodeFlashPt.x, mapNodeFlashPt.y, 64, 64)
					);
						
					nodes.push(stoneNode);
				
				} else if (node.templateId >= GameTemplateEnums.T_STONE_START && node.templateId <= GameTemplateEnums.T_STONE_START + 50)
				{
					var flowerNode:MapRectStoneSprite = new MapRectStoneSprite(node.templateId, 
						new Rectangle(mapNodeX, mapNodeY, 64, 64),
						new Rectangle(mapNodeFlashPt.x, mapNodeFlashPt.y, 64, 64)
					);
						
					nodes.push(flowerNode);
				
				} else if (node.templateId >= GameTemplateEnums.T_SCENEITEM_START && node.templateId <= (GameTemplateEnums.T_SCENEITEM_START + 1000))
				{
					
					var sceneItemNode:MapRectSceneItemSprite = new MapRectSceneItemSprite(node.templateId, 
						new Rectangle(mapNodeX, mapNodeY, 64, 64),
						new Rectangle(mapNodeFlashPt.x, mapNodeFlashPt.y, 64, 64)
					);
						
					nodes.push(sceneItemNode);
					
				}
			}
			
			var blocks:Array = [];
			
			for each(var block:Rectangle in data.blocks)
			{
				var block2:Rectangle = new Rectangle(mapRect.gameRect.x  + block.x, mapRect.gameRect.y + block.y, block.width, block.height);		
				
				blocks.push(block2);					
				
				var bgrid:Shape = new Shape();
				var gg:Graphics = bgrid.graphics;
				gg.lineStyle(3, 0xff0000);
				gg.drawRect(0, 0, block2.width, block2.height);
					
					
				bgrid.rotationZ = 45;
				bgrid.height = bgrid.height / 2;
					
				var fpt:Point = gameView.calcGamePtToFlashPt(block2.x, block2.y);
					
				bgrid.x = fpt.x;
				bgrid.y = fpt.y;					
				//trace("block2", block2, "fpt", fpt);
					
				//gameView.blockContainer.addChild(bgrid);
				
			}
			
			mapRect.nodes = nodes;
			mapRect.blocks = blocks;
			
			
			mapRect.displayNodes(gameView, gameView.mapViewRect);
			
			} catch (err:Error)
			{
				trace("Map ", err.getStackTrace());
			}
			
			
		}
		
		
	}

}