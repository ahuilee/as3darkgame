package dark.sprites 
{
	import dark.AppDelegate;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyNPCAnimationSprite extends Sprite
	{
		
		public var bitmap:Bitmap = null;			
		
		private var _framesByDir:Array = null;
		
		public var direction:int = 0;
		
		public function LazyNPCAnimationSprite(frames:Array, app:AppDelegate) 
		{
			this.bitmap = new Bitmap();
			
			
			_framesByDir = frames;
			
			
			addChild(bitmap);
		}
		
		public function setFrameIndex(fx:int):void
		{
			
			var bd:BitmapData = _framesByDir[direction][fx];
			
			bitmap.bitmapData = bd;
			
		}
		
		
	}

}