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
	public class LoaderBaseSet
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderBaseSet(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		public function load():void
		{
			
			
			var klass:Class = loader.getClass("Bd_MouseAttack");
			
			trace("_loadBaseSwf", klass);
			
			app.setClassByKey("Base_Bd_MouseNormal", loader.getClass("Bd_MouseNormal"));
			app.setClassByKey("Base_Bd_MouseAttack", klass);
			app.setClassByKey("BASE_BD_MouseSkillSelect", loader.getClass("BD_MouseSkillSelect"));
			
			
			loadShortcutMasks();
			
		}
		
		private function loadShortcutMasks():void		
		{
			var MaskBdClass:Class = loader.getClass("BD_ShortcutItem_Mask");
			
			var bd:BitmapData = new MaskBdClass();
			
			
			app.setIconBdByKey("BD_ShortcutItem_Mask", bd);
		}
		
		
		
		
	}

}