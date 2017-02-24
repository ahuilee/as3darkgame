package dark.objworks 
{
	import dark.IGameLazyDisplayDelegate;
	import dark.IGameObjAnimationWork;
	import dark.IGameObject;
	import dark.Game;
	import dark.logics.WalkAnimationLogic;
	/**
	 * ...
	 * @author ahui
	 */
	public class DisplayDelegateWalkToAnimationWork implements IGameObjAnimationWork
	{
		
		public var displayDelegate:IGameLazyDisplayDelegate = null;
		
		public var game:Game = null;
		
		public function DisplayDelegateWalkToAnimationWork(displayDelegate:IGameLazyDisplayDelegate, game:Game) 
		{
			this.displayDelegate = displayDelegate;
			this.game = game;	
			
			_logic = new WalkAnimationLogic(displayDelegate, 0, game);
			_logic.init();
		}
		
		private var _logic:WalkAnimationLogic = null;
		private var _isDone:Boolean = false;
		
		public function initWork():void
		{
			displayDelegate.changeViewToWalk();
		}
		
		public function runWork(nowTime:Number):void
		{
			//trace("updateNext DisplayDelegateWalkToAnimationWork");
			_logic.updateNext(nowTime);
		}
		
		public function except(err:Error):void
		{
			trace("DisplayDelegateWalkToAnimationWork", err.getStackTrace());
		}
		
		public function get isDone():Boolean
		{
			return _isDone;
		}
		
	}

}