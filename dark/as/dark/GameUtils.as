package dark 
{
	import flash.geom.Point;
	
	public class GameUtils 
	{

		public static function calcKeyNameByTemplateId(templateId:int):String
		{
			var idx:int = templateId - GameTemplateEnums.TI_INDEX_START;
			
			
			if (idx < 1)
			{
				idx = 1;
			}
			
			var keyName:String = idx.toString();
				
			if (idx < 1000)
			{
				keyName = "0" + keyName;
			}
				
			if (idx < 100)
			{
				keyName = "0" + keyName;
			}				
				
			if (idx < 10)
			{
				keyName = "0" + keyName;
			}
				
			keyName = "TI_" +keyName;
				
			return keyName;
			
		}
		
		
		public static function pt2Isopt(x:int, y:int):Point
		{
			var isopt:Point = new Point();
			isopt.x = x - y;
			isopt.y = (x + y) / 2;
			
			return isopt;
		}
		
		public static function isopt2Pt(x:int, y:int):Point
		{
			var pt:Point = new Point();
			pt.x = (2 * y + x) / 2;
			pt.y = (2 * y - x) / 2;
			
			return pt;
		}
		
		public static function calcDirectionByRotation(rot:Number):int
		{
			
			if (rot < -165 || rot > 165)
			{
				return 0;
			}
			
			if (rot > 110)
			{
				return 1;
			}
			
			if (rot > 75)
			{
				return 2;
			}
			
			if (rot > 35)
			{
				return 3;
			}
			
			if (rot >= 0 || rot > -35)
			{
				return 4;
			}
			
			if (rot > -75)
			{
				return 5;
			}
			
			
			if (rot > -115)
			{
				return 6;
			}
			
			return 7;
		}
		
	}

}