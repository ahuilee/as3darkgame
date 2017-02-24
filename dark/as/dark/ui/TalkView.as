package dark.ui 
{
	import dark.net.commands.PlayerTalkWriteLineCommand;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import dark.Game;

	
	public class TalkView extends Sprite
	{
		public var game:Game = null;		
		
		
		
		public var container:Sprite = null;
		public var maskSprite:Sprite = null;
		
		public var viewWidth:int = 680;
		public var viewHeight:int = 240;
		
		public function TalkView(viewWidth:int, viewHeight:int, game:Game) 
		{
			this.viewWidth = viewWidth;
			this.viewHeight = viewHeight;
		
			this.game = game;			
			
			container = new Sprite();
			
			maskSprite = new Sprite();
			
			//container.blendMode = BlendMode.LAYER;
			
			addChild(container);
			addChild(maskSprite);
			
			container.blendMode =  BlendMode.LAYER;	
			container.alpha = 0.5;
			
			container.mask = maskSprite;
			
			drawMask();
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
		}
		
		public function sort():void
		{
			var y2:Number = 0;
			var i:int = 0;
			
			var numChildren:int = container.numChildren;
			
			for (i = 32; i < numChildren; i++)
			{
				container.removeChildAt(32);
			}
			
			for (i = 0; i < container.numChildren; i++)
			{
				var iobj:DisplayObject = container.getChildAt(i);
				iobj.y = y2;
				
				y2 += iobj.height + 8;
				
			}
		}
		
		private var defaultTxtFormat:TextFormat = new TextFormat(null, 12, 0xffffff);
		
		public function appendMessage(text:String):void
		{
			var txtBody:TextField = new TextField();			
			
			txtBody.x = 0;
			txtBody.y = 0;
			txtBody.textColor = 0xffffff;
			//txtBody.border = true;
			//txtBody.borderColor = 0xff0000;
			txtBody.autoSize = TextFieldAutoSize.LEFT;
			txtBody.wordWrap = true;	
			txtBody.selectable = false;
			txtBody.width = viewWidth;
			txtBody.defaultTextFormat = defaultTxtFormat;
			//txtBody.blendMode = BlendMode.LAYER;			
		
			txtBody.text = text;		
			
			
			container.addChildAt(txtBody, 0);
			
			sort();
			
		}
		
		public function draw():void
		{
		
		}
		
		public function drawMask():void
		{
			var g:Graphics = maskSprite.graphics;
			
			//g.clear();
			
			g.clear();
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(viewWidth, 96, 90, 0, 0);
			
			g.beginGradientFill(GradientType.LINEAR, [0x00, 0x00, 0x00], [1, 0.5, 0], [0, 128, 255], matrix);
			g.drawRect(0, 0, viewWidth, 96);
			
			g.endFill();
			
		
			
		}
		
		private function _keyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode) 
			{
				case Keyboard.ENTER:
					var text:String = "";
					
					trace("Enter", text);
					
					var cmd:PlayerTalkWriteLineCommand = new PlayerTalkWriteLineCommand(text);
					game.conn.writeCommand(cmd, null);
					
					break;
				default:
			}
		}
		
	}

}