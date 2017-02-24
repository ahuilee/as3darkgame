package dark.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class LazyBitmapAnimation extends Sprite
	{
		
		public var array:IBitmapAnimationArray = null;
		public var bitmap:Bitmap = null;
		
		public var frameIndex:int = 0;	
	
	
		
		public function LazyBitmapAnimation(array:IBitmapAnimationArray) 
		{
			this.array = array;
			this.bitmap =  new Bitmap(null);
			
			this.addChild(bitmap);
			
			
			_duration = 1000 / array.numFrames * 2;
		}
		
		public function setDuration(duration:Number):void
		{
			_duration = duration;
		}
		
		public var isPlay:Boolean = false;
		public var repeat:int = -1;
			
		
		private var _startTime:Number = 0;
		private var _duration:Number = 0;
		
		public function init():void
		{
			_startTime = new Date().getTime();
			
		}
		
		public function update():void
		{
			if (isPlay) 
			{
				
				var t:Number = (new Date().getTime() - _startTime) % _duration;
				
				var frameIndex2:int = array.numFrames * t / _duration;
				
				//trace("frameIndex2", t, _duration, array.numFrames, frameIndex2);
				
				var bd:BitmapData = array.getFrameByIndex(frameIndex2);
				
				bitmap.bitmapData = bd;
				
				frameIndex = frameIndex2;
			
				if (frameIndex >= this.array.numFrames)
				{
					frameIndex = 0;
					
					if (repeat > 0)
					{
						repeat--;
						
						if (repeat == 0)
						{
							isPlay = false;
						}
					}
				}			
			}
			
			
		}
		
	}

}