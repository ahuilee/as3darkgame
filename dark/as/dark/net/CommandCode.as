package dark.net 
{
	/**
	 * ...
	 * @author ahui
	 */
	public class CommandCode 
	{
		
		public static const GAME_LOGIN:int = 0x11;
		public static const GAME_SET_STAGESIZE:int = 0x12;
		
		public static const GAME_START:int = 0x21;
		
		public static const GAME_INIT:int = 0x22;
		public static const GAME_INIT_DONE:int = 0x23;
		public static const GAME_ASSET_GETINFO:int = 0x24;
		
		public static const MAP_CHUNK_LOAD:int = 0x30;
		
		public static const GAME_SYNC_DATA:int = 0x35;
		public static const GET_OBJINFO:int = 0x36;
		public static const GET_OBJNAME:int = 0x37;
		
		public static const GAME_REMOVE_OBJ:int = 0x41;
		
		public static const GAME_SOUND_PLAY:int = 0x51;
		
		
		
		public static const SKILL_EFFECT_PLAY:int = 0x52;
		public static const SKILL_EFFECT_PLAY_FOLLOW:int = 0x53;
		
		public static const DISPLAY_TALK_MESSAGE:int = 0x81;
		
		
		public static const PLAYER_TALK_WRITELINE:int = 0x191;
		
		public static const PLAYER_STAND:int = 0x201;	
		public static const PLAYER_WALKTO:int = 0x202;		
		public static const PLAYER_ATTACK:int = 0x203;
		
		public static const PLAYER_HURT_SET:int = 0x204;
		
		public static const PLAYER_POSITION_CHANGE:int = 0x221;
		public static const PLAYER_POSITION_SYNC:int = 0x222;	
		
		public static const PLAYER_ANIMATION:int = 0x231;	
		
		public static const PLAYER_INIT_INFO:int = 0x241;
		public static const PLAYER_CHARACTER_INFO:int = 0x242;	
		
		public static const PLAYER_ITEM_LIST:int = 0x251;
		public static const PLAYER_ITEM_USE:int = 0x252;
		public static const PLAYER_ITEM_INFO:int = 0x253;
		public static const PLAYER_ITEM_DROP:int = 0x254;
		
		public static const PLAYER_SKILL_LIST:int = 0x255;
		public static const PLAYER_SKILL_USE:int = 0x256;	
		
		public static const PLAYER_TELEPORT:int = 0x261;
		public static const  PLAYER_TELEPORT_DONE:int = 0x262;
		
		public static const PLAYER_LEVEL_UPDATE:int = 0x271;
		public static const PLAYER_HEALTH_UPDATE:int = 0x272;
		
		public static const PLAYER_GET_SHORTCUT_INFO:int = 0x291;
		public static const PLAYER_SHORTCUT_SETITEM:int = 0x292;
		
		public static const PLAYER_MAGIC_BUFF_ADD:int = 0x295;
		public static const PLAYER_MAGIC_BUFF_REMOVE:int = 0x296;
		
		public static const PLAYER_CITEM_TAKE:int = 0x351;
		
		public static const PLAYER_DEAD:int = 0x401;
		
		
		public static const SHOP_ITEM_LIST:int = 0x501;
		
	}

}