package dark.loaders 
{
	import com.greensock.loading.SWFLoader;
	import dark.AppDelegate;
	import dark.GameTemplateEnums;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class LoaderMap 
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderMap(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app =  app;
		}
		
		
		public function load()
		{
			loadTiles();
			_loadInitMaps();
		}
		
		
		private function loadTiles()
		{
			app.setMapTile(0, new BitmapData(64, 64, true, 0xffffff));
			
			
			var gIdxStart = 1;
			setTiles(gIdxStart, "BD_G01", 1024, 1024, 16,16);	
			setTiles(gIdxStart+256, "BD_G02", 1024, 1024, 16, 16);
			setTiles(gIdxStart+256*2, "BD_G03", 512, 512, 8, 8);
			
			var brickStartIdx:int = 1024;
			setTiles(brickStartIdx+64*0, "BD_BRICK_01", 512, 512, 8, 8);
			setTiles(brickStartIdx+64*1, "BD_BRICK_02", 512, 512, 8, 8);
			setTiles(brickStartIdx+64*2, "BD_BRICK_03", 512, 512, 8, 8);
			setTiles(brickStartIdx+64*3, "BD_BRICK_04", 512, 512, 8, 8);
			setTiles(brickStartIdx+64*4, "BD_BRICK_05", 512, 512, 8, 8);
			setTiles(brickStartIdx+64*5, "BD_BRICK_06", 512, 512, 8, 8);
			setTiles(brickStartIdx + 64 * 6, "BD_BRICK_07", 512, 512, 8, 8);
			
			var bone1StartIdx:int = 4097;
			
			setTiles(bone1StartIdx, "BD_B01", 1024, 1024, 16, 16);
			setTiles(bone1StartIdx+256, "BD_B02", 1024, 1024,16, 16);
			setTiles(bone1StartIdx + 256 * 2, "BD_B03", 1024, 1024,16, 16);
			setTiles(bone1StartIdx + 256 * 3, "BD_B04", 1024, 1024,16, 16);
			
			
			//setTiles(65, "BD_GREEN_01", 8, 8);
			
			
			
			
		}
		
		private function setTiles(startIndex:int, className:String, width:Number, height:Number, numX:int, numY:int):void
		{
			var BDClass:Class = loader.getClass(className);
			
			trace("startIndex", startIndex,  className, BDClass);
					
			var src:BitmapData = new BDClass();
			
			
			var map1Bd:BitmapData = new BitmapData(width, height);
			var matrix:Matrix = new Matrix();
			
			var ratio:Number = Math.max(
				Math.max(width, src.width) / src.width,
				Math.max(height, src.height) / src.height
				);
				
			matrix.scale(ratio, ratio);
			
			map1Bd.draw(src, matrix);
			
			var tileId:int = startIndex;
			
			for (var y:int = 0; y < numY; y++)
			{
				for (var x:int = 0; x < numX; x++)
				{
					var clip:BitmapData = new BitmapData(64, 64, true, 0x00);
					clip.copyPixels(map1Bd, new Rectangle(x * clip.width, y * clip.height, clip.width, clip.height), new Point(0, 0));
					app.setMapTile(tileId++, clip);		
					
				
				}
			}
		}
		
		private function _loadInitMaps()
		{
			
			var i:int = 0;
			var className:String = "";
			var Bd_Class:Class  = null;
			
			for (i = 0; i < 30; i++)
			{
				className = "Bd_Tree";
				
				if (i < 100)
				{
					className += "0";
				}
				
				if (i < 10)
				{
					className += "0";
				}				
				
				className += (i + 1);
				Bd_Class = loader.getClass(className);
				
				//trace("className", Bd_Class);
				
				if (Bd_Class != null)
				{
					
					app.setTemplateBd(GameTemplateEnums.T_TREE_START  + i , new Bd_Class());
				}
				
			}
			
			
			
			for (i = 0; i < 20; i++)
			{
				className = "Bd_Flower";
				
				if (i < 10)
				{
					className += "0";
				}
				
				className += (i + 1);
				Bd_Class = loader.getClass(className);
				
				if (Bd_Class != null)
				{
					app.setTemplateBd(GameTemplateEnums.T_FLOWER_START  + i , new Bd_Class());
					
					switch (i) 
					{
						case 11:
							app.setTemplateBd(GameTemplateEnums.T_FLOWER_START  + i + 20 , new Bd_Class());
							break;
						default:
					}
				}
				
			}
			
			
			
			for (i = 0; i < 20; i++)
			{
				className = "Bd_Stone";
				
				if (i < 10)
				{
					className += "0";
				}
				
				className += (i + 1);
				Bd_Class = loader.getClass(className);
				if (Bd_Class != null)
				{				
					app.setTemplateBd(GameTemplateEnums.T_STONE_START  + i , new Bd_Class());
				}
				
			}
			
			for (i = 0; i < 100; i++)
			{
				className = "BSceneItem";
				
				if (i < 1000)
				{
					className += "0";
				}
				
				if (i < 100)
				{
					className += "0";
				}
				
				if (i < 10)
				{
					className += "0";
				}
				
				className += (i + 1);
				Bd_Class = loader.getClass(className);
				
				if (Bd_Class != null)
				{
					app.setTemplateBd(GameTemplateEnums.T_SCENEITEM_START  + i , new Bd_Class());					
					
				}
				
			}
			
		}
		
		
	}

}