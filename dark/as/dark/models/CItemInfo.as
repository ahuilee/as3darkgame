package dark.models 
{
	/**
	 * ...
	 * @author ahui
	 */
	public class CItemInfo 
	{
		public var color:uint = 0;
		public var name:String = "";
		public var count:Number = 0;
		
		public var attrs:Array = null;
		
		public function toString():String
		{
			return  "<CItemInfo name=" + name + " count=" + count + ">";
		}
		
	}

}