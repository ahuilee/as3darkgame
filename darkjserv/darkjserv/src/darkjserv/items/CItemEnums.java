package darkjserv.items;

import darkjserv.GameTemplateEnums;

public class CItemEnums 
{
	public static final byte TYPE_ITEM = 0x00;
	
	public static final byte TYPE_LIQUID = 0x02;
	public static final byte TYPE_SCROLL = 0x03;
	
	public static final byte TYPE_EQUIPMENT = 0x05;
	
	public static final byte EQUIPMENT_WEAPON = 0x00;
	public static final byte EQUIPMENT_ARMOR = 0x01;
	public static final byte EQUIPMENT_HELMET = 0x02;
	public static final byte EQUIPMENT_BOOTS = 0x03;
	public static final byte EQUIPMENT_GLOVE = 0x04;
	public static final byte EQUIPMENT_SHIELD = 0x05;
	public static final byte EQUIPMENT_RING = 0x06;
	
	
	public static final byte USE_RESULT_DELETE = 0x01;
	public static final byte USE_RESULT_GETINFO = 0x02;
	public static final byte USE_RESULT_CLEARDICT = 0x03;
	//public static final byte USE_RESULT_UPDATE_CHARINFO = 0x04;
	
	
	
	
	//ATTR TYPE
	public static final int AT_ATTACK_DAMAGE = 1;
	public static final int AT_MAGIC_ATTACK_DAMAGE = 2;
	
	public static final int AT_DEFENSE = 3;
	public static final int AT_MAGIC_DEFENSE = 4;
	
	public static final int AT_ADD_LUCKY = 7;
	
	public static final int AT_ADD_ATTACK_DAMAGE  = 8;
	public static final int AT_ADD_MAGIC_ATTACK_DAMAGE  = 9;
	
	public static final int AT_ADD_DEFENSE = 10;
	public static final int AT_ADD_MAGIC_DEFENSE = 11;
	
	public static final int AT_ADD_MAXHP = 21;
	public static final int AT_ADD_MAXMP = 22;
	
	public static final int AT_ADD_STR = 31;
	public static final int AT_ADD_INT = 32;
	public static final int AT_ADD_DEX = 33;
	public static final int AT_ADD_CON = 34;
	public static final int AT_ADD_SPI = 35;
	

	
	public static final int AT_ADD_ATTACK_SPEED = 41;
	public static final int AT_ADD_MOVE_SPEED = 42;
	
	public static final int AT_ADD_MAGIC_DAMAGE = 51;
	public static final int AT_ADD_COLD_DAMAGE = 52;
	public static final int AT_ADD_FIRE_DAMAGE = 53;
	public static final int AT_ADD_LIGHTNING_DAMAGE = 54;
	public static final int AT_ADD_POISON_DAMAGE = 55;
	
	public static final int AT_STOLEN_HP = 71;
	public static final int AT_STOLEN_MP = 72;
	
	
	
	
	
	
	public static byte getItemTypeByBaseId(int itemBaseId)
	{
		switch(itemBaseId)
		{
			case 1:
				return CItemEnums.TYPE_ITEM;
			case 3:
			case 4:
				return CItemEnums.TYPE_LIQUID;
				
			case 101:
			case 102:
			case 103:
				return 	CItemEnums.TYPE_SCROLL;
				
			case 10001:
			case 10002:
			case 10003:
			case 10004:
			case 10009:				
				
				
			case 20001:
			case 20002:
			case 20003:

			case 50001:
				return CItemEnums.TYPE_EQUIPMENT;
		}
		
		return 0;
	}
	

	
	public static int getTemplateIdByBaseId(int itemBaseId)
	{
		switch(itemBaseId)
		{
			case 1:
				return GameTemplateEnums.TI_INDEX_START + 0;
				
			case 3:
				return GameTemplateEnums.TI_INDEX_LIQUID_START + 0;
				
			case 4:
				return GameTemplateEnums.TI_INDEX_LIQUID_START + 1;
				
			case 101:
				return  GameTemplateEnums.TI_INDEX_START + 7;
				
			case 102:				
				return GameTemplateEnums.TI_INDEX_START + 8;
				
			case 103:
				return GameTemplateEnums.TI_INDEX_START + 8;
			
			//WEAPONS
			case 10001:
				return GameTemplateEnums.TI_INDEX_WEAPON_START + 0;
				
			case 10002:
				return GameTemplateEnums.TI_INDEX_WEAPON_START + 1;
			case 10009:				
				return GameTemplateEnums.TI_INDEX_WEAPON_START + 2; 
				
			//ARMORS
			case 20001:
				return  GameTemplateEnums.TI_INDEX_ARMOR_START + 0;
			case 20002:
				return  GameTemplateEnums.TI_INDEX_ARMOR_START + 0;
				
			case 50001:
				return GameTemplateEnums.TI_INDEX_WEAPON_START + 1;
				
		}
		
		
		return 0;
	}
	
	
}
