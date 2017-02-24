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
	public class CItemStolenHpAttr extends CItemAttrBase
	{
		
		public var value:int = 0;
		public var percent:Number = 0;
		
		
		
		public override function loadData(rd:DataByteArray):ICItemInfoAttr
		{
			this.value = rd.readUInt24();
			this.percent = rd.readUnsignedByte() / 255.0;
			
			//trace("CItemStolenHpAttr value", value, this.percent );
			
			return this;
		}
		
		public override function initTextField(tf:TextField):void
		{
			var pn:int = (int)(percent * 100.0);
			
			tf.defaultTextFormat = new TextFormat(null, 14, 0xff0000);
			
			tf.text = pn + "% 偷取生命 " + value;
		}	
		
		
	}

}