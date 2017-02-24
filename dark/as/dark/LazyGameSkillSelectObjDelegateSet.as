package dark 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyGameSkillSelectObjDelegateSet implements IGameMouseSelectTargetDelegate
	{
		
		public var skillId:int = 0;
		public var game:Game = null;
		public function LazyGameSkillSelectObjDelegateSet(skillId:int, game:Game) 
		{
			this.skillId = skillId;
			this.game = game;
		}
		
		
		public function onSelectDone(iobj:IGameObject, gamePt:Point, flashPt:Point):void
		{
			
			
		
			var x1:Number = game.player.x;
			var y1:Number = game.player.y;
			
			var rot2:Number = Math.atan2(flashPt.x - x1 ,  flashPt.y - y1) / Math.PI * 180;
			var dir2:int = GameUtils.calcDirectionByRotation(rot2);
			
			trace("LazyGameSkillSelectObjDelegateSet onSelectDone", iobj, "dir2", dir2);
			
			game.skillUse(skillId, iobj, gamePt.x, gamePt.y, dir2);	
			
			
			
		}
		
	}

}