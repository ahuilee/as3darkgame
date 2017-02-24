package dark.display 
{
	import flash.display.BitmapData;
	
	
	public interface IBitmapAnimationArray 
	{
		
		function get numFrames():int;
		function getFrameByIndex(index:int):BitmapData;
		
	}
	
}