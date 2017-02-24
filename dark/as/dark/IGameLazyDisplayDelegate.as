package dark 
{

	import flash.geom.Point;
	import flash.geom.Rectangle;
	import dark.logics.WalkAnimationLogic;
	/**
	 * ...
	 * @author ahui
	 */
	public interface IGameLazyDisplayDelegate 
	{
		
		function changeDirection(direction:int):void;
		
		function getGamePt():Point;
		
		function gameHitTestByRect(rect:Rectangle):Boolean;
		function gameHitTestMouse(mx:Number, my:Number):Boolean;
		
		function getNameBoxY():Number;
		
		
		
		
		function showHitTestRects():void;
		function hideHitTestRects():void;
		
		//function updateToNextFrame(nowTime:Number):void;

		function changeViewToStand():void;		
		function changeViewToWalk():void;		
		function changeViewToAttack1():void;	
		function changeViewToAttack2():void;		
		function changeViewToHurt1():void;
		function changeViewToDead1():void;
		
		function setAnimationStand1FrameIndex(fx:int):void;		
		function initAnimationStand1Data():AnimationInitData;
		
		function setAnimationWalk1FrameIndex(fx:int):void;		
		function initAnimationWalk1Data():AnimationInitData;
		
		function setAnimationAttack1FrameIndex(fx:int):void;		
		function initAnimationAttack1Data():AnimationInitData;
		
		function setAnimationAttack2FrameIndex(fx:int):void;		
		function initAnimationAttack2Data():AnimationInitData;
		
		function setAnimationHurt1FrameIndex(fx:int):void;		
		function initAnimationHurt1Data():AnimationInitData;		
		
	
		function setAnimationDead1FrameIndex(frameIndex:int):void;		
		function initAnimationDead1Data():AnimationInitData;
	}
	
}