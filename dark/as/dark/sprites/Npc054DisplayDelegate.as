package dark.sprites 
{
	import dark.IGameLazyDisplayDelegate;
	import dark.Game;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ahui
	 */
	public class Npc054DisplayDelegate extends LazyNPCDisplayDelegate
	{
		
		public function Npc054DisplayDelegate(game:Game) 
		{
			super(game);
		}
		
		
		
		
		
		public override function getStand1FrameArrayKey():String
		{
			return "NPC054_STAND1";
		}
		
		public override function getWalk1FrameArrayKey():String
		{
			return "NPC054_WALK1";
		}
		
		public override function getAttack1FrameArrayKey():String
		{
			return "NPC054_ATTACK1";
		}
		
		public override function getAttack2FrameArrayKey():String
		{
			return "NPC054_ATTACK2";
		}
		
		public override function getHurt1FrameArrayKey():String
		{
			return "NPC054_HURT1";
		}
		
		public override function getDead1FrameArrayKey():String
		{
			return "NPC054_DEAD1";
		}
		
	}

}