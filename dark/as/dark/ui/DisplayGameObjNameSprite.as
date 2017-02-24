package dark.ui 
{
	import caurina.transitions.properties.CurveModifiers;
	import dark.IGameObject;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class DisplayGameObjNameSprite extends Sprite
	{
		
		private var _container:Sprite = new Sprite();
		private var _txtField:TextField = null;
		
		public 	var followObj:IGameObject;
		
		public function DisplayGameObjNameSprite() 
		{
			_container = new Sprite();
			_container.x = 3;
			_container.y = 3;
			addChild(_container);
			
			_txtField = new TextField();
			_txtField.selectable = false;
			_txtField.autoSize = TextFieldAutoSize.LEFT;

			_container.addChild(_txtField);
		}
		
		public function setName(name:String, color:uint):void
		{
			_txtField.defaultTextFormat = new TextFormat(null, 14, color);
			_txtField.text = name;
			
			
			drawBG();
		}
		
		
		private function drawBG():void
		{
			
			var g:Graphics = this.graphics;
			
			
			var w2:Number = Math.max(128, _container.width + 6);
			var h2:Number = 28;
			g.clear();
			
			g.beginFill(0x000000, 0.5);
			g.drawRect(0, 0, w2, h2);
			g.endFill();
			
		}
		
		
		
		
	}

}