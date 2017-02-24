package dark.ui 
{
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class VScrollableContainer extends Sprite
	{
		
		public var viewHeight:int = 0;
		public var viewWidth:int = 0;
		
		public var container:Sprite = null;
		
		private var _innerContainer:Sprite = null;
		
		private var _scrollBarSprite:Sprite = null;
		private var _scrollButton:Sprite = null;
		
		private var _maskSprite:Sprite = null;
		
		public function VScrollableContainer(viewWidth:int, viewHeight:int) 
		{
			this.viewWidth = viewWidth;
			this.viewHeight = viewHeight;		
			
			
			_innerContainer = new Sprite();
			
			addChild(_innerContainer);
			
			container = new Sprite();	
			
			_scrollBarSprite = new Sprite();
			_scrollButton = new Sprite();			
			
			_maskSprite = new Sprite();
			
			_innerContainer.addChild(container);
			_innerContainer.addChild(_maskSprite);
			_innerContainer.addChild(_scrollBarSprite);
			_innerContainer.addChild(_scrollButton);
			
			_maskSprite.graphics.clear();
			_maskSprite.graphics.beginFill(0xffffff, 1);
			_maskSprite.graphics.drawRect(0, 0, viewWidth-24, viewHeight);
			_maskSprite.graphics.endFill();
			
			container.mask = _maskSprite;
			
			_scrollBarSprite.y = _scrollButton.y = 0;
			_scrollBarSprite.x = _scrollButton.x = viewWidth - 24;		
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeFromStage);
			
		}
		
		private function _addedToStage(e:Event):void
		{
			draw();
			
			_scrollButton.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, _onWheel);
		}
		
		private function _onWheel(e:MouseEvent):void
		{
			trace("_onWheel", e.delta);
			
			this.scrollValue += e.delta * -5;
		}
		
		private function _removeFromStage(e:Event):void
		{
			_scrollButton.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
		}
		
		private var isPress:Boolean = false;
		private var _pressButtonY:Number = 0;
		private var pressStageY:Number = 0;
		
		private function _onMouseDown(e:MouseEvent):void
		{
			isPress = true;
			_pressButtonY = _scrollButton.y;
			pressStageY = stage.mouseY;
		}
		
		
		private var _scrollValue:int = 0;
		
		private var _scrollValueMax:Number = 0;
		
		public function set scrollValue(value:int):void
		{
			_scrollValue = value;
			
			if (_scrollValue < 0)
			{
				_scrollValue = 0;
			}
			
			if (_scrollValue > _scrollValueMax)
			{
				_scrollValue = _scrollValueMax;
			}
			
			var scrollTo:Number = _scrollValue / _scrollValueMax * (viewHeight - _scrollButton.height);
			
			trace("scrollTo", scrollTo, "_scrollValueMax", _scrollValueMax);
			_scrollButton.y = scrollTo;
			container.y = -_scrollValue;
		}
		
		public function get scrollValue():int
		{
			return _scrollValue;
		}
		
	
		
		private function _onMouseMove(e:MouseEvent):void
		{
			if (isPress)
			{
				var by2:Number = _pressButtonY + (stage.mouseY - pressStageY);
				
				var scroll2:int = by2 / (viewHeight - _scrollButton.height) * _scrollValueMax;
				
				trace("scroll2", scroll2);
				
				scrollValue = scroll2;
			}
		}
		
		private function _onMouseUp(e:MouseEvent):void
		{
			isPress = false;
		}
		
		private function _drawButton():void
		{
			var g:Graphics = _scrollButton.graphics;
			
			g.clear();
			var buttonHeight:Number = viewHeight;
			
			var scrollMax:int = 0;
			
			if (container.height > viewHeight)
			{
				var delta:Number = container.height - viewHeight;
				scrollMax = (int)(delta);	
				
				var p:Number = (viewHeight /  container.height);
					
				//trace("scroll p=", p, viewHeight, container.height);
				
				buttonHeight = viewHeight *  p;
				
				var minHeight:Number = viewHeight * 0.2;
				
				if (buttonHeight < minHeight)
				{
					buttonHeight = minHeight;
				}
				
				trace("buttonHeight", delta, buttonHeight);
			}
			
			
		
			
			g.beginFill(0x336699, 1);
			
			g.drawRect(0, 0, 24, buttonHeight);
			g.endFill();
			
			_scrollValueMax = scrollMax;
		
		}
		
		public function draw():void
		{
			
			//this.graphics.lineStyle(3, 0x00ff00);
			//this.graphics.drawRect(0, 0, viewWidth, viewHeight);
			
			var g:Graphics = _scrollBarSprite.graphics;
			
			g.clear();
			
			
			//var BDClass:Class = app.getUIBDKlass(4);
			//var bd:BitmapData = new BDClass();
			
			//var box:BitmapData = new BitmapData(83, 83, true, 0x00);
			
			
			g.beginFill(0x999999, 1);
			
			g.drawRect(0, 0, 24, viewHeight);
			
			g.endFill();
			
			
			_drawButton();
			
			
			
			
		}
		
		
		
	}

}