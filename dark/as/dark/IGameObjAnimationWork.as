package dark 
{
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IGameObjAnimationWork 
	{
		function initWork():void;
		function runWork(nowTime:Number):void;
		
		function except(err:Error):void;
		
		function get isDone():Boolean;
	}
	
}