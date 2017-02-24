package dark.net 
{

	/**
	 * ...
	 * @author ahui
	 */
	public class Packet 
	{
		public var type:int = 0;
		public var qid:int = 0;
		public var body:DataByteArray = null;	
		
		
		public function toString():String 
		{
			return "<Packet type=" + type + " qid=" + qid + ">";
		}
		
	}

}