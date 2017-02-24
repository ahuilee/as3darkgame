package dark.logics 
{

	
	import dark.AnimationInitData;
	import dark.IGameLazyDisplayDelegate;
	import dark.Game;	
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author ahui
	 */
	public class StandAnimationLogic 
	{
		
	
		public var displayDelegate:IGameLazyDisplayDelegate = null;		
		public var game:Game = null;
		
		public var animationData:AnimationInitData = null;
		
		public var animationStartTime:Number = 0;
		public var animationDurationTotal:Number = 0;
		public var startDuration:Number = 0;

		public var numFrames:int = 0;
		
		public var frameChangeValue:int = 0;
		public var frameIndexBegin:int = 0;

		public var y2:int = 0;
		
		public function StandAnimationLogic(displayDelegate:IGameLazyDisplayDelegate, game:Game) 
		{
			this.displayDelegate = displayDelegate;
			this.game = game;
			this.animationData = displayDelegate.initAnimationStand1Data();
		
			
			this.startDuration = 0;
			
			
			this.game = game;
		}
		
		private var _isDone:Boolean = false;
		
		public function init()
		{			
			_isDone = false;
			
			animationStartTime = new Date().getTime();
			
			animationDurationTotal = animationData.totalDuration;
			
			numFrames = animationData.numFrames;
			frameIndexBegin = (int)(numFrames * startDuration / animationDurationTotal);
			frameChangeValue = (numFrames - frameIndexBegin) - 1;
				
				
			var happendTime:Number = startDuration;
			
			var SoundClass:Class = animationData.soundClass;	
				
			if (SoundClass != null)
			{
				var sound:Sound = new SoundClass();				
				//trace("SyncGameObjDeadWork happendTime",  happendTime, "sound.length", sound.length);
					
				if (happendTime < sound.length)
				{
					
					var gameViewCenter:Point = game.view.centerGamePt;
					var gamePt:Point = displayDelegate.getGamePt();
					var objDist:Number = Math.sqrt(Math.pow(gameViewCenter.x -gamePt.x, 2) + Math.pow(gameViewCenter.y - gamePt.y, 2));
					
					var volume:Number = 1.0 / objDist / 8.0;
					
					if (volume < 0.2)
					{
						volume = 0.2;
					}
					
					trace("AnimationLogic volume", volume, "objDist", objDist, gamePt, gameViewCenter);
					var transform:SoundTransform = new SoundTransform(volume);
						
					var soundStartTime:Number = sound.length * happendTime / sound.length;
						
					//trace("DeadSound",  SoundClass, "soundStartTime", soundStartTime);
					sound.play(soundStartTime, 0, transform);
					
				}
			}
		}
		
		
		
		public function calcFrameIndex(frameChangeValue:int, time:Number, durationTotal:Number, frameIndexBegin:int)
		{
			return frameChangeValue * time / durationTotal + frameIndexBegin;
		}
		
		public function updateNext(nowTime:Number):Boolean
		{
			if (_isDone) return false;
			
			//circle
			var time:Number = (nowTime - animationStartTime + startDuration) % animationDurationTotal;		
		
			
			if (time >= animationDurationTotal)
			{				
				_isDone = true;
				time = animationDurationTotal;
			}		
			
			var fx:int = calcFrameIndex(frameChangeValue, time, animationDurationTotal, frameIndexBegin);			
			
			//trace("fx", fx);
			
			
			displayDelegate.setAnimationStand1FrameIndex(fx);			
			
			
			return !_isDone;
		}
		
	}

}