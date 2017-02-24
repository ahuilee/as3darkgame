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
	public class CItemMagicAttackDamageAttr extends CItemAttrBase
	{
		
		public var value:int = 0;
	
		
		public function CItemMagicAttackDamageAttr() 
		{
			
		}
		
		public override function loadData(rd:DataByteArray):ICItemInfoAttr
		{
			this.value = rd.readInt24();			
			
			return this;
		}
		
		public override function initTextField(tf:TextField):void
		{
			
			
			tf.defaultTextFormat = new TextFormat(null, 14, 0x00ccff);
			
			tf.text = "魔法攻擊力: " + value;
		}	
		
		
	}

}