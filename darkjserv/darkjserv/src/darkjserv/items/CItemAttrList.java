package darkjserv.items;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;


public class CItemAttrList 
{
	
	
	
	public ICItem item = null;
	
	public CItemAttrList(ICItem item)
	{
		this.item = item;
	}	
	
	public int attackDamage = 0;
	public int addAttackDamage = 0;
	
	public int magicAttackDamage = 0;
	public int addMagicAttackDamage = 0;
	
	public int defense = 0;
	public int magicDefense = 0;
	
	public int addLucky = 0;
	public int addDefense = 0;
	
	
	
	public int addMaxHp = 0;
	public int addMaxMp = 0;
	
	public int addStr = 0;
	public int addInt = 0;
	public int addDex = 0;
	public int addCon = 0;
	public int addSpi = 0;
	
	public int addAttackSpeed = 0;
	public int addMoveSpeed = 0;
	
	public int addMagicDamage = 0;
	public int addColdDamage = 0;
	public int addFireDamage = 0;
	public int addLightningDamage = 0;
	public int addPoisonDamage = 0;
	
	
	public int stolenHp = 0;
	public int stolenMp = 0;
	public int stolenHpPercent = 0;
	public int stolenMpPercent = 0;
	
	public void setAttackDamage(int value)
	{
		attackDamage = value;
		

	}
	
	public int getAttackDamage()
	{
		return attackDamage;
	}	

	public void setAddAttackDamage(int value)
	{
		addAttackDamage = value;
		
	}
	
	public int getAddAttackDamage()
	{
		return addAttackDamage;
	}
	

	public void setMagicAttackDamage(int value)
	{
		magicAttackDamage = value;
		
	}	

	public int getMagicAttackDamage()
	{
		return magicAttackDamage;	
	}	
	
	public void setAddMagicAttackDamage(int value)
	{
		addMagicAttackDamage = value;
		

	}
	
	public int getAddMagicAttackDamage()
	{
		return addMagicAttackDamage;
	}
	
	
	
	public void setDefense(int value)
	{
		this.defense = value;		
		
		
	}
	
	public int getDefense()
	{
		return defense;
	}
	
	public void setMagicDefense(int value)
	{
		this.magicDefense = value;
				
	}
	
	public int getMagicDefense()
	{
		return magicDefense;
	}
	
	
	public void setAddMaxHp(int value)
	{
		addMaxHp = value;
		
	}
	
	public int getAddMaxHp()
	{
		return addMaxHp;
	}
	
	public void setAddMaxMp(int value)
	{
		addMaxMp = value;
		
	}
	
	public int getAddMaxMp()
	{
		return addMaxMp;
	}
	
	
	
	public void setAddStr(int value)
	{
		addStr = value;
		
	}
	

	public int getAddStr()
	{
		return addStr;
	}
	
	public void setAddInt(int value)
	{
		addInt = value;
		
	}
	
	public int getAddInt()
	{
		return addInt;
	}
	
	
	public void setAddDex(int value)
	{
		addDex = value;
		
	}
	
	public int getAddDex()
	{
		return addDex;
	}
	
	
	public void setAddCon(int value)
	{
		addCon = value;
		
	}
	
	public int getAddCon()
	{
		return addCon;
	}	
	

	public void setAddSpi(int value)
	{
		addSpi = value;
		
	}
	
	public int getAddSpi()
	{
		return addSpi;
	}
	
	
	
	public void setAddDefense(int value)
	{
		addDefense = value;
		

	}
	
	public int getAddDefense()
	{
		return addDefense;
	}
	
	public int addMagicDefense = 0;
	
	public void setAddMagicDefense(int value)
	{
		addMagicDefense = value;
		

	}
	
	public int getAddMagicDefense()
	{
		return addMagicDefense;
	}
	
	
	public void setAddAttackSpeed(int value)
	{
		addAttackSpeed = value;
		
	}
	
	public int getAddAttackSpeed()
	{
		return addAttackSpeed;
	}
	
	public void setAddMoveSpeed(int value)
	{
		addMoveSpeed = value;
		
	}
	
	public int getAddMoveSpeed()
	{
		return addMoveSpeed;
	}
	
	public void setAddLucky(int value)
	{
		addLucky = value;
		
	}
	
	public int getAddLucky()
	{
		return addLucky;
	}
	
	public void setAddMagicDamage(int value)
	{
		addMagicDamage = value;
		
	}
	
	public int getAddMagicDamage()
	{
		return addMagicDamage;
	}
	
	public void setAddColdDamage(int value)
	{
		addColdDamage = value;
		
	}
	
	public int getAddColdDamage()
	{
		return addColdDamage;
	}
	
	public void setAddFireDamage(int value)
	{
		addFireDamage = value;
		
	}
	
	public int getAddFireDamage()
	{
		return addFireDamage;
	}
	
	public void setAddLightningDamage(int value)
	{
		addLightningDamage = value;
		
	}
	
	public int getAddLightningDamage()
	{
		return addLightningDamage;
	}
	
	public void setAddPoisonDamage(int value)
	{
		addPoisonDamage = value;
	
	}
	
	public int getAddPoisonDamage()
	{
		return addPoisonDamage;
	}
	
	
	
	public void setStolenHp(int value, int percent)
	{
		stolenHp = value;
		stolenHpPercent = percent;
		

	}
	
	public int getStolenHp()
	{
		return stolenHp;
	}
	
	public int getStolenHpPercent()
	{
		return stolenHpPercent;
	}
	
	public void setStolenMp(int value, int percent)
	{
		stolenMp = value;
		stolenMpPercent = percent;		
		
	}
	
	public int getStolenMp()
	{
		return stolenMp;
	}
	
	public int getStolenMpPercent()
	{
		return stolenMpPercent;
	}
	

	
	
	public static final int TERMINAL = 0xffff; 
	
	
	public void load(byte[] data)
	{
		int length = 0;
		
		for(int i=0; i<256; i++)
		{
			int attrType = ((data[length++] << 8) & 0xff00) | (data[length++] & 0x00ff) ;
			
			if(attrType == TERMINAL) break;
			
			switch(attrType)
			{
				case CItemEnums.AT_ATTACK_DAMAGE:
					attackDamage = ((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
				case CItemEnums.AT_MAGIC_ATTACK_DAMAGE:
					magicAttackDamage = ((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;	
				case CItemEnums.AT_DEFENSE:
					defense = ((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;	
					
				case CItemEnums.AT_MAGIC_DEFENSE:
					magicDefense =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_LUCKY:
					addLucky =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;	
					
				case CItemEnums.AT_ADD_ATTACK_DAMAGE:
					addAttackDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_MAGIC_ATTACK_DAMAGE:
					addMagicAttackDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_DEFENSE:
					addDefense =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_MAGIC_DEFENSE:
					addMagicDefense =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_MAXHP:
					addMaxHp =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_MAXMP:
					addMaxMp =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_STR:
					addStr =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_INT:
					addInt =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_DEX:
					addDex =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_CON:
					addCon =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_SPI:
					addSpi =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_ATTACK_SPEED:
					addAttackSpeed =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_MOVE_SPEED:
					addMoveSpeed =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_MAGIC_DAMAGE:
					addMagicDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_COLD_DAMAGE:
					addColdDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_FIRE_DAMAGE:
					addFireDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_LIGHTNING_DAMAGE:
					addLightningDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_ADD_POISON_DAMAGE:
					addPoisonDamage =((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					break;
					
				case CItemEnums.AT_STOLEN_HP:
					stolenHp = ((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					stolenHpPercent = data[length++] & 0xff;
					break;
					
				case CItemEnums.AT_STOLEN_MP:
					stolenMp = ((data[length++] << 16) & 0xff0000) | ((data[length++] << 8) & 0x00ff00) | (data[length++] & 0x0000ff);
					stolenMpPercent = data[length++] & 0xff;
					break;
			
			}
			
			
		}
		
		
	}
	
	public byte[] makeBytes()
	{
		byte[] data = new byte[4096];
		int length = 0;
		
		if(attackDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ATTACK_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ATTACK_DAMAGE & 0x00ff);
			data[length++] = (byte)((attackDamage & 0xff0000) >> 16);
			data[length++] = (byte)((attackDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(attackDamage & 0x0000ff);
		}
		
		if(magicAttackDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_MAGIC_ATTACK_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_MAGIC_ATTACK_DAMAGE & 0x00ff);
			data[length++] = (byte)((magicAttackDamage & 0xff0000) >> 16);
			data[length++] = (byte)((magicAttackDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(magicAttackDamage & 0x0000ff);
		
		}
		
		if(defense > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_DEFENSE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_DEFENSE & 0x00ff);
			data[length++] = (byte)((defense & 0xff0000) >> 16);
			data[length++] = (byte)((defense & 0x00ff00) >> 8);
			data[length++] = (byte)(defense & 0x0000ff);
			
		}
		
		if(magicDefense > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_MAGIC_DEFENSE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_MAGIC_DEFENSE & 0x00ff);
			data[length++] = (byte)((magicDefense & 0xff0000) >> 16);
			data[length++] = (byte)((magicDefense & 0x00ff00) >> 8);
			data[length++] = (byte)(magicDefense & 0x0000ff);
			
		}
		
		if(addLucky > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_LUCKY & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_LUCKY & 0x00ff);
			data[length++] = (byte)((addLucky & 0xff0000) >> 16);
			data[length++] = (byte)((addLucky & 0x00ff00) >> 8);
			data[length++] = (byte)(addLucky & 0x0000ff);
			
		}
		
		if(addAttackDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_ATTACK_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_ATTACK_DAMAGE & 0x00ff);
			
			data[length++] = (byte)((addAttackDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addAttackDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addAttackDamage & 0x0000ff);
		}
		
		if(addMagicAttackDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_MAGIC_ATTACK_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_MAGIC_ATTACK_DAMAGE & 0x00ff);
			data[length++] = (byte)((addMagicAttackDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addMagicAttackDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addMagicAttackDamage & 0x0000ff);			
		}
		
		if(addMaxHp > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_MAXHP & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_MAXHP & 0x00ff);
			data[length++] = (byte)((addMaxHp & 0xff0000) >> 16);
			data[length++] = (byte)((addMaxHp & 0x00ff00) >> 8);
			data[length++] = (byte)(addMaxHp & 0x0000ff);			
		}
		
		if(addMaxMp > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_MAXMP & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_MAXMP & 0x00ff);
			data[length++] = (byte)((addMaxMp & 0xff0000) >> 16);
			data[length++] = (byte)((addMaxMp & 0x00ff00) >> 8);
			data[length++] = (byte)(addMaxMp & 0x0000ff);			
		}
		
		if(addStr > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_STR & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_STR & 0x00ff);
			data[length++] = (byte)((addStr & 0xff0000) >> 16);
			data[length++] = (byte)((addStr & 0x00ff00) >> 8);
			data[length++] = (byte)(addStr & 0x0000ff);			
		}
		
		if(addInt > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_INT & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_INT & 0x00ff);
			data[length++] = (byte)((addInt & 0xff0000) >> 16);
			data[length++] = (byte)((addInt & 0x00ff00) >> 8);
			data[length++] = (byte)(addInt & 0x0000ff);			
		}
		
		if(addDex > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_DEX & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_DEX & 0x00ff);
			data[length++] = (byte)((addDex & 0xff0000) >> 16);
			data[length++] = (byte)((addDex & 0x00ff00) >> 8);
			data[length++] = (byte)(addDex & 0x0000ff);			
		}
		
		
		if(addCon > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_CON & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_CON & 0x00ff);
			data[length++] = (byte)((addCon & 0xff0000) >> 16);
			data[length++] = (byte)((addCon & 0x00ff00) >> 8);
			data[length++] = (byte)(addCon & 0x0000ff);			
		}
		
		if(addSpi > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_SPI & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_SPI & 0x00ff);
			data[length++] = (byte)((addSpi & 0xff0000) >> 16);
			data[length++] = (byte)((addSpi & 0x00ff00) >> 8);
			data[length++] = (byte)(addSpi & 0x0000ff);			
		}
		
		if(addAttackSpeed > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_ATTACK_SPEED & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_ATTACK_SPEED & 0x00ff);
			data[length++] = (byte)((addAttackSpeed & 0xff0000) >> 16);
			data[length++] = (byte)((addAttackSpeed & 0x00ff00) >> 8);
			data[length++] = (byte)(addAttackSpeed & 0x0000ff);			
		}
		
		if(addMoveSpeed > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_MOVE_SPEED & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_MOVE_SPEED & 0x00ff);
			data[length++] = (byte)((addMoveSpeed & 0xff0000) >> 16);
			data[length++] = (byte)((addMoveSpeed & 0x00ff00) >> 8);
			data[length++] = (byte)(addMoveSpeed & 0x0000ff);			
		}
		
		if(addMagicDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_MAGIC_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_MAGIC_DAMAGE & 0x00ff);
			data[length++] = (byte)((addMagicDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addMagicDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addMagicDamage & 0x0000ff);			
		}
		
		if(addColdDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_COLD_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_COLD_DAMAGE & 0x00ff);
			data[length++] = (byte)((addColdDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addColdDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addColdDamage & 0x0000ff);			
		}
		
		if(addFireDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_FIRE_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_FIRE_DAMAGE & 0x00ff);
			data[length++] = (byte)((addFireDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addFireDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addFireDamage & 0x0000ff);			
		}
		
		if(addLightningDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_LIGHTNING_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_LIGHTNING_DAMAGE & 0x00ff);
			data[length++] = (byte)((addLightningDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addLightningDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addLightningDamage & 0x0000ff);			
		}
		
		if(addPoisonDamage > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_ADD_POISON_DAMAGE & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_ADD_POISON_DAMAGE & 0x00ff);
			data[length++] = (byte)((addPoisonDamage & 0xff0000) >> 16);
			data[length++] = (byte)((addPoisonDamage & 0x00ff00) >> 8);
			data[length++] = (byte)(addPoisonDamage & 0x0000ff);			
		}
		
		
		if(stolenHp > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_STOLEN_HP & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_STOLEN_HP & 0x00ff);
			
			data[length++] = (byte)((stolenHp & 0xff0000) >> 16);
			data[length++] = (byte)((stolenHp & 0x00ff00) >> 8);
			data[length++] = (byte)(stolenHp & 0x0000ff);
			
			
			data[length++] = (byte)(stolenHpPercent & 0xff);
		}
		

		if(stolenMp > 0)
		{
			data[length++] = (byte)((CItemEnums.AT_STOLEN_MP & 0xff00) >> 8);
			data[length++] = (byte)(CItemEnums.AT_STOLEN_MP & 0x00ff);
			
			data[length++] = (byte)((stolenMp & 0xff0000) >> 16);
			data[length++] = (byte)((stolenMp & 0x00ff00) >> 8);
			data[length++] = (byte)(stolenMp & 0x0000ff);
	
			
			data[length++] = (byte)(stolenMpPercent & 0xff);
		}
		
		
		data[length++] = (byte)((TERMINAL & 0xff00) >> 8);
		data[length++] = (byte)(TERMINAL & 0x00ff);
		
		return Arrays.copyOfRange(data, 0, length);
	
	}
	
	

}
