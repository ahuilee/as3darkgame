package dark.net 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface ICommand 
	{
		function get code():int;
		
		function getBytes():ByteArray;
		
	}
	
}