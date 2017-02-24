package dark.logics 
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.Responder;
	
	import dark.AnimationInitData;
	import dark.ISyncObjDelegate;
	import dark.Game;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class AnimationLogic 
	{
		
		public var animationData:AnimationInitData = null;
		public var setFrameIndexCallback:Function = null;
		public var game:Game = null;
		
		
		public var animationStartTime:Number = 0;
		public var animationDurationTotal:Number = 0;
		public var startDuration:Number = 0;

		public var numFrames:int = 0;
		
		public var frameChangeValue:int = 0;
		public var frameIndexBegin:int = 0;

		public var syncDelegate:ISyncObjDelegate = null;
		public var y2:int = 0;
		
		public function AnimationLogic(animationData:AnimationInitData, setFrameIndexCallback:Function, syncDelegate:ISyncObjDelegate, startDuration:Number, game:Game) 
		{
			this.animationData = animationData;
			this.setFrameIndexCallback = setFrameIndexCallback;
			
			this.startDuration = startDuration;
			this.syncDelegate = syncDelegate;
			
			this.game = game;
		}
		
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
					var gamePt:Point = syncDelegate.getGamePoint();
					
					var objDist:Number = Math.sqrt(Math.pow(gameViewCenter.x -gamePt.x, 2) + Math.pow(gameViewCenter.y - gamePt.y, 2));
					
					var volume:Number = 1.0 ;
					
					if (objDist > 0)
					{
						volume = volume / objDist / 16.0;
					}
					
					if (volume < 0.2)
					{
						volume = 0.2;
					}
					
					//trace("AnimationLogic volume", volume, "objDist", objDist, gamePt, gameViewCenter);
					var transform:SoundTransform = new SoundTransform(volume);
						
					var soundStartTime:Number = sound.length * happendTime / sound.length;
						
					//trace("DeadSound",  SoundClass, "soundStartTime", soundStartTime);
					sound.play(soundStartTime, 0, transform);
					
				}
			}
		}
		
		private var _isDone:Boolean = false;
		
		public function calcFrameIndex(frameChangeValue:int, time:Number, durationTotal:Number, frameIndexBegin:int)
		{
			return frameChangeValue * time / durationTotal + frameIndexBegin;
		}
		
		public function updateNext(nowTime:Number):Boolean
		{
			if (_isDone)
			{				
				return false;
			}
			
			var time:Number = nowTime - animationStartTime + startDuration;		
		
			
			if (time >= animationDurationTotal)
			{				
				_isDone = true;
				time = animationDurationTotal;
				
		
				
			}		
			
			var fx:int = calcFrameIndex(frameChangeValue, time, animationDurationTotal, frameIndexBegin);			
			
			/*
			if (_isDone)
			{
			
			trace("AnimationLogic fx", fx, _isDone);
			}*/
			
			setFrameIndexCallback(fx);			
			
			
			return !_isDone;
		}
		
	}

}