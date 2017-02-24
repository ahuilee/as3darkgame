package dark 
{
	import dark.net.GameObjectKey;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface ISyncObjDelegate
	{
		
		function getObjKey():GameObjectKey;
		
		function getGamePoint():Point;
		function getFlashPoint():Point;
		
		
		function getDirection():int;
		function setDirection(dir:int):void;
		
		function setCharacterPosition(x:int, y:int, direction:int):void;
		function setTemplateId(objType:int, templateId:int):void;

		
		function deleteObj(game:Game):void;
		
		function getDisplayObjectRect():Rectangle;
		
	
		
		function setAnimationWork(iWork:IGameObjAnimationWork):void;
	
		
		function getDisplayDelegate():IGameLazyDisplayDelegate;
		
		
	}
	
}