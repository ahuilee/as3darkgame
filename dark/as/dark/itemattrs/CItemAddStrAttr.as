package dark.itemattrs 
{

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import dark.net.DataByteArray;
	import dark.models.ICItemInfoAttr;
	/**
	 * ...
	 * @author 
	 */
	public class CItemAddStrAttr extends CItemAttrBase
	{
		
		public var value:int = 0;
		
		public function CItemAddStrAttr() 
		{			
		}
		
		public override function loadData(rd:DataByteArray):ICItemInfoAttr
		{
			this.value = rd.readUInt24();			
			
			return this;
		}
		
		public override function initTextField(tf:TextField):void
		{

			tf.defaultTextFormat = new TextFormat(null, 14, 0xffffff);
			
			tf.text = "+" + value + " 力量";
		}	
		
		
	}

}