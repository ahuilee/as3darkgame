package dark.logics 
{
	import flash.geom.Point;
	
	import dark.IGameObject;	
	import dark.Game;
	
	public interface IGameObjMoveToLogicDelegate 
	{
		
		//function getGameObj():IGameObject;
		
		function getStartTime():Number;
		function getMoveToFlashPoint():Point;
		function getMoveToGamePoint():Point;
		
		function getGamePoint():Point;
		function getFlashPoint():Point;
		
		function getGame():Game;
		
		function hitTestMapBlocks(x:int, y:int):Boolean;
		
		
		function getMoveDuration():Number;
		
	
		
	}
	
}