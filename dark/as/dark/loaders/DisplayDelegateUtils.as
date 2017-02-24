package dark.loaders 
{
	import flash.geom.Rectangle;
	import dark.display.DisplayDelegateFrameArrayDataItem;
	
	public class DisplayDelegateUtils 
	{
		
		public static function makeFrameArrayItem(frames:Array , x2:Number, y2:Number, scaleX:Number, scaleY:Number, hitTestBoundOuter:Rectangle, hitTestRects:Array):DisplayDelegateFrameArrayDataItem
		{
			var item:DisplayDelegateFrameArrayDataItem = new DisplayDelegateFrameArrayDataItem(frames, x2, y2, scaleX, scaleY);
			item.hitTestBoundOuter = hitTestBoundOuter;
			item.hitTestRects = hitTestRects;
			
			return item;
		}
		
	}

}