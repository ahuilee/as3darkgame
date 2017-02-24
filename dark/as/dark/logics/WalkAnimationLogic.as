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
	public class WalkAnimationLogic 
	{
		
	
		public var displayDelegate:IGameLazyDisplayDelegate = null;		
		public var game:Game = null;
		
		public var animationData:AnimationInitData = null;
		
		public var animationStartTime:Number = 0;
		public var animationDurationTotal:Number = 0;
		public var startDuration:Number = 0;

		public var numFramesEnd:int = 0;
		
		public var frameChangeValue:int = 0;
		public var frameIndexBegin:int = 0;

		public var y2:int = 0;
		
		public function WalkAnimationLogic(displayDelegate:IGameLazyDisplayDelegate, startDuration:Number, game:Game) 
		{
			this.displayDelegate = displayDelegate;
			this.startDuration = startDuration;
			this.game = game;
			this.animationData = displayDelegate.initAnimationWalk1Data();
	
		}
		
		private var _isDone:Boolean = false;
		
		public function init()
		{			

			_isDone = false;
			
			
			animationStartTime = new Date().getTime();
			
			animationDurationTotal = animationData.totalDuration;
			
			numFramesEnd = animationData.numFrames;
			frameIndexBegin = (int)(numFramesEnd * startDuration / animationDurationTotal);
			frameChangeValue = (numFramesEnd - frameIndexBegin);
				
				
			var happendTime:Number = startDuration;			
			
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
			
			//trace("WalkAnimationLogic fx", fx, _isDone);
			displayDelegate.setAnimationWalk1FrameIndex(fx);			
			
			
			return !_isDone;
		}
		
	}

}