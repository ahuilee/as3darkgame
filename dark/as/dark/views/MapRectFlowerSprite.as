package dark.views 
{
	import dark.GameTemplateEnums;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ahui
	 */
	public class MapRectFlowerSprite implements IMapRectNode
	{
		public var templateId:int = 0;
		
		private var _bound:Rectangle = null;
		
		public function get bound():Rectangle
		{
			return _bound;
		}
		
		public var flashBound:Rectangle = null;
		
		
		public function MapRectFlowerSprite(templateId:int, bound:Rectangle, flashBound:Rectangle) 
		{
			this.templateId = templateId;
			_bound = bound;
			this.flashBound = flashBound;
			
		}
		
		private var sprite:Sprite = null;
		private var isAdded:Boolean = false;
		
		public function hide(gameView:LazyGameView):void
		{
			if (sprite != null)
			{
				if (isAdded)
				{
					gameView.container.removeChild(sprite);
					isAdded = false;
				}
			}
		
		}
		
		public function display(gameView:LazyGameView, gameBound:Rectangle):void
		{
			
			if (sprite == null)
			{
				//trace("gameBound.intersects(_bound)", gameBound.intersects(flashBound), gameBound, flashBound);
				if (gameBound.intersects(flashBound))
				{
					sprite = makeSprite(gameView);
					//
					sprite.x = flashBound.x;
					sprite.y = flashBound.y;
						
					gameView.container.addChild(sprite);	
					isAdded = true;
					//trace("add flower", bound);
					
				}
			
			} else {
				if (!isAdded && gameBound.intersects(flashBound))
				{
					gameView.container.addChild(sprite);	
					isAdded  = true;
					//trace("add flower", bound);
				}
			}
			
		}
		
		public function makeSprite(gameView:LazyGameView):Sprite
		{
			var bd:BitmapData = gameView.app.getTemplateBd(templateId);
			
			var bmp:Bitmap = new Bitmap(bd);
			bmp.x = -bmp.width / 2;
			bmp.y = -bmp.height;
			
			//trace("GameTemplateEnums.T_FLOWER_START", templateId);
			
			switch (templateId) 
			{
				case GameTemplateEnums.T_FLOWER_START:
					//bmp.x += 32;
					bmp.y += 64;					
					break;
				case GameTemplateEnums.T_FLOWER_START+1:
					
					//bmp.y += 64;					
					break;
					
				case GameTemplateEnums.T_FLOWER_START+8:
					bmp.x += 32
					bmp.y += 150;					
					break;
					
				case GameTemplateEnums.T_FLOWER_START + 31:
					
					bmp.scaleX = -1;
					bmp.x = bmp.width - 160;
					bmp.y = -bmp.height + 128;					
					break;
				default:
			}
			
			var sprite:Sprite = new Sprite();
			sprite.addChild(bmp);
			
			return sprite;
			
		}
		
		
	}

}