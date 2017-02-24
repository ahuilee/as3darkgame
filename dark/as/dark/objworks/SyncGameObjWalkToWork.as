package dark.objworks 
{
	import flash.geom.Point;
	import flash.net.Responder;
	
	import dark.*;
	import dark.logics.*;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class SyncGameObjWalkToWork  implements IGameObjAnimationWork, IGameObjMoveToLogicDelegate
	{
		
		public var game:Game = null;
		public var syncDelegate:ISyncObjDelegate = null;
		
		private var _isDone:Boolean = false;
		
		public var logic:GameObjMoveToLogic = null;
		
		public var gamePt1:Point = null;
		public var gamePt2:Point = null;
		
		public var flashPt1:Point = null;
		public var flashPt2:Point = null;
		
		public var startTime:Number = 0;
		public var duration:int = 0;
		
		public var walkAnimationWork:DisplayDelegateWalkToAnimationWork = null;
		
		public var debug:Boolean = false;
		
		public function SyncGameObjWalkToWork(syncDelegate:ISyncObjDelegate, gamePt1:Point, gamePt2:Point, startTime:Number, duration:int, game:Game) 
		{
			
			this.syncDelegate = syncDelegate;		
		
			this.gamePt1 = gamePt1;
			this.gamePt2 = gamePt2;
			
			this.startTime = startTime;
			this.duration = duration;
			this.game = game;
			
			this.flashPt1 =  game.view.calcGamePtToFlashPt(gamePt1.x, gamePt1.y);
			this.flashPt2 = game.view.calcGamePtToFlashPt(gamePt2.x, gamePt2.y);
			
			logic =  new GameObjMoveToLogic();
			
			walkAnimationWork = new DisplayDelegateWalkToAnimationWork(syncDelegate.getDisplayDelegate(), game);
		}
		
		public function getStartTime():Number
		{
			return startTime;
		}
		
		public function getMoveDuration():Number
		{			
			return duration;
			
		}
		
		public function initWork():void
		{
			_isDone = false;
			walkAnimationWork.initWork();
			logic.init(this);		
			
		
			
			if (debug)
			{
				logic.debug = true;
				trace("SyncWalk initWork ", "_isDone", _isDone);
			}
			
			runWork(new Date().getTime());

		}
		
		public function runWork(nowTime:Number):void
		{
			var status:MoveLogicCalcResult = logic.calc(nowTime, this);		
			
			walkAnimationWork.runWork(nowTime);
			/*
			if (debug)
			{
				trace("SyncWalk runWork", status.x2, status.y2, status.state);
			}*/
			
			switch (status.state) 
			{
				case GameObjMoveToLogic.CONTINUE:
				case  GameObjMoveToLogic.DONE:					
					syncDelegate.setCharacterPosition(status.x2, status.y2, syncDelegate.getDirection());				
					game.viewChanged  = true;
					break;
				default:
			}
			
			if (status.state != GameObjMoveToLogic.CONTINUE )
			{			
				_isDone = true;
				
			}
		}
		
		public function except(err:Error):void
		{
			trace("SyncGameObjWalkToWork", err.getStackTrace());
		}
		
		
		public function getMoveToGamePoint():Point
		{
			return gamePt2;
		}
		
		public function getMoveToFlashPoint():Point
		{
			return flashPt2;
		}
		
		public function getFlashPoint():Point
		{
			return flashPt1;
		}
		
		public function getGamePoint():Point
		{
			return gamePt1;
		}
		
		public	function hitTestMapBlocks(x:int, y:int):Boolean
		{
			//server calc
			return false;
		}
		
		public function getGame():Game
		{
			return game;
		}
		
		public function get isDone():Boolean
		{
			return _isDone;
		}
		
		public function toString():String
		{
			
			return "<SyncGameObjWalkToWork pt1=" + gamePt1.toString() + " pt2=" + gamePt2.toString() + " >";
		}
		
	}

}