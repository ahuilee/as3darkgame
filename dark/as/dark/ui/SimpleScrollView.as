package dark.ui 
{
	
	import dark.AppDelegate;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	/**
	 * ...
	 * @author ahui
	 */
	public class SimpleScrollView extends LazyBoxSprite
	{
		
		
		public var container:Sprite = null;
		
		private var _maskSprite:Sprite = null;
		
		
		
		public function SimpleScrollView(viewWidth:int, viewHeight:int, app:AppDelegate) 
		{			
			super(viewWidth, viewHeight, app);	
	
			
			container = new Sprite();
			container.x = 20;
			container.y = 48;
			
			addChild(container);
			
			_maskSprite = new Sprite();
			
			var maskG:Graphics = _maskSprite.graphics;
			maskG.clear();
			maskG.beginFill(0xffffff, 1);
			maskG.drawRect(0, 0, viewWidth - 30, viewHeight - 80);
			
			container.mask = _maskSprite;
			
			addChild(_maskSprite);
			
			this.addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			
			draw();
		}
		
		
		private function _addedToStage(e:Event):void
		{
			draw();
		}
		
		
		public function draw():void
		{
			
			trace("draw ItemListView");
			
			var g:Graphics = this.graphics;
			
			/*
			g.clear();
			
			g.lineStyle(1, 0xff0000);
			
			g.drawRect(0, 0, viewWidth, viewHeight);
			*/
			
			
		/*
			
			
			
			
			
			var matrix:Matrix = new Matrix();
			
			matrix.tx = 0;
			matrix.ty = -155;
			
			var scaleX:Number = viewWidth / 886.0;
			var scaleY:Number =  viewHeight / 300.0;
			
			trace("scaleX", scaleX, scaleY);			
			
			matrix.scale(scaleX, scaleY);
			
			g.beginBitmapFill(bd, matrix);		
		
			g.drawRect(0, 0, viewWidth, viewHeight);			

			g.endFill();
			*/
			
			
			
		}
		
		
	}

}