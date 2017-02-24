package dark 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IGameMouseSelectTargetDelegate 
	{
		function onSelectDone(iobj:IGameObject, gamePt:Point, flashPt:Point):void;
	}
	
}