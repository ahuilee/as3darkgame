package dark.itemattrs 
{
	import dark.net.DataByteArray;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import dark.models.ICItemInfoAttr;
	/**
	 * ...
	 * @author 
	 */
	public class CItemDefenseAttr extends CItemAttrBase
	{
		
		public var value:int = 0;
	
		public override function loadData(rd:DataByteArray):ICItemInfoAttr
		{
			this.value = rd.readUInt24();		
		
			
			return this;
		}
		
		public override function initTextField(tf:TextField):void
		{			
			
			tf.defaultTextFormat = new TextFormat(null, 14, 0xffffff);
			
			tf.text = "防禦力: " + value;
		}	
		
		
	}

}