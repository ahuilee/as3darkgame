package dark.sprites 
{
	import dark.IGameLazyDisplayDelegate;
	import dark.Game;
	/**
	 * ...
	 * @author ahui
	 */
	public class Npc001DisplayDelegate extends LazyNPCDisplayDelegate
	{
		
		public function Npc001DisplayDelegate(game:Game) 
		{
			super(game);
		}
		
		public override function getNameBoxY():Number
		{
			return -160;
		}	
		
		public override function getStand1FrameArrayKey():String
		{
			return "NPC001_STAND1";
		}
		
		public override function getWalk1FrameArrayKey():String
		{
			return "NPC001_WALK1";
		}
		
		public override function getAttack1FrameArrayKey():String
		{
			return "NPC001_ATTACK1";
		}
		
		public override function getAttack2FrameArrayKey():String
		{
			return "NPC001_ATTACK2";
		}
		
		public override function getHurt1FrameArrayKey():String
		{
			return "NPC001_HURT1";
		}
		
		public override function getDead1FrameArrayKey():String
		{
			return "NPC001_DEAD1";
		}
		
	}

}