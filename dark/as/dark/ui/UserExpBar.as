package dark.ui 
{
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import dark.Game;
	
	public class UserExpBar extends Sprite
	{
		
		
		public var viewWidth:int = 0;
		public var viewHeight:int = 0;
		public var game:Game = null;
		
		public var expBar:Sprite = null;
		
		public function UserExpBar(viewWidth:int, viewHeight:int, game:Game) 
		{
			this.viewWidth = viewWidth;
			this.viewHeight = viewHeight;
			this.game = game;
			
			this.expBar = new Sprite();
			addChild(expBar);
			expBar.x = 0;
			expBar.y = 16;
		}
		
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			g.clear();
			
			var BDKlass:Class = game.app.getUIBDKlass(2);
			
			//trace("draw UserExpBar", BDKlass);
			
			var viewWidthHalf:Number = viewWidth * .5;
			
			var bd:BitmapData = new BDKlass();
			
			var left:BitmapData = new BitmapData(70, 35, true, 0x00);
			left.copyPixels(bd, new Rectangle(520, 810, left.width, left.height), new Point(0, 0), null, null, true);
			
			var matrix:Matrix = new Matrix();
			
			matrix.scale(viewWidthHalf / left.width, 1);
			
			g.beginBitmapFill(left, matrix, false, false);
			g.drawRect(0, 0, viewWidthHalf, viewHeight);
			g.endFill();
			
			
			matrix.a = -1;
			matrix.tx = bd.width;
			
			g.beginBitmapFill(left, matrix, false, false);
			g.drawRect(viewWidthHalf, 0, viewWidthHalf, viewHeight);
			g.endFill();
		}
		
		
		public function update(percent:Number):void
		{
			
			var g:Graphics = expBar.graphics;
			
			g.clear();
			
			var expWidth:Number = percent * viewWidth;
			
			g.beginFill(0x336699, 1);
			g.drawRect(0, 0, expWidth, 8);
			g.endFill();
			
			
		}
		
	}

}