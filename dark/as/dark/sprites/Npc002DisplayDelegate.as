package dark.sprites 
{
	import dark.GameSoundEnums;
	import dark.IGameLazyDisplayDelegate;
	import dark.Game;
	/**
	 * ...
	 * @author ahui
	 */
	public class Npc002DisplayDelegate extends LazyNPCDisplayDelegate
	{
		
		public function Npc002DisplayDelegate(game:Game) 
		{
			super(game);
		}
		
		
		public override function getNameBoxY():Number
		{
			return -160;
		}		
		
		
		public override function getStand1FrameArrayKey():String
		{
			return "NPC002_STAND1";
		}
		
		public override function getWalk1FrameArrayKey():String
		{
			return "NPC002_WALK1";
		}
		
		public override function getAttack1FrameArrayKey():String
		{
			return "NPC002_ATTACK1";
		}
		
		public override function getAttack2FrameArrayKey():String
		{
			return "NPC002_ATTACK2";
		}
		
		public override function getHurt1FrameArrayKey():String
		{
			return "NPC002_HURT1";
		}
		
		public override function getDead1FrameArrayKey():String
		{
			return "NPC002_DEAD1";
		}
		
		public override function getHurt1SoundClass():Class
		{
			return game.app.getSoundClass(GameSoundEnums.GS_BLACKKINGHT_HURT1);	
		}
		
		public override function getDead1SoundClass():Class
		{
			return game.app.getSoundClass(GameSoundEnums.GS_BLACKKINGHT_DEAD1);	
		}
		
		
		
	}

}