package dark.loaders 
{

	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import dark.AppDelegate;
	import dark.display.SceneCItemDisplayData;
	import dark.display.SceneCItemDisplayDataList;
	import dark.GameSoundEnums;
	
	import com.greensock.loading.SWFLoader;
	/**
	 * ...
	 * @author 
	 */
	public class LoaderAssetsSet
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderAssetsSet(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		
		
		public function load():void
		{
			
			_loadSI(2001, "SI_0001", -32, 0, 0.25, 0.25, 
				new Rectangle( -32, 0, 64, 48),
				[
					new Rectangle( -32, 0, 64, 48),
				]
			
			);
			_loadSI(2002, "SI_0002", -32, -32, 1, 1,
				new Rectangle( -32, -32, 64, 64),
				[
					new Rectangle( -32, -32, 64, 64),
				]
			);
			
			
			_loadSword01(2101);
			_loadSword02(2102)
			_loadSword09(2109)
			
			_loadAromr01(2201);			
			_loadAromr01(2202);
			
			_loadHelms01(2301);
			_loadHelms01(2302);
			
			_loadBoots01(2401);
			_loadBoots01(2402);
		}
		
		private function _loadBoots01(idx:int):void 
		{
			var list:SceneCItemDisplayDataList = app.getSceneCItemDisplayDataList(idx);
			
			
			if (list == null)
			{
				list = new SceneCItemDisplayDataList();		
				
				var dataList:Array = [];
				
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_01", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle(-40, -40, 80, 80),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_02", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle( 0, -48, 48, 48),
							new Rectangle( -32, -24, 64, 48),
							new Rectangle(-48, -16, 48, 48),	
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_03", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle( 0, -30, 45, 50),
							new Rectangle( -40, -40, 45, 70),
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_04", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle(-40, -40, 50, 50),	
							new Rectangle(-20, -20, 40, 40),	
							new Rectangle(-10, -10, 50, 50),	
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_05", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle(-40, -40, 80, 80),						
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_06", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-40, -40, 80, 80),
						[						
							new Rectangle(0, -48, 48, 48),
							new Rectangle(-24, -24, 48, 48),
							new Rectangle(-48, -10, 48, 48),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_07", 
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle( -40, -25, 45, 50),
							new Rectangle( 0, -40, 45, 70),
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"BOOTS_01_08",  
					-48, -48, 0.75, 0.75,			
					new Rectangle(-48, -48, 96, 96),
						[						
							new Rectangle( -40, -35, 40, 50),
							new Rectangle( -20, -20, 30, 40),	
							new Rectangle( 20, -20, 20, 30),	
							new Rectangle(-10, -10, 50, 40),
						]
					)		
				);
				
				list.dataList = dataList;	
			}
				
			
			app.setSceneCItemDisplayDataList(idx, list);
		}
		
		
		private function _loadHelms01(idx:int):void 
		{
			var list:SceneCItemDisplayDataList = app.getSceneCItemDisplayDataList(idx);	
			
			if (list == null)
			{
				list = new SceneCItemDisplayDataList();	
				
				var dataList:Array = [];
				
				dataList.push(
					_makeDisplayData(
					"HE01_01", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle( -24, -48, 48, 48),	
						new Rectangle(-48, -8, 96, 40),
					]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"HE01_02", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle(-48, -48, 96, 96),						
					]
					)
				);
				
				dataList.push(
					_makeDisplayData(
					"HE01_03", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle(-28, -48, 64, 80),						
					]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"HE01_04", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle( -24, -48, 48, 48),	
						new Rectangle(-48, -8, 96, 40),						
					]
					)		
				);
				dataList.push(
					_makeDisplayData(
					"HE01_05", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle( -24, -48, 48, 48),	
						new Rectangle(-45, 0, 90, 32),
					]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"HE01_06",  
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle( -24, -48, 48, 40),	
						new Rectangle(-48, -18, 96, 48),						
					]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"HE01_07", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle(-28, -48, 64, 80),
					]
					)		
				);
				
				dataList.push(
					_makeDisplayData(
					"HE01_08", 
					-64, -64, 1, 1,			
					new Rectangle(-48, -48, 96, 96),
					[						
						new Rectangle(-32, -48, 48, 48),							
						new Rectangle(-48, -8, 96, 48),							
					]
					)	
				);
				
				list.dataList = dataList;	
			}
				
			
			app.setSceneCItemDisplayDataList(idx, list);
		}
		
		
		private function _loadAromr01(idx:int):void 
		{
			
			var list:SceneCItemDisplayDataList = app.getSceneCItemDisplayDataList(idx);
			
			
			if (list == null)
			{
				list = new SceneCItemDisplayDataList();
				var dataList:Array = [];
				
				dataList.push(
					_makeDisplayData(
					"A01_01", 
					-64, -64, 1, 1,				
					new Rectangle(-48, -50, 96, 100),
						[						
							new Rectangle( -36, -50, 72, 50),	
							new Rectangle(-40, 0, 70, 50),
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"A01_02", 
					-64, -64, 1, 1,			
					new Rectangle(-64, -40, 128, 80),
						[						
							new Rectangle(-64, -40, 120, 80),						
						]
					)			
				);
				
				dataList.push(
					_makeDisplayData(
					"A01_03", 
					-64, -64, 1, 1,			
					new Rectangle(-64, -50, 128, 90),
						[						
							new Rectangle( -64, -50, 72, 50),	
							new Rectangle(-20, -20, 70, 50),					
						]
					)		
				);
				
				dataList.push(
					_makeDisplayData(
					"A01_04", 
					-64, -64, 1, 1,			
					new Rectangle(-64, -50, 128, 90),
						[						
							new Rectangle(-40, -50, 80, 90),						
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"A01_05", 
					-64, -64, 1, 1,			
					new Rectangle(-64, -50, 128, 90),
						[						
							new Rectangle(-45, -50, 90, 90),						
						]
					)			
				);
				dataList.push(
					_makeDisplayData(
					"A01_06", 
					-64, -64, 1, 1,			
					new Rectangle(-64, -50, 128, 90),
						[					
							new Rectangle(-64, -50, 128, 50),
													
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"A01_07", 
					-64, -64, 1, 1,			
					new Rectangle(-64, -50, 128, 90),
						[						
							new Rectangle(-60, -40, 60, 45),						
							new Rectangle(-30, -20, 60, 45),	
							new Rectangle(0, -10, 50, 50),
						]
					)	
				);
				
				
				list.dataList = dataList;		
			
			}
			
			app.setSceneCItemDisplayDataList(idx, list);
		}
		
		
		
		private function _loadSword01(idx:int):void 
		{

			var list:SceneCItemDisplayDataList = app.getSceneCItemDisplayDataList(idx);
			
			
			if (list == null)
			{
				list = new SceneCItemDisplayDataList();		
				
				var dataList:Array = [];
				
				dataList.push(
					_makeDisplayData(
					"SW01_01", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 256, 256),
						[						
							new Rectangle(-32, -64, 64, 128),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW01_02", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							
							new Rectangle(30, -30, 30, 30),
							new Rectangle(0, -10, 30, 30),
							new Rectangle(-30, 0, 30, 30),
							new Rectangle(-60, 20, 30, 30),
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW01_03", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -16, 192, 36),
						[						
							new Rectangle(-96, -16, 192, 36),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW01_04", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							new Rectangle( -60, -30, 30, 30),	
							new Rectangle( -30, -10, 30, 30),
							new Rectangle( 0, 0, 30, 30),
							new Rectangle( 30, 10, 30, 40),					
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"SW01_05", 
					-96, -64, 1, 1,			
					new Rectangle(-24, -64, 48, 128),
						[						
							new Rectangle(-24, -64, 48, 128),						
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"SW01_06", 							
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							
							new Rectangle(30, -30, 30, 30),
							new Rectangle(0, -10, 30, 30),
							new Rectangle(-30, 0, 30, 30),
							new Rectangle(-60, 20, 30, 30),
						]
					)		
				);
				
				dataList.push(
				_makeDisplayData(
					"SW01_07", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -20, 200, 50),
					[						
						new Rectangle(-96, -20, 200, 50),						
					]
				)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW01_08", 
					-96, -64, 1, 1,			
					new Rectangle(-90, -50, 160, 96),
						[						
								
							new Rectangle( -60, -30, 30, 30),	
							new Rectangle( -30, -10, 30, 30),
							new Rectangle( 0, 0, 30, 30),
							new Rectangle( 30, 20, 30, 30),
						]
					)	
				);
				
				
				list.dataList = dataList;	
			}
				
			
			app.setSceneCItemDisplayDataList(idx, list);
			
		}
		
		
		private function _loadSword02(idx:int):void 
		{

			var list:SceneCItemDisplayDataList = app.getSceneCItemDisplayDataList(idx);
			
			
			if (list == null)
			{
				list = new SceneCItemDisplayDataList();		
				
				var dataList:Array = [];
				
				dataList.push(
					_makeDisplayData(
					"SW02_01", 
					-96, -64, 1, 1,			
					new Rectangle(-32, -64, 64, 128),
						[						
							new Rectangle(-30, -64, 48, 128),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW02_02", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							
							new Rectangle(30, -40, 30, 30),
							new Rectangle(0, -20, 30, 30),
							new Rectangle(-30, -10, 30, 30),
							new Rectangle(-60, 10, 30, 30),
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW02_03", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -16, 192, 30),
						[						
							new Rectangle(-96, -16, 192, 30),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW02_04", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							new Rectangle( -80, -40, 40, 30),	
							new Rectangle( -40, -20, 40, 30),
							new Rectangle( -10, -10, 40, 30),
							new Rectangle( 30, 0, 35, 40),					
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"SW02_05", 
					-96, -64, 1, 1,			
					new Rectangle(-32, -64, 64, 128),
						[						
							new Rectangle(-32, -64, 64, 128),						
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"SW02_06", 							
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							
							new Rectangle(30, -40, 30, 30),
							new Rectangle(0, -20, 30, 40),
							new Rectangle(-30, -10, 30, 40),
							new Rectangle(-60, 10, 30, 30),
						]
					)		
				);
				
				dataList.push(
				_makeDisplayData(
					"SW02_07", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -20, 200, 50),
					[						
						new Rectangle(-96, -20, 200, 50),						
					]
				)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW02_08", 
					-96, -64, 1, 1,			
					new Rectangle(-90, -50, 160, 96),
						[						
								
							new Rectangle( -90, -40, 50, 30),	
							new Rectangle( -40, -30, 30, 30),
							new Rectangle( -10, -15, 30, 40),
							new Rectangle( 20, 0, 50, 40),
						]
					)	
				);
				
				list.dataList = dataList;	
			}
				
			
			app.setSceneCItemDisplayDataList(idx, list);
			
		}
		
		
		private function _loadSword09(idx:int):void 
		{

			var list:SceneCItemDisplayDataList = app.getSceneCItemDisplayDataList(idx);
			
			
			if (list == null)
			{
				list = new SceneCItemDisplayDataList();		
				
				var dataList:Array = [];
				
				dataList.push(
					_makeDisplayData(
					"SW09_01", 
					-96, -64, 1, 1,			
					new Rectangle(-32, -64, 64, 128),
						[	
						new Rectangle(-12, -64, 40, 64),					
							new Rectangle(-32, 0, 64, 64),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW09_02", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							
							new Rectangle(30, -30, 50, 30),
							new Rectangle(0, -10, 30, 30),
							new Rectangle(-40, -5, 40, 30),
							new Rectangle(-80, 10, 50, 30),
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW09_03", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -16, 192, 36),
						[						
							new Rectangle(-96, -16, 192, 36),						
						]
					)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW09_04", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							new Rectangle( -70, -30, 40, 30),	
							new Rectangle( -30, -20, 30, 40),
							new Rectangle( 0, 0, 30, 30),
							new Rectangle( 30, 10, 40, 40),					
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"SW09_05", 
					-96, -64, 1, 1,			
					new Rectangle(-32, -64, 64, 128),
						[						
							new Rectangle(-32, -64, 64, 128),						
						]
					)	
				);
				dataList.push(
					_makeDisplayData(
					"SW09_06", 							
					-96, -64, 1, 1,			
					new Rectangle(-96, -64, 192, 128),
						[						
							
							new Rectangle(40, -40, 40, 30),
							new Rectangle(10, -20, 30, 30),
							new Rectangle(-20, -10, 30, 30),
							new Rectangle(-60, 10, 40, 30),
						]
					)		
				);
				
				dataList.push(
				_makeDisplayData(
					"SW09_07", 
					-96, -64, 1, 1,			
					new Rectangle(-96, -20, 200, 50),
					[						
						new Rectangle(-96, -20, 200, 50),						
					]
				)	
				);
				
				dataList.push(
					_makeDisplayData(
					"SW09_08", 
					-96, -64, 1, 1,			
					new Rectangle(-90, -50, 160, 96),
						[						
								
							new Rectangle( -65, -35, 30, 30),	
							new Rectangle( -35, -15, 30, 30),
							new Rectangle( -5, -5, 30, 30),
							new Rectangle( 25, 15, 30, 30),
						]
					)	
				);
				
				list.dataList = dataList;	
			}
				
			
			app.setSceneCItemDisplayDataList(idx, list);
			
		}
		
		private function _makeDisplayData(name:String, x2:int, y2:int, scaleX:Number, scaleY:Number, outerRect:Rectangle, hitRects:Array):SceneCItemDisplayData
		{
			var displayData:SceneCItemDisplayData = new SceneCItemDisplayData();
			
			displayData.outerRect = outerRect;
			displayData.hitRects = hitRects;
			
			var BdClass:Class = loader.getClass(name);
			
			var bd:BitmapData =  new BdClass();
			
			displayData.bitmapData = bd;
			displayData.x2 = x2;
			displayData.y2 = y2;
			displayData.scaleX = scaleX;
			displayData.scaleY = scaleY;
			
			return displayData;
		}
		
		private function _loadSI(idx:int, name:String, x2:int, y2:int, scaleX:Number, scaleY:Number, outerRect:Rectangle, hitRects:Array):void 
		{
			
			
			
			var list:SceneCItemDisplayDataList = new SceneCItemDisplayDataList();
			
			list.dataList = [_makeDisplayData(name, x2, y2, scaleX, scaleY, outerRect, hitRects)];
			
			
			app.setSceneCItemDisplayDataList(idx, list);
			
			
		}
		
	
		
		
		
	}

}