package dark 
{
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author ahui
	 */
	public interface IGameKeyboardEventDelegate 
	{
		
		function onKeyDown(e:KeyboardEvent);
		function onKeyUp(e:KeyboardEvent);
	}

}