package darkjserv.net;

public class CommandCode 
{
	public static final int GAME_LOGIN = 0x11;
	public static final int GAME_SET_STAGESIZE = 0x12;
	
	public static final int GAME_START = 0x21;
	
	public static final int GAME_INIT = 0x22;
	public static final int GAME_INIT_DONE = 0x23;
	
	public static final int GAME_ASSET_GETINFO = 0x24;
	
	public static final int MAP_CHUNK_LOAD = 0x30;
	public static final int GAME_SYNC_DATA = 0x35;
	
	public static final int GET_OBJINFO = 0x36;	
	public static final int GET_OBJNAME = 0x37;
	public static final int GAME_REMOVE_OBJ = 0x41;
	
	public static final int GAME_SOUND_PLAY = 0x51;
	public static final int SKILL_EFFECT_PLAY = 0x52;
	public static final int SKILL_EFFECT_PLAY_FOLLOW = 0x53;
	
	public static final int DISPLAY_TALK_MESSAGE = 0x81;
	
	public static final int PLAYER_TALK_WRITELINE = 0x191;
	

	
	public static final int PLAYER_STAND = 0x201;
	public static final int PLAYER_WALKTO = 0x202;
	public static final int PLAYER_ATTACK = 0x203;
	
	public static final int PLAYER_HURT_SET = 0x204;
	
	public static final int PLAYER_POSITION_CHANGE = 0x221;
	public static final int PLAYER_POSITION_SYNC = 0x222;
	
	
	public static final int PLAYER_ANIMATION = 0x231;
	
	public static final int PLAYER_INIT_INFO = 0x241;
	public static final int PLAYER_CHARACTER_INFO = 0x242;
	
	public static final int PLAYER_ITEM_LIST = 0x251;
	public static final int PLAYER_ITEM_USE = 0x252;
	public static final int PLAYER_ITEM_INFO = 0x253;
	public static final int PLAYER_ITEM_DROP = 0x254;
	
	public static final int PLAYER_SKILL_LIST = 0x255;
	public static final int PLAYER_SKILL_USE = 0x256;
	
	public static final int PLAYER_TELEPORT = 0x261;
	public static final int PLAYER_TELEPORT_DONE = 0x262;
	
	public static final int PLAYER_LEVEL_UPDATE = 0x271;
	public static final int PLAYER_HEALTH_UPDATE = 0x272;
	
	public static final int PLAYER_GET_SHORTCUT_INFO = 0x291;
	public static final int PLAYER_SHORTCUT_SET = 0x292;
	
	public static final int PLAYER_MAGIC_BUFF_ADD = 0x295;
	public static final int PLAYER_MAGIC_BUFF_REMOVE = 0x296;
	
	public static final int PLAYER_CITEM_TAKE = 0x351;
	
	public static final int PLAYER_DEAD = 0x401;
	
	public static final int SHOP_ITEM_LIST = 0x501;

	
}
