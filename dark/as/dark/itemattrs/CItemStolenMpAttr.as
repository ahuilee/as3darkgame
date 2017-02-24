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
	public class CItemStolenMpAttr extends CItemAttrBase
	{
		
		public var value:int = 0;
		public var percent:Number = 0;
		
		
		
		public override function loadData(rd:DataByteArray):ICItemInfoAttr
		{
			this.value = rd.readUInt24();
			
			var bp:int =  rd.readUnsignedByte();
			
			this.percent = bp / 255.0;
			
			//trace("CItemStolenMpAttr value", value, this.percent, bp );
			
			return this;
		}
		
		public override function initTextField(tf:TextField):void
		{
			var pn:int = (int)(percent * 100.0);
			
			tf.defaultTextFormat = new TextFormat(null, 14, 0x00ccff);
			
			tf.text = pn + "% 偷取魔力 " + value;
		}
		
		
	}

}