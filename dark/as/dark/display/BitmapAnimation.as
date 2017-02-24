package dark.display 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class BitmapAnimation extends Sprite
	{
		
		public var array:IBitmapAnimationArray = null;
		public var bitmap:Bitmap = null;
		
		public var frameIndex:int = 0;
		
	
		
		public function BitmapAnimation(array:IBitmapAnimationArray) 
		{
			this.array = array;
			this.bitmap =  new Bitmap(null);
			
			this.addChild(bitmap);
		}
		
		public var isPlay:Boolean = false;
		public var repeat:int = -1;
			
		public function update():void
		{
			if (isPlay) 
			{
				
				bitmap.bitmapData = array.getFrameByIndex(frameIndex);
			
				frameIndex++;
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