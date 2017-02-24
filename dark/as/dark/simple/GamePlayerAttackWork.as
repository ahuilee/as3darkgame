package dark.simple
{
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

	
	public class GamePlayerAttackWork implements IGameObjWork, IAnimationWorkDelegate
	{		
		
		public var game:Game = null;
		
		public function get player():SimpleCharacter
		{
			return game.player;
		}		
		
		public var attackObj:IGameObject = null;	
		public var attackObjKey:GameObjectKey = null;	
		
		public function GamePlayerAttackWork(attackObj:IGameObject, attackObjKey:GameObjectKey, game:Game) 
		{
			
			this.attackObj = attackObj;
			this.attackObjKey = attackObjKey;
			this.game = game;
		}
		
		private var _isDone:Boolean = false;
		private var _isRun:Boolean = false;
		
		
		var aniWork:SyncGameObjAnimationWork = null;
		var _lastAttackTime:Number = 0;
	
		
		public function cancel():void
		{
			_isDone = true;
			_isRun = false;
		}
		
		public function onStartWork():void
		{
			_attackContinue = true;
			_isRun = true;
		}
		
		public function runAttack(nowTime:Number):Boolean
		{
			
			
			
			var bounds:Rectangle = player.getAttackGameBounds();
			var isHit:Boolean = bounds.contains(attackObj.gamePt.x, attackObj.gamePt.y);
			//
			
			//trace("SimpleCharacterAttackWork runAttack isHit", isHit);
			if (isHit)
			{
				
				var attackDelta:Number = nowTime - _lastAttackTime;
				
				if (_attackContinue || attackDelta > 1000)
				{
					trace("SimpleCharacterAttackWork _lastAttackTime delta", _attackContinue);
				//trace("ATTACK delta", delta);
					

					var rot2:Number = Math.atan2(attackObj.flashX - player.x , attackObj.flashY - player.y) / Math.PI * 180;
				
					var dir2:int =  GameUtils.calcDirectionByRotation(rot2);
					
					if (dir2 != player.direction)
					{			
						player.changeDirection(dir2);
						
						var changeDirCmd:PlayerPositionChangeCommand = new PlayerPositionChangeCommand(player.gamePt.x, player.gamePt.y, player.direction);
						game.conn.writeCommand(changeDirCmd, null);
					
					}
					
					trace("Send Attack");
					
					
					var cmd:PlayerAttackCommand = new PlayerAttackCommand(attackObjKey);
					game.conn.writeCommand(cmd, null);			
					
					aniWork = new SyncGameObjAnimationWork(player, GameAnimationEnums.ATTACK1, 0, this, game);
					
					player.setAnimationWork(aniWork);
					
					_attackContinue = false;	
					_lastAttackTime = nowTime;
				}
				
				if (game.mouseHandler.getMouseIsPress() == false)
				{
					return false;
				}
			
				
				return true;
			}
			
			return false;
		}
		
		private var _attackContinue:Boolean = false;
		
		public function onAnimationWorkDone():void
		{
			trace("onAnimationWorkDone ATTACK");
			_attackContinue = true;
			
			var cmd:PlayerStandCommand = new PlayerStandCommand(player.gamePt.x, player.gamePt.y, player.direction);
			
			game.conn.writeCommand(cmd, null);
			player.getDisplayDelegate().changeViewToStand();
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
			
			
			if (runAttack(nowTime) == false)
			{				
				_isRun = true;	
				_isDone = true;
				return;
			}			
			

		}
		
		public function get isDone():Boolean
		{
			return _isDone;
		}		
		
		public function getMoveToGamePoint():Point
		{
			return attackObj.gamePt;
		}
		
		public function getMoveToFlashPoint():Point
		{
			return new Point(attackObj.flashX, attackObj.flashY);
		}
		
		public function getGameObjFlashPoint():Point
		{
			return new Point(player.x, player.y);
		}
		
		public function getGameObjGamePoint():Point
		{
			return player.gamePt;
		}
		
		public function getGame():Game
		{
			return game;
		}
		
	}

}