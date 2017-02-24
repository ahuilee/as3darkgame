package dark.objworks 
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import dark.*;
	import dark.logics.*;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class SyncGameObjDeadWork implements IGameObjAnimationWork
	{
		
		public var game:Game = null;
		public var syncDelegate:ISyncObjDelegate = null;
		
		private var _isDone:Boolean = false;
		
		public var startDuration:Number = 0;
		
		public function SyncGameObjDeadWork(syncDelegate:ISyncObjDelegate, startDuration:Number, game:Game) 
		{			
			this.syncDelegate = syncDelegate;		
		
			this.startDuration = startDuration;
			this.game = game;	
		}	

		
		public var deadLogic:DeadAnimationLogic = null;
		
		public function initWork():void
		{
			
			//_displayDelegate = syncDelegate.getDisplayDelegate();
			//_displayDelegate.changeViewToDead1();
			_isDone = false;
			
			syncDelegate.getDisplayDelegate().changeViewToDead1();
			
			deadLogic = new DeadAnimationLogic(syncDelegate.getDisplayDelegate(), startDuration, game);
			deadLogic.init();			
		
		}
		
		public function runWork(nowTime:Number):void
		{			
			if (!_isDone)
			{
				
				_isDone = !deadLogic.updateNext(nowTime);
			}
			//_isDone = innerAnimationWork.isDone;
		}
		
		public function except(err:Error):void
		{
			trace("DisplayDelegateWalkToAnimationWork", err.getStackTrace());
		}

		
		public function getGame():Game
		{
			return game;
		}
		
		public function get isDone():Boolean
		{
			//trace("SyncGameObjDeadWork get isDone");
			return false;
		}
		
	}

}