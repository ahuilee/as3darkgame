package dark.ui 
{
	import dark.AppDelegate;
	import dark.Game;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyBoxSprite extends Sprite
	{
		
		public var viewWidth:int = 0;
		public var viewHeight:int = 0;
		public var app:AppDelegate = null;
		
		public function LazyBoxSprite(viewWidth:int, viewHeight:int, app:AppDelegate) 
		{
			this.viewWidth = viewWidth;
			this.viewHeight = viewHeight;
			this.app = app;
			
		}
		
		
		public function drawBgStyle4():void 
		{
			var g:Graphics = this.graphics;
			
			g.clear();
			
			var BDKlass:Class = app.getUIBDKlass(1);
			
			//trace("drawBgStyle3", BDKlass);
			
			var bd:BitmapData = new BDKlass();
			
			var box:BitmapData = new BitmapData(510, 712, true, 0x00);
			box.copyPixels(bd, new Rectangle(512, 0, box.width, box.height), new Point(0, 0), null, null, true);
			
			var matrix:Matrix = new Matrix();			
			
			//trace("scaleX", scaleX, scaleY);			
			
			matrix.scale(viewWidth / box.width, viewHeight / box.height);
			
			g.beginBitmapFill(box, matrix);		
		
			g.drawRect(0, 0, viewWidth, viewHeight);			

			g.endFill();
			
			//g.lineStyle(1, 0xff0000);
			
			//g.drawRect(0, 0, viewWidth, viewHeight);
			
		}
		
		public function drawBgStyle3():void 
		{
			
			var g:Graphics = this.graphics;
			
			g.clear();
			
			var BDKlass:Class = app.getUIBDKlass(2);
			
			//trace("drawBgStyle3", BDKlass);
			
			var bd:BitmapData = new BDKlass();
			
			var box:BitmapData = new BitmapData(500, 310, true, 0x00);
			box.copyPixels(bd, new Rectangle(0, 226, box.width, box.height), new Point(0, 0), null, null, true);
			
			var matrix:Matrix = new Matrix();			
			
			//trace("scaleX", scaleX, scaleY);			
			
			matrix.scale(viewWidth / 500, viewHeight / 310);
			
			g.beginBitmapFill(box, matrix);		
		
			g.drawRect(0, 0, viewWidth, viewHeight);			

			g.endFill();
			
			//g.lineStyle(1, 0xff0000);
			
			//g.drawRect(0, 0, viewWidth, viewHeight);
		}
		
		
		public function drawBgStyle2():void 
		{
			
			var g:Graphics = this.graphics;
			
			g.clear();
			
			var BDKlass:Class = app.getUIBDKlass(7);
			
			//trace("BDKlass", BDKlass);
			
			var bd:BitmapData = new BDKlass();
			
			var matrix:Matrix = new Matrix();
			
			matrix.tx = 0;
			matrix.ty = -155;
			
			var scaleX:Number = viewWidth / 886.0;
			var scaleY:Number =  viewHeight / 300.0;
			
			//trace("scaleX", scaleX, scaleY);			
			
			matrix.scale(scaleX, scaleY);
			
			g.beginBitmapFill(bd, matrix);		
		
			g.drawRect(0, 0, viewWidth, viewHeight);			

			g.endFill();
			
			//g.lineStyle(1, 0xff0000);
			
			//g.drawRect(0, 0, viewWidth, viewHeight);
		}
		
		
		public function drawBgStyle1():void
		{
			var g:Graphics = this.graphics;
			
			g.clear();
			
			var BDKlass:Class = app.getUIBDKlass(4);
			
			//trace("SimpleBoxStyle1");
			
			var bd:BitmapData = new BDKlass();	
			
			
			
			var bottomHeight:Number = 64;
			var bodyHeight:Number = viewHeight - 128;		
			
				
			var body:BitmapData = new BitmapData(510, 320, true, 0x00);
			body.copyPixels(bd, new Rectangle(0, 64, body.width, body.height), new Point(0, 0), null, null, true);
			
			var bodyMatrix:Matrix = new Matrix();
			
			var sx:Number =  viewWidth / body.width;
			var sy:Number = body.height / bottomHeight ;
			
			bodyMatrix.ty = body.height* sy;
			bodyMatrix.scale(sx,  sy);				
			
			g.beginBitmapFill(body, bodyMatrix, true, false);
			g.drawRect(0, bottomHeight, viewWidth, bodyHeight);
			g.endFill();
			
			var bottom:BitmapData = new BitmapData(510, 64, true, 0x00);
			
			bottom.copyPixels(bd, new Rectangle(0, 650, bottom.width, bottom.height), new Point(0, 0), null, null, true);	
			
			sx =  viewWidth / bottom.width;
			sy = bottomHeight / bottom.height;
			
			var topMatrix:Matrix = new Matrix();
			topMatrix.d = -1;
			topMatrix.ty = bottom.height;
			topMatrix.scale(sx, sy);
			
			g.beginBitmapFill(bottom, topMatrix, false, false);
			g.drawRect(0, 0, viewWidth, bottomHeight);
			g.endFill();
			
			
			var bottomMatrix:Matrix = new Matrix();
			
			bottomMatrix.scale(sx, sy);
			bottomMatrix.ty = bottomHeight + bodyHeight;
			
			g.beginBitmapFill(bottom, bottomMatrix, false, false);
			g.drawRect(0, bottomHeight + bodyHeight, viewWidth, bottomHeight);
			g.endFill();
/*
			g.lineStyle(2, 0xff0000);
			
			g.drawRect(0,  bottomHeight + bodyHeight, viewWidth, bottom.height);
			g.drawRect(0, 0, viewWidth, bottomHeight);
			*/
			/*
			var matrix:Matrix = new Matrix();
			g.beginBitmapFill(bd, matrix, false, false);
			
			g.drawRect(0, 32, viewWidth, viewHeight);
			
			g.endFill();
			
			g.lineStyle(1, 0xff0000);
			
			g.drawRect(0, 0, viewWidth, viewHeight);
			*/
		}
		
		
	}

}