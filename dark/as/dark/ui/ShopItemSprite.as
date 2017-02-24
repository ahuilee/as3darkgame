package dark.ui 
{
	import dark.AppDelegate;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class ShopItemSprite extends Sprite
	{
		
		
		public var txtField:TextField = null;
		
		
		private var box:Bitmap = null;
		
		public function ShopItemSprite(app:AppDelegate) 
		{
			
			box = new Bitmap(app.getUIBd("BOX01"));
			
			addChild(box);
			
			box.width = box.height = 64;
			
			txtField = new TextField();
			
			
			txtField.selectable = false;
			txtField.textColor = 0xffffff;
			txtField.x = 72;
			txtField.y = 16;	
			txtField.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(txtField);
		}
		
	}

}