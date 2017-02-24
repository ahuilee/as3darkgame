package dark.simple
{
	
	import flash.geom.Point;
	
	import dark.GameUtils;
	import dark.IGameObjWork;	
	import dark.GameEnums;
	import dark.Game;	
	import dark.IGameObjWork;
	import dark.net.commands.PlayerPositionChangeCommand;
	import dark.net.commands.PlayerPositionSyncCommand;
	import dark.net.commands.PlayerStandCommand;
	import dark.net.commands.PlayerWalkToCommand;
	import dark.objworks.DisplayDelegateWalkToAnimationWork;
	import dark.works.WriteCommandWork;
	import dark.logics.IGameObjMoveToLogicDelegate;
	import dark.logics.GameObjMoveToLogic;
	import dark.logics.MoveLogicCalcResult;
	
	public class SimpleCharacterWalkToWork implements IGameObjWork, IGameObjMoveToLogicDelegate
	{
		
		public var character:SimpleCharacter = null;
		public var moveToGamePt:Point = null;
		public var moveToFlashPt:Point = null;
		public var game:Game = null;		
		public var logic:GameObjMoveToLogic = null;
		
		
		public var walkAnimationWork:DisplayDelegateWalkToAnimationWork = null;
		
		public function SimpleCharacterWalkToWork(character:SimpleCharacter, moveToGamePt:Point, moveToFlashPt:Point, game:Game) 
		{
			this.character = character;
			this.moveToGamePt = moveToGamePt;
			this.moveToFlashPt = moveToFlashPt;
		
			this.walkAnimationWork =  character.getWalkAnimationWork();
			this.game = game;
			
			this.logic = new GameObjMoveToLogic();
		}
		
		private var _isDone:Boolean = false;
		

		public var lastWalkAnimationOffset:Number = 0;
		
		
		
		public function getStartTime():Number
		{
			return _startTime;
		}
		
		public function getMoveDuration():Number
		{
			var pt1:Point = character.gamePt;
			var pt2:Point = moveToGamePt;
			
			var dist:Number = Math.sqrt(Math.pow(pt2.x - pt1.x, 2) + Math.pow(pt2.y - pt1.y, 2));
			
			//trace("getMoveDuration dist", dist);
			
			var duration:Number = dist * 100.0 / character.getMoveSpeed();
			
			//trace("getMoveDuration", duration);
			
			return duration;
			
		}

		public function getMoveToGamePoint():Point
		{
			return moveToGamePt;
		}
		
		public function getMoveToFlashPoint():Point
		{
			return moveToFlashPt;
		}
		
		public function getFlashPoint():Point
		{
			return new Point(character.x, character.y);
		}
		
		public function getGamePoint():Point
		{
			return character.gamePt;
		}
		
		public	function hitTestMapBlocks(x:int, y:int):Boolean
		{
			return game.view.hitMapBlocks(x, y);
		}
		
		public function getGame():Game
		{
			return game;
		}
		

		private var _startTime:Number = 0;
		
		public function onStartWork():void
		{
			//character.playWalk1(0);
			_startTime = new Date().getTime();
			
			character.setAnimationWork(walkAnimationWork);
		
			var rot2:Number = Math.atan2(moveToFlashPt.x - character.x , moveToFlashPt.y - character.y) / Math.PI * 180;
			
			var dir2:int =  GameUtils.calcDirectionByRotation(rot2);
			
			character.changeDirection(dir2);
			
			
	
			//var endTime:Number = new Date().gettim
			
			var walkToCmd:PlayerWalkToCommand = new PlayerWalkToCommand(character._gamePt.x, character._gamePt.y, dir2, moveToGamePt.x, moveToGamePt.y);
			game.conn.writeCommand(walkToCmd);
			
			logic.init(this);
			
		}
		
		public function onWorkDone():void
		{
			var standCmd:PlayerStandCommand = new PlayerStandCommand(character.gamePt.x, character.gamePt.y, character.getDirection());
			
			game.conn.writeCommand(standCmd);
			
			character.getDisplayDelegate().changeViewToStand();
		}
		
		public function runWork(nowTime:Number):void
		{
			
			var result:MoveLogicCalcResult = logic.calc(nowTime, this);
			
			if (result.state == GameObjMoveToLogic.HAS_BLACK)
			{
				//trace("Walk to done!!");
			}
			
			if (result.state == GameObjMoveToLogic.CONTINUE)
			{
				game.onGamePlayerMove(result.x2, result.y2, character.direction);
				
			} else 
			{
				//trace("Walk to done!!");
				
				var syncCmd:PlayerPositionSyncCommand = new PlayerPositionSyncCommand(character.gamePt.x, character.gamePt.y, character.direction);
				game.app.putWork(new WriteCommandWork(game, syncCmd, null));
				
				
				character.setAnimationWork(null);
				_isDone = true;
			}
			
		}
		
		public function get isDone():Boolean
		{
			return _isDone;
		}
		
	}

}