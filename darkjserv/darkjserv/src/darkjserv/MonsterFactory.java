package darkjserv;

import darkjserv.monsters.MonsterHandler1;


public class MonsterFactory 
{
	
	private static MonsterFactory _instance = null;
	 
	public static MonsterFactory getInstance()
	{
		if(_instance == null)
		{
			_instance = new MonsterFactory();
		}
		
		return _instance;
		
	}
	
	public MonsterHandler1 monsterHandler1 = null;
	
	public MonsterFactory()
	{
		
	}
	
	
	public void load()
	{
		
		monsterHandler1 = new MonsterHandler1(this);
	}
	
	
	public void start()
	{
		monsterHandler1.start();
	}
	

}
