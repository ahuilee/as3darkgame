package dark.ui 
{
	import caurina.transitions.properties.SoundShortcuts;
	import dark.models.CItemInfo;
	import dark.models.ICItemInfoAttr;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.globalization.CurrencyFormatter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class DisplayItemInfoSprite extends Sprite
	{
		
		private var _container:Sprite = null;
		private var bgSprite:Sprite = null;
		private var titleTxt:TextField = null;
		private var attrTxt:TextField = null;
		
		public function DisplayItemInfoSprite() 
		{
			
			bgSprite = new Sprite();
			bgSprite.alpha = 0.7;		

			_container = new Sprite();
			
			_container.x = 5;
			_container.y = 5;
			
			addChild(bgSprite);
			addChild(_container);
			

		}
		
		private var _lastInfo:CItemInfo = null;
		
		
		public function setItemText(text:String):void
		{
			
			_clear();
			
			_container.addChild(_createText(text, 0xffffff));	
			
			_sortAndDrawBG();
			//_drawBG();
			
			_lastInfo = null;
			
		}
		
		
		private function _clear():void
		{
			var numc:int = _container.numChildren;
			for (var i:int = 0; i < numc; i++)
			{
				_container.removeChildAt(0);
			}
			
			
		}
		
		private function _sortAndDrawBG():void 
		{
			var y2:Number = 0;
			var maxW:Number = 0;
			var i:int = 0;
			var obj:DisplayObject = null;
			
			for (i = 0; i < _container.numChildren; i++)
			{
				obj = _container.getChildAt(i);
				obj.y = y2;
				
				y2 += obj.height + 2;
				
				if (obj.width > maxW)
				{
					maxW = obj.width;
				}				
			}
			
			maxW = Math.max(maxW, 150);
			
			var wHalf:Number = maxW / 2 ;
			
			for (i = 0; i < _container.numChildren; i++)
			{
				obj = _container.getChildAt(i);
				
				obj.x = wHalf - obj.width / 2;
			}
			
			var g:Graphics = bgSprite.graphics;
			
		
			var h2:Number = y2 + 10;
			var w2:Number = maxW + 10;
			
			g.clear();
			g.beginFill(0x000000,  1);
			g.drawRect(0, 0, w2, h2);			
			g.endFill();
			
		}
		
		private function _createText(text:String, color:uint):TextField
		{
			var tf:TextField = new TextField();
			tf.selectable = false;			
			tf.textColor = 0xffffff;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat(null, 14, color);
			tf.text = text;
			return tf;
		}

		
		public function formatComma(num:Number):String
		{
			
			var src:String = num.toString();
			
			var startIdx:int = src.length % 3;		
			
			
			var parts:Array = [];
			
			if (startIdx > 0)
			{
				parts.push(src.substr(0, startIdx));				
			}
			
			for (var i:int = startIdx; i < src.length; i += 3)
			{
				parts.push(src.substr(i, 3));
			}
			
			return parts.join(",");
		}
		
		public function setItemInfo(info:CItemInfo):void
		{
			
			if (_lastInfo == info) return;
			
			_lastInfo =  info;
			
			_clear();
			
			var name:String = info.name
			
		
			
			var tfName:TextField = _createText(info.name, info.color);
			
			_container.addChild(tfName);	
			
		
			
			if (info.count > 1)
			{
				
				
				var tfNum:TextField = _createText("數量: " + formatComma(info.count), 0xffffff);
				
				

				_container.addChild(tfNum);	
				
		
			}
			
			for (var i:int = 0; i < info.attrs.length; i++)
			{
				var attr:ICItemInfoAttr = info.attrs[i];				
				
				var tfAttr:TextField = attr.makeTextField();		
				
				_container.addChild(tfAttr);	
				
			}
			
			_sortAndDrawBG();			
			//_drawBG();
			
		}
		
	
		
		
	}

}