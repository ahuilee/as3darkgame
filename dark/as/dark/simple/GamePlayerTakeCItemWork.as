package dark.simple
{
	import dark.IGameLazyDisplayDelegate;
	import dark.LazyGameSyncObjSet;
	import dark.net.commands.PlayerCItemTakeCommand;
	import dark.netcallbacks.PlayerTakeItemCallback;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import dark.AnimationInitData;
	import dark.GameUtils;
	import dark.IAnimationWorkDelegate;
	import dark.logics.AnimationLogic;
	import dark.net.commands.PlayerPositionChangeCommand;
	import dark.net.commands.PlayerStandCommand;
	import dark.objworks.SyncGameObjAnimationWork;
	import dark.GameAnimationEnums;
	import dark.net.commands.PlayerAnimationCommand;
	import dark.net.commands.PlayerAttackCommand;
	import dark.net.GameObjectKey;
	import dark.IGameObject;
	import dark.Game;	
	import dark.IGameObjWork;

	
	public class GamePlayerTakeCItemWork implements IGameObjWork
	{		
		
		public var game:Game = null;
		
		public function get player():SimpleCharacter
		{
			return game.player;
		}		
		
		public var objSet:LazyGameSyncObjSet = null;	

		
		public function GamePlayerTakeCItemWork(objSet:LazyGameSyncObjSet, game:Game) 
		{
			
			this.objSet = objSet;
		
			this.game = game;
		}
		
		private var _isDone:Boolean = false;
		private var _isRun:Boolean = false;
		

		public function onStartWork():void
		{
		
			_isRun = true;
		}
		
		
		public function onAnimationWorkDone():void
		{
			
		}
		
		public function onWorkDone():void
		{
			trace("onWorkDone ATTACK!!!");
			
		}
		
		
		
		public	function runWork(nowTime:Number):void
		{
			if (!_isRun) 
			{
				_isDone = true;
				
				return;
			}
			
			var objFlashPt:Point = objSet.getFlashPoint();
			var takeBound:Rectangle = new Rectangle(game.player.x-64, game.player.y-64, 128, 128);
				
				
			var takeBoundForTarget2:Rectangle = takeBound.clone();
				
			takeBoundForTarget2.x -= objFlashPt.x;
			takeBoundForTarget2.y -= objFlashPt.y;
			
			var displayDelegate:IGameLazyDisplayDelegate = objSet.getDisplayDelegate();
			
			if (displayDelegate != null && displayDelegate.gameHitTestByRect(takeBoundForTarget2))
			{
					
				trace("GamePlayerTakeItemWork", objSet);
					
				
				
				
				var cmd:PlayerCItemTakeCommand = new PlayerCItemTakeCommand(objSet.getObjKey());
			
				var ask:int = objSet.game.writeCommand(cmd, new PlayerTakeItemCallback(objSet.game));
				trace("GamePlayerTakeItemWork", objSet, "ask", ask);
			}	
			
			_isDone = true;

		}
		
		public function get isDone():Boolean
		{
			return _isDone;
		}		
		
		
		
		public function getGame():Game
		{
			return game;
		}
		
	}

}