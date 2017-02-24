package darkjserv.monsters;


import java.util.ArrayList;
import java.util.List;

import darkjserv.CItemFactory;
import darkjserv.Factory;
import darkjserv.GameTemplateEnums;


import darkjserv.Utils;
import darkjserv.items.ICItem;

public class MonsterCreator 
{
	

	public IMonsterDelegate makeMonster01()
	{
		Factory factory = Factory.getInstance();
		
		long objId = factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC001, "¦Ï©Ç");
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(200);
		iobj.setMaxMp(100);
		iobj.setHp(200);		
		iobj.appendExpValue = 100;
		
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		
		iobj.setInteractiveDelegate(ai);
		

		ai.setDropItemDelegate(new Monster01DropDelegate());
		
		
		
		return ai;
	}
	
	public IMonsterDelegate makeMonsterByType(int type, int level)
	{
		switch(type)
		{
			case MonsterEnums.MONSTER_001:
				
				return makeMonster01();
				
			case MonsterEnums.MONSTER_002:
				
				return makeMonster02();
				
			case MonsterEnums.MONSTER_003:
				
				return makeMonster03();
				
			case MonsterEnums.MONSTER_004:
				
				return makeMonster005();
				
			case MonsterEnums.MONSTER_051:				
				return makeMonster051(level);
				
			case MonsterEnums.MONSTER_052:				
				return makeMonster052(level);
			case MonsterEnums.MONSTER_053:				
				return makeMonster053(level);
				
			case MonsterEnums.MONSTER_054:				
				return makeMonster054(level);
				
			case MonsterEnums.DRAGON_01:
				
				return makeMonsterDragon01();
		
		}
		
		return null;
	}
	
	
	

	
	public IMonsterDelegate makeMonster02()
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC002, "®üµs");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(100);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 128;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster02DropDelegate());

		
		return ai;
	}
	
	public IMonsterDelegate makeMonster03()
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC054, "´cÅ]");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(100);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 128;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster03DropDelegate());

		
		return ai;
	}
	
	public IMonsterDelegate makeMonster054(int level)
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC054, "´cÅ]");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(1000);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 256;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster03DropDelegate());

		
		return ai;
	}
	
	public IMonsterDelegate makeMonster053(int level)
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC053, "¦aº»ªk®v");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(1000);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 256;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster03DropDelegate());

		
		return ai;
	}
	
	public IMonsterDelegate makeMonster052(int level)
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC052, "¦aº»ªZ¤h");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(1000);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 256;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster03DropDelegate());

		
		return ai;
	}
	
	public IMonsterDelegate makeMonster051(int level)
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC051, "¦aº»¤ü");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(1000);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 256;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster03DropDelegate());

		
		return ai;
	}
	
	public IMonsterDelegate makeMonster005()
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_NPC051, "¦aº»¤ü");
		
		iobj.attackBoundSize = 256;
		iobj.setMaxHp(1000);
		iobj.setMaxMp(1000);
		iobj.setHp(1000);
		iobj.npcStr = 128;
		iobj.npcInt = 256;
		iobj.appendExpValue = 1024;
		
		LazyMonsterDelegate ai = new LazyMonsterDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new Monster03DropDelegate());

		
		return ai;
	}
	

	public IMonsterDelegate makeMonsterDragon01()
	{
		Factory factory = Factory.getInstance();
		
		long objId =  factory.makeObjId();
		
		SimpleMonster iobj = new SimpleMonster(objId, GameTemplateEnums.TC_DRAGON01, "¤õÀs");
		
		iobj.setMaxHp(1000000);
		iobj.setHp(100000);		
		
		iobj.setMaxMp(100000);
		iobj.setMp(100000);	
		
		iobj.npcStr = 512;
		iobj.npcInt = 512;
		iobj.attackBoundSize = 512;
		iobj.appendExpValue = 100000;
		
		
		LazyDragonDelegate ai = new LazyDragonDelegate(iobj, factory);
		iobj.setInteractiveDelegate(ai);
		
		ai.setDropItemDelegate(new MonsterDragon01DropDelegate());

		
		return ai;
	}
	

	class MonsterDragon01DropDelegate implements IMonsterDropItemDelegate
	{
		
		public List<ICItem> makeDropItems()
		{
			DropItemFactory dropFactory = new DropItemFactory();
			
			ArrayList<ICItem> items = new ArrayList<ICItem> ();
			
			items.add(dropFactory.randCoin(10000, 2000));
			
			for(int i=0; i>5; i++)
			{
				if(Utils.rand.nextInt(1000) > 200)
				{			
					items.add(dropFactory.randCoin(5000, 7000));
				}	
			}
			
			if(Utils.rand.nextInt(1000) > 200)
			{
				items.add(dropFactory.randHpLiquidSmall(1, 2));
			
			}
			
			
			if(Utils.rand.nextInt(1000) > 200)
			{
				items.add(dropFactory.randWeapon02(0));			
			}
			
			
			
			if(Utils.rand.nextInt(1000) > 700)
			{
				items.add(dropFactory.randArmor1(5));			
			}
			
			if(Utils.rand.nextInt(1000) > 800)
			{
				items.add(dropFactory.randArmor2(5));			
			}
			
			return items;
		}
		
	}
	
	class Monster03DropDelegate implements IMonsterDropItemDelegate
	{
		
		

		public List<ICItem> makeDropItems()
		{
			DropItemFactory dropFactory = new DropItemFactory();
			
			ArrayList<ICItem> items = new ArrayList<ICItem> ();
			
			items.add(dropFactory.randCoin(600, 1200));
			
			if(Utils.rand.nextInt(1000) > 300)
			{			
				items.add(dropFactory.randCoin(100, 500));
			}
			
			items.add(CItemFactory.getInstance().createGotoMap02MagicScroll(2));
			items.add(CItemFactory.getInstance().createGotoMap03MagicScroll(2));
			
			if(Utils.rand.nextInt(1000) > 300)
			{
				items.add(dropFactory.randHpLiquidSmall(1, 2));			
			}
			
			
			if(Utils.rand.nextInt(1000) > 700)
			{
				items.add(dropFactory.randWeapon02(1));			
			}
			
			if(Utils.rand.nextInt(1000) > 700)
			{
				items.add(dropFactory.randArmor1(2));			
			}
			
			if(Utils.rand.nextInt(1000) > 800)
			{
				items.add(dropFactory.randArmor2(2));			
			}
			
			if(Utils.rand.nextInt(1000) > 800)
			{
				items.add(dropFactory.randHelm2(2));			
			}
			

			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randBoots01(1));			
			}
			

			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randBoots02(2));			
			}
			
			
			return items;
		}
		
	}
	

	class Monster02DropDelegate implements IMonsterDropItemDelegate
	{
		
		

		public List<ICItem> makeDropItems()
		{
			DropItemFactory dropFactory = new DropItemFactory();
			
			ArrayList<ICItem> items = new ArrayList<ICItem> ();
			
			items.add(dropFactory.randCoin(600, 1200));
			
			if(Utils.rand.nextInt(1000) > 300)
			{			
				items.add(dropFactory.randCoin(100, 500));
			}
			
			
			if(Utils.rand.nextInt(1000) > 300)
			{
				items.add(dropFactory.randHpLiquidSmall(1, 2));			
			}
			
			
			if(Utils.rand.nextInt(1000) > 700)
			{
				items.add(dropFactory.randWeapon1(3));			
			}
			
			if(Utils.rand.nextInt(1000) > 700)
			{
				items.add(dropFactory.randArmor1(3));			
			}
			
			if(Utils.rand.nextInt(1000) > 800)
			{
				items.add(dropFactory.randHelm2(1));			
			}
			
			if(Utils.rand.nextInt(1000) > 500)
			{
				System.out.println("Make weapon9");
				items.add(dropFactory.randWeapon9(0));			
			}
			
			return items;
		}
		
	}
	
	class Monster01DropDelegate implements IMonsterDropItemDelegate
	{
		
		public Monster01DropDelegate()
		{
			
		}

		public List<ICItem> makeDropItems()
		{
			DropItemFactory dropFactory = new DropItemFactory();
			
			ArrayList<ICItem> items = new ArrayList<ICItem> ();
			
			items.add(dropFactory.randCoin(100, 500));
			
			
			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randHpLiquidSmall(1, 2));			
			}
			
			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randWeapon1(0));			
			}
			
			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randArmor1(0));			
			}
			
			if(Utils.rand.nextInt(1000) > 200)
			{
				items.add(dropFactory.randHelm1(0));			
			}
			
			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randBoots01(2));			
			}
			

			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randBoots02(2));			
			}
			
			
			return items;
		}
		
	}
	

}
