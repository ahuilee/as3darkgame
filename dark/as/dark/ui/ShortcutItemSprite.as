package dark.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
		import dark.Game;

	/**
	 * ...
	 * @author ahui
	 */
	public class ShortcutItemSprite extends Sprite
	{

		public var keyCode:uint = 0;
		public var listView:ShortcutItemListView = null;	
		
		
		public var bitmap:Bitmap = null;
		
		private var container:Sprite = null;
		private var maskTextSprite:Sprite = null;
		
		public var itemSource:IShortcutItemSource = null;
		
		public function ShortcutItemSprite(keyCode:uint, listView:ShortcutItemListView) 
		{
			this.keyCode = keyCode;
			this.listView = listView;
		
			
			
			container = new Sprite();			
			addChild(container);
			
			bitmap = new Bitmap();			
			container.addChild(bitmap);
			
			maskTextSprite = new Sprite();
			container.addChild(maskTextSprite);
			maskTextSprite.alpha = 0.5;
			
			
			
			draw();
			drawMaskText();
		}
		
		public function setICONBitmapData(bd:BitmapData):void
		{
			bitmap.bitmapData = bd;
			
			if (bd != null)
			{
				bitmap.width = 64;
				bitmap.height = 64;
				bitmap.x = 64 / 2 - bitmap.width / 2;
				bitmap.y = 64 / 2 - bitmap.height / 2;
			}
		}
		
		
		public function drawMaskText():void
		{
			var maskBd:BitmapData = listView.game.app.getIconBdByKey("BD_ShortcutItem_Mask");
			var g:Graphics = maskTextSprite.graphics;
			
			g.clear();
			
			var matrix:Matrix = new Matrix();
			
			switch (keyCode) 
			{
				case Keyboard.Q:
					matrix.tx = 0;
					matrix.ty = 0;
					break;
					
				case Keyboard.W:
					matrix.tx = -64;
					matrix.ty = 0;
					break;
					
				case Keyboard.E:
					matrix.tx = -128;
					matrix.ty = 0;
					break;
				case Keyboard.R:
					matrix.tx = -192;
					matrix.ty = 0;
					break;
				default:
			}
			
			g.beginBitmapFill(maskBd, matrix, false, false);
			g.drawRect(0, 0, 64, 64);
			g.endFill();
			
		}
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			var BDClass:Class = listView.game.app.getUIBDKlass(4);
			var bd:BitmapData = new BDClass();
			
			var box:BitmapData = new BitmapData(83, 83, true, 0x00);
			
			box.copyPixels(bd, new Rectangle(289, 915, box.width, box.height), new Point(), null, null, false);
			
			
			var matrix:Matrix = new Matrix();
			
			matrix.scale(64 / box.width, 64 / box.height);
			
			g.beginBitmapFill(box, matrix, false, false);
			
			g.drawRect(0, 0, 64, 64);
			g.endFill();
			
		}
		
		private var hitDragRect:Rectangle = new Rectangle(0, 0, 64, 64);
		
		public function dragHitTest():Boolean
		{
			if (hitDragRect.contains(this.mouseX, this.mouseY))
			{
				return true;
			}
			
			return false;
		}
		
	}

}