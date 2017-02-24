package dark.ui 
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class BaseDisplayNameSprite extends Sprite
	{
		private var _nameTxt:TextField = null;
		private var _bgSprite:Sprite = null;
		
		public function BaseDisplayNameSprite() 
		{
			
			var fmt:TextFormat = new TextFormat(null, 14, 0xffffff);;
			
			_nameTxt = new TextField();
			_nameTxt.autoSize = TextFieldAutoSize.LEFT;
			_nameTxt.selectable = false;
			_nameTxt.textColor = 0xffffff;
			
			_nameTxt.defaultTextFormat = fmt;
			
			_nameTxt.x = 5;
			_nameTxt.y = 5;
			
			//_nameTxt.filters = [new GlowFilter(0x000000, 1, 3, 3, 2), new GlowFilter(0x000000, 1, 3, 3, 2)];
			

			_bgSprite = new Sprite();
			
			_bgSprite.graphics.beginFill(0x000000, 0.75);
			_bgSprite.graphics.drawRect(0, 0, 10, 10);
			_bgSprite.graphics.endFill();
			
			addChild(_bgSprite);
			addChild(_nameTxt);
		}
		
		public function setText(text:String):void
		{
			_nameTxt.text = text;
			
			_bgSprite.width = _nameTxt.width + 10;
			_bgSprite.height = _nameTxt.height + 10;
			
		}
		
	}

}