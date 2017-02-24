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
	import flash.text.engine.TextBlock;
	/**
	 * ...
	 * @author ahui
	 */
	public class MapRectTreeSprite implements IMapRectNode
	{
		public var templateId:int = 0;
		
		private var _bound:Rectangle = null;
		
		public function get bound():Rectangle
		{
			return _bound;
		}
		
		public var flashBound:Rectangle = null;
		
		
		public function MapRectTreeSprite(templateId:int, bound:Rectangle, flashBound:Rectangle) 
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
					//trace("remove tree", sprite);
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
					sprite = makeTree(gameView);
					//
					sprite.x = flashBound.x;
					sprite.y = flashBound.y;
						
					gameView.container.addChild(sprite);	
					isAdded = true;
					//trace("add tree", bound);					
				}
				
			
			} else {
				
				if (!isAdded && gameBound.intersects(flashBound))
				{					
					sprite.x = flashBound.x;
					sprite.y = flashBound.y;
					
					gameView.container.addChild(sprite);
					isAdded  = true;
					//trace("add tree2", bound);
				}				
			}
			
			if (sprite != null && gameView.focusDisplayObj != null)				
			{
				var isAlpha:Boolean = false;
					
				//trace("_alphaRects", _alphaRects);
					
				for (var i:int = 0; i < _alphaRects.length; i++)
				{
					var rect:Rectangle = _alphaRects[i];
						
					if (rect.contains(gameView.focusDisplayObj.x, gameView.focusDisplayObj.y))
					{
						isAlpha = true;
						break;
					}
				}
					
				if (isAlpha) {
					sprite.alpha = 0.35;
						
				} else {
					sprite.alpha = 1.0;
				}
			}
			
		}
		
		private var _alphaRects:Array = [];
		
		private function _makeAlphaGrid(rect:Rectangle):Shape
		{
			var shape:Shape = new Shape();
			var g:Graphics = shape.graphics;
			
			g.lineStyle(2, 0x00ff00);
			
			g.drawRect(0, 0, rect.width, rect.height);
			
			shape.x = rect.x;
			shape.y = rect.y;
			
			return shape;
		}
		
		private function _initTree1(gameView:LazyGameView, bmp:Bitmap )
		{
				//bmp.x += 32;
			bmp.y += 128;		
			var rect1:Rectangle  = new Rectangle(flashBound.x - 250, flashBound.y - 550, 400, 350);
			var rect2:Rectangle  = new Rectangle(flashBound.x - 50, flashBound.y - 200, 100, 200);
			var rect3:Rectangle  = new Rectangle(flashBound.x + 100, flashBound.y - 300, 250, 200);
			var rect4:Rectangle  = new Rectangle(flashBound.x - 300, flashBound.y - 380, 100, 250);
				
			_alphaRects.push(rect1);
			_alphaRects.push(rect2);
			_alphaRects.push(rect3);
			_alphaRects.push(rect4);
				
			//gameView.blockContainer.addChild(_makeAlphaGrid(rect1));
			//gameView.blockContainer.addChild(_makeAlphaGrid(rect2));
			//gameView.blockContainer.addChild(_makeAlphaGrid(rect4));
		}
		
		private function _initTree12(gameView:LazyGameView, bmp:Bitmap )
		{				
			//bmp.x += 32;
			bmp.x -= 32;
			bmp.y += 128;		
			var rect1:Rectangle  = new Rectangle(flashBound.x - 250, flashBound.y - 550, 400, 350);
			var rect2:Rectangle  = new Rectangle(flashBound.x - 50, flashBound.y - 200, 100, 200);
			var rect3:Rectangle  = new Rectangle(flashBound.x + 100, flashBound.y - 300, 250, 200);
			var rect4:Rectangle  = new Rectangle(flashBound.x - 300, flashBound.y - 380, 100, 250);
				
			_alphaRects.push(rect1);
			_alphaRects.push(rect2);
			_alphaRects.push(rect3);
			_alphaRects.push(rect4);
				
			//gameView.blockContainer.addChild(_makeAlphaGrid(rect1));
			//gameView.blockContainer.addChild(_makeAlphaGrid(rect2));
			//gameView.blockContainer.addChild(_makeAlphaGrid(rect4));
		}
		
		public function makeTree(gameView:LazyGameView):Sprite
		{
			var bd:BitmapData = gameView.app.getTemplateBd(templateId);
			
			var bmp:Bitmap = new Bitmap(bd);
			bmp.x = -bmp.width / 2;
			bmp.y = -bmp.height;
			
			switch (templateId) 
			{
				case GameTemplateEnums.T_TREE_START:
					_initTree1(gameView, bmp);		
					break;
				case GameTemplateEnums.T_TREE_START+1:
					
					bmp.y += 64;					
					break;
					
				case GameTemplateEnums.T_TREE_START+2:
					
					bmp.y += 128;					
					break;
					
				case GameTemplateEnums.T_TREE_START+3:
					
					bmp.x += 32;
					bmp.y += 384;					
					break;
					
				case GameTemplateEnums.T_TREE_START+11:
					_initTree12(gameView, bmp);				
					break;
				default:
			}
			
			var sprite:Sprite = new Sprite();
			sprite.addChild(bmp);
			
			return sprite;
			
		}
		
		
	}

}