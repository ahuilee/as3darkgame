package dark 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IGameDragEnterDelegate 
	{
		
		function setDragEnterObj(obj:*):void;
		function hitTestDragEnter(stage:Stage):Boolean;
		
	}
	
}