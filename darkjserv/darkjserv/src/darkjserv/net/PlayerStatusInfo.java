package darkjserv.net;

import darkjserv.AttackDamageValue;

public class PlayerStatusInfo 
{

	public int maxHp;
	
	
	public int maxMp;
	
	
	public int charStr;
	public int charInt;
	public int charDex;
	public int charCon;
	public int charSpi;
	
	public int moveSpeed;
	public int attackSpeed;
	
	//public int attackDamage;
	public int magicAttackDamage;
	
	public int defense;
	public int magicDefense;
	
	public AttackDamageValue attackDamageValue = null;
	/*
	public int magicDamage;
	public int coldDamage;
	public int fireDamage;
	public int lightningDamage;
	public int poisonDamage;
	*/
	
	public GamePlayer player = null;
	
	public PlayerStatusInfo(GamePlayer player)
	{
		this.player = player;
		
	}
	
	public int getHp()
	{
		return player.getHp();
	}
	
	
	public int getMp()
	{
		return player.getMp();
	}
	
}
