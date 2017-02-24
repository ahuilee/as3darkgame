package dark.display 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author ahui
	 */
	public class BitmapAnimationArray  implements IBitmapAnimationArray 
	{
		
		private var _frames:Array = null;
		
		public function BitmapAnimationArray(frames:Array) 
		{
			this._frames = frames;
		}
		
		public function get numFrames():int
		{
			return _frames.length;
		}
		
		public function getFrameByIndex(index:int):BitmapData
		{
			return _frames[index];
		}
		
	}

}