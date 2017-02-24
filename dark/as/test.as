package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class test extends Sprite
	{
		
		public function test() 
		{
			
			
			var dict:Dictionary = new Dictionary();
			
			dict[2, 2] = 20;
			
			
			trace("get", dict[new Point(2, 2)]);
			//bmp.rotagetionX = 45;
			
			
		}
		
	}

}