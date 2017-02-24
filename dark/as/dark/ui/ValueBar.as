package dark.ui 
{
	import dark.Game;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ahui
	 */
	public class ValueBar extends Sprite
	{
		
		public var game:Game = null;
		
		private var _maxValue:int = 1;
		private var _value:int = 0;
		public var color:uint = 0xff0000;
		
		private var _txtField:TextField = null;
		
		public function ValueBar(game:Game) 
		{
			this.game = game;
			
			_txtField = new TextField();
			_txtField.selectable = false;
			_txtField.textColor = 0xffffff;
			_txtField.autoSize = TextFieldAutoSize.CENTER;
			_txtField.filters = [new GlowFilter(0x000000, 1, 6, 6, 2)];
			addChild(_txtField);
		}

		public function set maxValue(value:int):void
		{
			_maxValue = value;
			
			if (_maxValue < 1)
			{
				_maxValue = 1;
			}
		}
		
		public function set value(value:int):void
		{
			_value = value;
			
			//trace("set value(value:int):void", value);
		}
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			g.clear();
		
			
			var bd:BitmapData = game.app.getUIBd("ValueBar01");
			
				
			_txtField.text = "" + _value + "/" + _maxValue;
			
			_txtField.x = bd.width / 2 - _txtField.width / 2;
			_txtField.y = bd.height / 2 - _txtField.height / 2;
			
			
			var w2:Number = bd.width -4;
			var h2:Number = bd.height -4;
			
			
			g.beginFill(0xffffff, 1);			
			g.drawRect(2, 2, w2, h2);
			g.endFill();
			
			var percent:Number = _value / _maxValue;
			
			if (percent < 0)
			{
				percent = 0;
			}
			//percent = 1;
			
			g.beginFill(color, 1);
			
			g.drawRect(2, 2, w2 * percent, h2);
			g.endFill();
			
			g.beginBitmapFill(bd, null, false, false);
			g.drawRect(0, 0, bd.width, bd.height);
			g.endFill();
			
			//g.lineStyle(1, 0x00ff00);
			//g.drawRect(0, 0, bd.width, bd.height);
			
			
		}
		
	}

}