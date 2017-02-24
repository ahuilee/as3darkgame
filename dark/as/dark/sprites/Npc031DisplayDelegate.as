package dark.sprites 
{
	import dark.IGameLazyDisplayDelegate;
	import dark.Game;
	/**
	 * ...
	 * @author ahui
	 */
	public class Npc031DisplayDelegate extends LazyNPCDisplayDelegate
	{
		
		public function Npc031DisplayDelegate(game:Game) 
		{
			super(game);
		}
		
		public override function getStand1FrameArrayKey():String
		{
			return "NPC031_STAND1";
		}
		
		public override function getWalk1FrameArrayKey():String
		{
			return "NPC031_WALK1";
		}
		
		public override function getAttack1FrameArrayKey():String
		{
			return "NPC031_ATTACK1";
		}
		
		public override function getAttack2FrameArrayKey():String
		{
			return "NPC031_ATTACK2";
		}
		
		public override function getHurt1FrameArrayKey():String
		{
			return "NPC031_HURT1";
		}
		
		public override function getDead1FrameArrayKey():String
		{
			return "NPC031_DEAD1";
		}
		
	}

}