package dark.logics 
{
	
	import dark.IGameObject;
	import flash.geom.Point;
	import dark.GameUtils;	
	import dark.Game;	
	
	public class GameObjMoveToLogic 
	{
		
		public static const CONTINUE:int = 1;
		public static const HAS_BLACK:int = 2;
		public static const DONE:int = 3;
		
		public var debug:Boolean = false;
		
		public function GameObjMoveToLogic()
		{
			
		}	
		
		private var _startTime:Number = 0;
		private var _duration:Number = 0;
		private var _beginPoint:Point = new Point();
		private var _gotoPoint:Point = new Point();
		private var _changeValue:Point = new Point();
	
			
		public function getStartTime():Number
		{
			return _startTime;
		}
		
		public function init(delegate:IGameObjMoveToLogicDelegate)
		{
			_startTime = delegate.getStartTime();
			
			var beignPt:Point = delegate.getGamePoint();
			var moveTo:Point = delegate.getMoveToGamePoint();
			
			_beginPoint.x = beignPt.x;
			_beginPoint.y = beignPt.y;
			
			_gotoPoint.x = moveTo.x;
			_gotoPoint.y = moveTo.y;
			
			_changeValue.x = _gotoPoint.x - _beginPoint.x;
			_changeValue.y = _gotoPoint.y  - _beginPoint.y;
			
			_duration = delegate.getMoveDuration();
			
			if (_duration < 1)
			{
				_duration = 1;
			}
			
		}
		
		public function calc(time:Number, delegate:IGameObjMoveToLogicDelegate):MoveLogicCalcResult
		{
			var game:Game = delegate.getGame();
	
			var objPt:Point = delegate.getGamePoint();
			
			
			var result:MoveLogicCalcResult = new MoveLogicCalcResult();	
		
			var t:Number = time - _startTime;
			
			var isDone:Boolean = false;
			
			if (t > _duration)
			{
				t = _duration;
				isDone = true;
			}

			var x2:int = _changeValue.x * t / _duration + _beginPoint.x;
			var y2:int = _changeValue.y * t / _duration + _beginPoint.y;		

			result.x2 = x2;
			result.y2 = y2;
			
			if (isDone)
			{
				result.state = DONE;
				return result;
			}
			
			var isBlock:Boolean = delegate.hitTestMapBlocks(x2, y2);
			
			
			if (isBlock)
			{
				result.state = HAS_BLACK;
				return result;
			}		
			
			
			result.state = CONTINUE;
			
			return result;
		}
		
	}

}