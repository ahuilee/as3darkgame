package dark 
{
	import dark.net.GameObjectKey;
	import flash.geom.Point;
	
	
	public interface IGameObject 
	{
		
		function get released():Boolean;
		function set released(value:Boolean):void;
		
		function updateState(nowTime:Number):void;
		
		function get gamePt():Point;
		function get flashX():int;
		function get flashY():int;
		
		function calcDisplayNameSpritePt(pt:Point):void;
		

		function getObjKey():GameObjectKey;
		function getObjType():int;

		function getInteractiveDelegate():IGameInteractiveDelegate;
		function getMouseDelegate():IGameLazyObjMouseDelegate;
		function getDisplayDelegate():IGameLazyDisplayDelegate;
		
		//function get 
	}
	
}