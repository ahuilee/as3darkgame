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
	public class SyncGameObjAnimationWork implements IGameObjAnimationWork
	{
		
		public var game:Game = null;
		public var syncDelegate:ISyncObjDelegate = null;
		
		private var _isDone:Boolean = false;	
		
		public var animationId:int = 0;
		public var startDuration:Number = 0;
		
		
		public var animationLogic:AnimationLogic = null;
		
		public var animationDelegate:IAnimationWorkDelegate = null;
		
		public function SyncGameObjAnimationWork(syncDelegate:ISyncObjDelegate, animationId:int, startDuration:Number, animationDelegate:IAnimationWorkDelegate, game:Game) 
		{			
			this.syncDelegate = syncDelegate;		
		
			this.animationId = animationId;
			this.startDuration = startDuration;
			this.animationDelegate = animationDelegate;
			this.game = game;	
			
			//trace("SyncGameObjAnimationWork animationDelegate", animationDelegate);
		}	
		
		private var _displayDelegate:IGameLazyDisplayDelegate = null;		
		private var _isRun:Boolean = false;
		
		public function initWork():void
		{			
			_displayDelegate = syncDelegate.getDisplayDelegate();
			
			var data:AnimationInitData = null;
			var setFrameCallback:Function = null;
			
			switch (animationId) 
			{
				
				case GameAnimationEnums.ATTACK1:
					data = _displayDelegate.initAnimationAttack1Data();
					setFrameCallback = _displayDelegate.setAnimationAttack1FrameIndex;
					_displayDelegate.changeViewToAttack1();
					//trace("Ani ATTACK1", _displayDelegate, "startDuration", startDuration, data.totalDuration);
					break;
					
				case GameAnimationEnums.ATTACK2:
					data = _displayDelegate.initAnimationAttack2Data();
					setFrameCallback = _displayDelegate.setAnimationAttack2FrameIndex;
					_displayDelegate.changeViewToAttack2();
					break;
					
				case GameAnimationEnums.HURT1:				
					//trace("HURT1");					
					data = _displayDelegate.initAnimationHurt1Data();
					setFrameCallback = _displayDelegate.setAnimationHurt1FrameIndex;
					_displayDelegate.changeViewToHurt1();
					break;
					
				case GameAnimationEnums.DEAD1:
					trace("DEAD1!!!!!!!!!!!");	
					data = _displayDelegate.initAnimationDead1Data();
					setFrameCallback = _displayDelegate.setAnimationDead1FrameIndex;
					_displayDelegate.changeViewToDead1();
					break;
					
				default:
			}
			
			
			if (data != null)
			{
				//var startDuration:Number = data.totalDuration - remainingTime;				
				if (startDuration < 0)
				{
					startDuration = 0;
				}
				
				//trace("SyncGameObjAnimationWork startDuration=", startDuration, "remainingTime", remainingTime);
				
				//var pt:Point = syncDelegate.getGamePoint();
				animationLogic = new AnimationLogic(data, setFrameCallback, syncDelegate, startDuration, game);
				animationLogic.init();
				_isRun = true;
			}
			
			//syncDelegate.animationGotoAndPlay(GameAnimationEnums.WALK1, 0);			
		
		}
		
		public function onWorkDone():void
		{
			if (animationDelegate != null)
			{				
				animationDelegate.onAnimationWorkDone();
			}			
		}
		
		public function runWork(nowTime:Number):void
		{
			
			if (!_isRun) 
			{
				_isDone = true;
				return ;
			}
			
			_isDone = !animationLogic.updateNext(nowTime);
			

		
			if (_isDone)
			{
				onWorkDone();
			}
		}

		public function except(err:Error):void
		{
			trace("SyncGameObjAnimationWork", err.getStackTrace());
		}

		
		public function getGame():Game
		{
			return game;
		}
		
		public function get isDone():Boolean
		{
			return _isDone;
		}
		
	}

}