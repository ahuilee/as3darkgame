package dark.loaders 
{
	import dark.GameSoundEnums;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import dark.AppDelegate;

	import com.greensock.loading.SWFLoader;
	/**
	 * ...
	 * @author 
	 */
	public class LoaderIconSet
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderIconSet(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		
		
		public function load():void
		{
			loadTi(1, 25);
			loadTi(101, 20);
			loadTi(201, 30);
			loadTi(301, 30);
			loadTi(401, 20);
			loadTi(501, 20);
			loadTi(601, 20);
			loadTi(701, 20);
			loadTi(801, 30);
			
			loadTi(2001, 30);
		}
		
		private function loadTi(indexStart:int, count:int):void
		{
		
			var klassName:String = "";
			var BdClass:Class = null;
			var i:int = 0; 
			
			var end:int = indexStart + count;
			
			for (i = indexStart; i < end; i++)
			{
				klassName = i.toString();
				
				
				if (i < 1000)
				{
					klassName = "0" + klassName;
				}
				
				if (i < 100)
				{
					klassName = "0" + klassName;
				}				
				
				if (i < 10)
				{
					klassName = "0" + klassName;
				}
				
				klassName = "TI_" +klassName;
				
				BdClass = loader.getClass(klassName);
				
				//
				
				if (BdClass != null)
				{
					var bd:BitmapData =  new BdClass();
					if (bd != null)
					{
						//trace( klassName, BdClass);
						
						app.setIconBdByKey(klassName, bd);
					}
				}
				
			}
			
		}
	
		
		
		
	}

}