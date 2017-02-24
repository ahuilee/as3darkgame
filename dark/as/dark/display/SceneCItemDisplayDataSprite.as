package dark.display 
{
	import dark.DebugSetting;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ahui
	 */
	public class SceneCItemDisplayDataSprite extends Sprite
	{
		
		public var displayData:SceneCItemDisplayData = null;
		
		public var bitmap:Bitmap = null;
		
		public var direction:int = 0;
		
		private var _hitTestSpriteContainer:Sprite = null;
	
		
		public function SceneCItemDisplayDataSprite(displayData:SceneCItemDisplayData) 
		{
			this.displayData = displayData;

			
			bitmap = new Bitmap();
			addChild(bitmap);		
			
			
			bitmap.bitmapData = displayData.bitmapData;
			
			
			bitmap.x = displayData.x2;
			bitmap.y = displayData.y2;
			bitmap.scaleX = displayData.scaleX;
			bitmap.scaleY = displayData.scaleY;
			
			if (DebugSetting.isShowGameObjHitTestRects)
			{
				showHitTestRects();				
			}
			//intHitTestBound();
		}
		
		public function gameHitTestMouse(mx:Number, my:Number):Boolean
		{
			
				if (displayData.outerRect != null)
				{
					var isHit:Boolean = displayData.outerRect.contains(this.mouseX, this.mouseY);
					
					if (isHit)
					{
						if (displayData.hitRects != null)
						{
							var rect:Rectangle = null;
							for (var i:int = 0; i < displayData.hitRects.length; i++)
							{
								rect = displayData.hitRects[i];
								
								if (rect.contains(this.mouseX, this.mouseY))
								{
									return true;
								}
							}
							
							return false;
						}
					
					}
					
					
				
				}
			

			return false;
		}
		
		
		public function showHitTestRects():void
		{
			initHitTestBound();
			_hitTestSpriteContainer.visible = true;		
			
		}
		
		public function hideHitTestRects():void
		{
			initHitTestBound();
			_hitTestSpriteContainer.visible = false;
		}
		
	
		
		private function initHitTestBound():void
		{
			if (_hitTestSpriteContainer == null)
			{
				_hitTestSpriteContainer = new Sprite();
				
				addChild(_hitTestSpriteContainer);
				
					
				var g:Graphics = _hitTestSpriteContainer.graphics;
				
				if (displayData.outerRect != null)
				{					
					g.lineStyle(2, 0xff0000);
					g.drawRect(displayData.outerRect.x, displayData.outerRect.y, displayData.outerRect.width, displayData.outerRect.height);
				
				}	
					
				if (displayData.hitRects != null)
				{
					g.lineStyle(2, 0x00ff00);
					for (var j:int = 0; j < displayData.hitRects.length; j++)
					{
						var rect:Rectangle = displayData.hitRects[j];
							
						g.drawRect(rect.x, rect.y, rect.width, rect.height);
					}						
				}
			}			
		}
		
	
		
	}

}