package dark.loaders 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import dark.AppDelegate;
	import dark.display.BitmapAnimationArray;
	import com.greensock.loading.SWFLoader;
	/**
	 * ...
	 * @author 
	 */
	public class LoaderUI
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderUI(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		public function load():void
		{
			
			var className:String = "";
			var Bd_Class:Class  = null;
			
			for (var id:int = 1; id < 9; id++)
			{
				className = id.toString();
				
				if (id < 10)
				{
					className = "0" + className;
				}
				
				className = "BD_UI" + className;
					
				Bd_Class =  loader.getClass(className);
				
				
				
				app.setUIBDKlass(id, Bd_Class);
				
				
				
			}
			
			
			_load4();
			_loadBase();
		}
		
		private function _loadBase():void
		{
			
			var ValueBar01Class:Class = loader.getClass("BD_ValueBar01");							
				
	
			app.setUIBd("ValueBar01", new ValueBar01Class());	
			
		}
		
		private function _load4():void
		{
			var BDClass:Class = app.getUIBDKlass(4);
			var bd:BitmapData = new BDClass();
			
			var box:BitmapData = new BitmapData(83, 83, true, 0x00);
			
			box.copyPixels(bd, new Rectangle(289, 915, box.width, box.height), new Point(), null, null, false);
			
			
			app.setUIBd("BOX01", box.clone());
			
			
		}
		
		
		
		
	}

}