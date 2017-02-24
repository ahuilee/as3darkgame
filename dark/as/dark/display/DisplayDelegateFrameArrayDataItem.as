package dark.display 
{
	
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ahui
	 */
	public class DisplayDelegateFrameArrayDataItem
	{
		
		public var frames:Array = null;
		
		
		public var hitTestBoundOuter:Rectangle = null;
		public var hitTestRects:Array = null;
		
		public var scaleX:Number = 0;
		public var scaleY:Number = 0;
		public var x2:Number = 0;
		public var y2:Number = 0;
		
		public function DisplayDelegateFrameArrayDataItem(frames:Array , x2:Number, y2:Number, scaleX:Number, scaleY:Number)
		{
			this.frames = frames;
			this.x2 = x2;
			this.y2 = y2;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
		}
		
	}

}