package dark.net 
{
	/**
	 * ...
	 * @author ahui
	 */
	public interface ICommandCallback 
	{
		
		function success(ask:int, packet:Packet):void;
		function errback(reason:String):void;
	}

}