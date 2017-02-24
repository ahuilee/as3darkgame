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
	public class DisplayDelegateFrameArrayDataSprite extends Sprite
	{
		
		public var frameArrayData:DisplayDelegateFrameArrayData = null;
		
		public var bitmap:Bitmap = null;
		
		public var direction:int = 0;
		
		private var _hitTestSpriteContainer:Sprite = null;
	
		
		public function DisplayDelegateFrameArrayDataSprite(frameArrayData:DisplayDelegateFrameArrayData) 
		{
			this.frameArrayData = frameArrayData;
			
			this.bitmap = new Bitmap();
			
			
			addChild(bitmap);
			
			if (DebugSetting.isShowGameObjHitTestRects)
			{
				showHitTestRects();				
			}
			//intHitTestBound();
		}
		
		
		public function showHitTestRects():void
		{
			initHitTestBound();
			_hitTestSpriteContainer.visible = true;
			showHitTestRectByDir(direction);
			
		}
		
		public function hideHitTestRects():void
		{
			initHitTestBound();
			_hitTestSpriteContainer.visible = false;
		}
		
		private var getHitTestBoundSpriteByIndex:Dictionary =  new Dictionary();
		
		private function initHitTestBound():void
		{
			if (_hitTestSpriteContainer == null)
			{
				_hitTestSpriteContainer = new Sprite();
				
				addChild(_hitTestSpriteContainer);
				
				for (var i:int = 0; i < frameArrayData.items.length; i++)
				{
					var item:DisplayDelegateFrameArrayDataItem = frameArrayData.items[i];
					
					
					var sprite:Sprite = new Sprite();
					var g:Graphics = sprite.graphics;
					
					if (item.hitTestBoundOuter != null)
					{
					
						g.lineStyle(2, 0xff0000);
						g.drawRect(item.hitTestBoundOuter.x, item.hitTestBoundOuter.y, item.hitTestBoundOuter.width, item.hitTestBoundOuter.height);
					
					//_hitTestSpriteContainer.addChild(sprite);
					
					}	
					
					if (item.hitTestRects != null)
					{
						g.lineStyle(2, 0x00ff00);
						for (var j:int = 0; j < item.hitTestRects.length; j++)
						{
							var rect:Rectangle = item.hitTestRects[j];
							
							g.drawRect(rect.x, rect.y, rect.width, rect.height);
							
						}
						
					}
					
					getHitTestBoundSpriteByIndex[i] = sprite;
					
					
				}
			
			}
			
		}
		
		private function showHitTestRectByDir(direction:int):void
		{
			if (_hitTestSpriteContainer != null && _hitTestSpriteContainer.visible)
			{
				var numChild:int = _hitTestSpriteContainer.numChildren;
				
				for (var i:int = 0; i < numChild; i++)
				{
					_hitTestSpriteContainer.removeChildAt(0);					
				}
				
				var hitTestBoundSprite:Sprite = getHitTestBoundSpriteByIndex[direction];
				if (hitTestBoundSprite != null)
				{
					_hitTestSpriteContainer.addChild(hitTestBoundSprite);
				}
			}
		}
		
		public function changeDirection(direction:int):void
		{
			this.direction = direction;
			
			//trace("changeDirection", direction);
			var item:DisplayDelegateFrameArrayDataItem = frameArrayData.items[direction];
			
			this.bitmap.x = item.x2;
			this.bitmap.y = item.y2;
			this.bitmap.scaleX = item.scaleX;
			this.bitmap.scaleY = item.scaleY;
			
			showHitTestRectByDir(direction);
		}
		
		public function setFrameIndex(fx:int):void
		{
			var bd:BitmapData = frameArrayData.items[direction].frames[fx];
			
			bitmap.bitmapData = bd;
			
		}
		
		
	}

}