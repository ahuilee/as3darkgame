package dark.works 
{
	import dark.GameAnimationEnums;
	import dark.IAnimationWorkDelegate;
	import dark.IGameObject;
	import dark.Game;
	import dark.net.commands.PlayerSkillUseCommand;
	import dark.net.GameObjectKey;
	import dark.objworks.SyncGameObjAnimationWork;
	import dark.simple.SimpleCharacter;	
	import dark.IWork;

	/**
	 * ...
	 * @author 
	 */
	public class PlayerSkillUseWork  implements IWork
	{
		
		public var game:Game = null;
		public var skillId:int = 0;
		public var targetObj:IGameObject = null;
		public var x2:int = 0;
		public var y2:int = 0;
		public var dir2:int = 0;
		
		public function PlayerSkillUseWork(skillId:int, targetObj:IGameObject, x2:int, y2:int, dir2:int, game:Game) 
		{
			this.skillId = skillId;
			this.targetObj = targetObj;
			
			this.x2 = x2;
			this.y2 = y2;
			this.dir2 = dir2;
			this.game = game;
		}
		
		public function run():void
		{
			trace("Run PlayerSkillUseWork");
			
			//game.player.setAnimationWork(new SyncGameObjAnimationWork(game.player, GameAnimationEnums.ATTACK2, 0, this, game));
			
			
			var objKey:GameObjectKey = null;
			
			if (targetObj != null)
			{
				objKey = targetObj.getObjKey();
			}
			
			
			
			var cmd:PlayerSkillUseCommand = new PlayerSkillUseCommand(skillId, objKey, x2, y2, dir2);
			
			game.conn.writeCommand(cmd, null);
		}
		
		
		public function getWorkWeighted():int
		{
			return 1;
		}
		
		public function except(err:Error):void
		{
			trace("PlayerSkillUseWork err", err);
		}
		
	}

}