package dark.itemattrs 
{
	import dark.models.ICItemInfoAttr;
	import dark.net.DataByteArray;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class CItemAttrBase implements ICItemInfoAttr
	{
		
		
		
		public function CItemAttrBase() 
		{
			
		}
		
		public function loadData(rd:DataByteArray):ICItemInfoAttr
		{
			return this;
		}
		
		public function initTextField(tf:TextField):void
		{
			
		}
		
		public function makeTextField():TextField
		{
			var tf:TextField = new TextField();
			
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			//tf.textColor = 0xff0000;
			
			
			
			initTextField(tf);
		
			
			return tf;
			
		}
		
	}

}