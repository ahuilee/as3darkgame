package dark.ui 
{
	import dark.GameEnums;
	import dark.GameUtils;
	import dark.Game;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class MagicBuffListItemSprite extends Sprite
	{
		
		public var typeId:int = 0;
		public var bitmap:Bitmap = null;
		public var expireTime:Number = 0;
		
		public function MagicBuffListItemSprite() 
		{
		
			bitmap = new Bitmap();			
			
			addChild(bitmap);
			
		}
		
		public static function getBitmapDataByTemplateId(templateId:int, game:Game):BitmapData
		{
			
			var key:String = GameUtils.calcKeyNameByTemplateId(templateId);
			
			var bd:BitmapData = game.app.getIconBdByKey(key);
			
			if (bd == null)
			{
				bd = new BitmapData(64, 64, false, 0x00); 
			}
			
			return bd;
		}
		
		public function setTemplateId(templateId:int, game:Game):void
		{
			
			
			bitmap.bitmapData = getBitmapDataByTemplateId(templateId, game);
			bitmap.width = 64;
			bitmap.height = 64;
		}
		
	}

}