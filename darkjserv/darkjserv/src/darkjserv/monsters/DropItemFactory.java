package darkjserv.monsters;


import darkjserv.CItemFactory;

import darkjserv.Utils;
import darkjserv.items.CItemAttrList;

import darkjserv.items.ICItem;
import darkjserv.items.SimpleEquipment;

public class DropItemFactory
{
	
	
	
	public ICItem randCoin(int min, int max)
	{
	
		CItemFactory itemFactory = CItemFactory.getInstance();
		long count = Utils.rand.nextInt(max);
		
		if(count < min)
		{
			count = min;
		}
		
		ICItem coinItem = itemFactory.createCoin(count);
		
		
		
		return coinItem;
	}
	
	public ICItem randHpLiquidSmall(int min, int max)
	{
	
		CItemFactory itemFactory = CItemFactory.getInstance();
		
		long count = Utils.rand.nextInt(max);
		
		if(count < min)
		{
			count = min;
		}
		
		ICItem coinItem = itemFactory.createCoin(count);
		
		
		
		return coinItem;
	}
	
	public ICItem randWeapon1(int quality)
	{
	
		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createWeapon1Base();
		
		
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.attackDamage = new RandAttrSet(500, 10, 30);
		rand.addAttackDamage = new RandAttrSet(100, 10, 30);
		
		if(quality > 1)
		{
			rand.attackDamage = new RandAttrSet(500, 20, 30);
			rand.addAttackDamage = new RandAttrSet(500, 20, 30);
			
			rand.magicAttackDamage = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 5, 10);
			rand.addInt = new RandAttrSet(500, 5, 10);
			rand.addDex = new RandAttrSet(500, 5, 10);
			rand.addCon = new RandAttrSet(500, 5, 10);
			
			rand.stolenHp = new RandAttrSet(500, 5, 10);
			rand.stolenHpProbability = new RandAttrSet(500, 5, 10);
			
			rand.stolenMp = new RandAttrSet(500, 5, 10);
			rand.stolenMpProbability = new RandAttrSet(500, 5, 10);
		}
		
		
		rand.run(item);
		
		
		return item;
	}
	
	

	public ICItem randWeapon02(int quality)
	{
	
		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createWeapon02Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.attackDamage = new RandAttrSet(100, 10, 30);
		rand.addAttackDamage = new RandAttrSet(50, 10, 30);
		
		if(quality > 1)
		{
			rand.attackDamage = new RandAttrSet(500, 20, 30);
			rand.addAttackDamage = new RandAttrSet(500, 20, 30);
			
			rand.magicAttackDamage = new RandAttrSet(500, 10, 20);
			rand.addMagicAttackDamage = new RandAttrSet(500, 10, 20);
			
			rand.addMagicDamage =  new RandAttrSet(500, 10, 20);
			rand.addColdDamage =  new RandAttrSet(500, 10, 20);
			rand.addFireDamage =  new RandAttrSet(500, 10, 20);
			
			
			rand.addMaxHp = new RandAttrSet(500, 100, 500);
			rand.addMaxHp = new RandAttrSet(500, 100, 500);
			
			rand.addMoveSpeed = new RandAttrSet(500, 20, 50);
			rand.addAttackSpeed = new RandAttrSet(500, 20, 50);
			
			rand.stolenHp = new RandAttrSet(500, 5, 10);
			rand.stolenHpProbability = new RandAttrSet(1000, 5, 10);
			
			rand.stolenMp = new RandAttrSet(500, 5, 10);
			rand.stolenMpProbability = new RandAttrSet(1000, 5, 10);
			
			
		}
		
		
		
		rand.run(item);
		
		
		return item;
	}

	public ICItem randWeapon9(int quality)
	{
	
		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createWeapon9Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.attackDamage = new RandAttrSet(500, 10, 30);
		rand.addAttackDamage = new RandAttrSet(100, 10, 30);
		
		if(quality > 1)
		{
			rand.attackDamage = new RandAttrSet(500, 20, 30);
			rand.addAttackDamage = new RandAttrSet(500, 20, 30);
			
			rand.magicAttackDamage = new RandAttrSet(500, 20, 30);
			rand.addMagicAttackDamage = new RandAttrSet(500, 20, 30);
			
			rand.addMagicDamage =  new RandAttrSet(500, 20, 30);
			rand.addColdDamage =  new RandAttrSet(500, 20, 30);
			rand.addFireDamage =  new RandAttrSet(500, 20, 30);
			rand.addLightningDamage = new RandAttrSet(500, 20, 30);
			rand.addPoisonDamage =  new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 5, 10);
			rand.addInt = new RandAttrSet(500, 5, 10);
			rand.addDex = new RandAttrSet(500, 5, 10);
			rand.addCon = new RandAttrSet(500, 5, 10);
			rand.addSpi = new RandAttrSet(500, 5, 10);
			
			rand.addMaxHp = new RandAttrSet(500, 1000, 2000);
			rand.addMaxHp = new RandAttrSet(500, 1000, 2000);
			
			rand.addMoveSpeed = new RandAttrSet(500, 50, 100);
			rand.addAttackSpeed = new RandAttrSet(500, 50, 100);
			
			rand.stolenHp = new RandAttrSet(500, 5, 10);
			rand.stolenHpProbability = new RandAttrSet(1000, 5, 10);
			
			rand.stolenMp = new RandAttrSet(500, 5, 10);
			rand.stolenMpProbability = new RandAttrSet(1000, 5, 10);
			
			
		}
		
		if(quality > 2)
		{
			rand.addMaxHp = new RandAttrSet(500, 1000, 5000);
			rand.addMaxHp = new RandAttrSet(500, 1000, 5000);
			
			
			rand.addStr = new RandAttrSet(500, 20, 30);
			rand.addInt = new RandAttrSet(500, 20, 30);
			rand.addDex = new RandAttrSet(500, 20, 30);
			rand.addCon = new RandAttrSet(500, 20, 30);
			rand.addSpi = new RandAttrSet(500, 20, 30);
			
			rand.addMoveSpeed = new RandAttrSet(500, 200, 300);
			rand.addAttackSpeed = new RandAttrSet(500, 200, 300);
			
			rand.addMagicDamage =  new RandAttrSet(500, 50, 100);
			rand.addColdDamage =  new RandAttrSet(500, 50, 100);
			rand.addFireDamage =  new RandAttrSet(500, 50, 100);
			rand.addLightningDamage = new RandAttrSet(500, 50, 100);
			rand.addPoisonDamage =  new RandAttrSet(500, 50, 100);
		}
		
		
		rand.run(item);
		
		
		return item;
	}
	


	public ICItem randHelm1(int quality)
	{

		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createHelm01Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));	
		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.defense = new RandAttrSet(500, 10, 30);
		rand.addDefense = new RandAttrSet(100, 10, 30);
		
		if(quality > 1)
		{
			rand.defense = new RandAttrSet(500, 20, 30);
			rand.addDefense = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 1, 10);
			rand.addInt = new RandAttrSet(500, 1, 10);
			rand.addDex = new RandAttrSet(500, 1, 10);
			rand.addCon = new RandAttrSet(500, 1, 10);
		}

		
		rand.run(item);

		return item;
	}
	
	public ICItem randHelm2(int quality)
	{

		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createHelm02Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));	
		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.defense = new RandAttrSet(500, 50, 100);
		rand.addDefense = new RandAttrSet(100, 50, 100);
		
		if(quality > 1)
		{
			rand.defense = new RandAttrSet(500, 20, 30);
			rand.addDefense = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 1, 10);
			rand.addInt = new RandAttrSet(500, 1, 10);
			rand.addDex = new RandAttrSet(500, 1, 10);
			rand.addCon = new RandAttrSet(500, 1, 10);
		}

		
		rand.run(item);

		return item;
	}
	
	public ICItem randBoots01(int quality)
	{

		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createBoots01Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));	
		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.defense = new RandAttrSet(500, 10, 30);
		rand.addDefense = new RandAttrSet(100, 10, 30);
		rand.addMoveSpeed = new RandAttrSet(100, 10, 50);
		
		if(quality > 1)
		{
			rand.defense = new RandAttrSet(500, 20, 30);
			rand.addDefense = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 1, 10);
			rand.addInt = new RandAttrSet(500, 1, 10);
			rand.addDex = new RandAttrSet(500, 1, 10);
			rand.addCon = new RandAttrSet(500, 1, 10);
		}

		
		rand.run(item);

		return item;
	}
	
	public ICItem randBoots02(int quality)
	{

		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createBoots01Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));	
		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.defense = new RandAttrSet(500, 30, 50);
		rand.addDefense = new RandAttrSet(100, 30, 50);
		rand.addMoveSpeed = new RandAttrSet(100, 20, 60);
		
		if(quality > 1)
		{
			rand.defense = new RandAttrSet(500, 20, 30);
			rand.addDefense = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 1, 10);
			rand.addInt = new RandAttrSet(500, 1, 10);
			rand.addDex = new RandAttrSet(500, 1, 10);
			rand.addCon = new RandAttrSet(500, 1, 10);
		}

		
		rand.run(item);

		return item;
	}
	
	public ICItem randArmor1(int quality)
	{

		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createArmor1Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));	
		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.defense = new RandAttrSet(500, 10, 30);
		rand.addDefense = new RandAttrSet(100, 10, 30);
		
		if(quality > 1)
		{
			rand.defense = new RandAttrSet(500, 20, 30);
			rand.addDefense = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 1, 10);
			rand.addInt = new RandAttrSet(500, 1, 10);
			rand.addDex = new RandAttrSet(500, 1, 10);
			rand.addCon = new RandAttrSet(500, 1, 10);
		}
		
		
		
		rand.run(item);

		return item;
	}
	

	public ICItem randArmor2(int quality)
	{

		CItemFactory itemFactory = CItemFactory.getInstance();
		
		SimpleEquipment item = itemFactory.createArmor2Base();
		
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));	
		
		RandEquipmentFactory rand = new RandEquipmentFactory();
		rand.defense = new RandAttrSet(500, 10, 30);
		rand.addDefense = new RandAttrSet(100, 10, 30);
		
		if(quality > 1)
		{
			rand.defense = new RandAttrSet(500, 20, 30);
			rand.addDefense = new RandAttrSet(500, 20, 30);
			
			rand.addStr = new RandAttrSet(500, 5, 10);
			rand.addInt = new RandAttrSet(500, 5, 10);
			rand.addDex = new RandAttrSet(500, 5, 10);
			rand.addCon = new RandAttrSet(500, 5, 10);
		}
		
		
		
		rand.run(item);

		return item;
	}
	
	
	class RandAttrSet
	{
		public int probability = 0;
		public int min = 0;
		public int max = 0;
		
		public RandAttrSet(int probability, int min, int max)
		{
			this.probability = probability;
			this.min = min;
			this.max = max;
		}
		
		
		int value = 0;
		
		public int getValue()
		{
			return value;
		}
		
		public boolean next()
		{
			
			if(Utils.rand.nextInt(1000) < probability)
			{
				 value = Utils.rand.nextInt(max);
				
				if(value < min)
				{
					value = min;
				}
			
				return true;
			}
			
			return false;
		}
		
	}
	
	class RandEquipmentFactory
	{
		
		public RandAttrSet attackDamage = null;		
		public RandAttrSet addAttackDamage = null;		
		
		public RandAttrSet magicAttackDamage = null;
		public RandAttrSet addMagicAttackDamage = null;
		
		public RandAttrSet defense = null;
		public RandAttrSet addDefense = null;
		
		public RandAttrSet addStr = null;
		public RandAttrSet addInt = null;
		public RandAttrSet addDex = null;
		public RandAttrSet addCon = null;
		public RandAttrSet addSpi = null;
		
		public RandAttrSet addMaxHp = null;
		public RandAttrSet addMaxMp = null;
		
		public RandAttrSet addAttackSpeed = null;
		public RandAttrSet addMoveSpeed = null;
		
		public RandAttrSet addMagicDamage = null;
		public RandAttrSet addColdDamage = null;
		public RandAttrSet addFireDamage = null;
		public RandAttrSet addLightningDamage = null;
		public RandAttrSet addPoisonDamage = null;
				
		public RandAttrSet stolenHp = null;
		public RandAttrSet stolenHpProbability = null;
		public RandAttrSet stolenMp = null;
		public RandAttrSet stolenMpProbability = null;
		
		
		
		public RandEquipmentFactory()
		{
				
		}
		
		
		public void run(SimpleEquipment item)
		{
			
			CItemAttrList attrList = item.attrList;


			if(attackDamage != null && attackDamage.next())
			{
				
				attrList.setAttackDamage(attrList.getAttackDamage() + attackDamage.getValue());
	
			}
			
			if(addAttackDamage != null && addAttackDamage.next())
			{
				int val = attrList.getAddAttackDamage() + addAttackDamage.getValue();
				attrList.setAddAttackDamage(val);
			}
			
			
			if(magicAttackDamage != null && magicAttackDamage.next())
			{
				int val = attrList.getMagicAttackDamage() + magicAttackDamage.getValue();
				attrList.setMagicAttackDamage(val);
			}
			
			if(addMagicAttackDamage != null &&  addMagicAttackDamage.next())
			{
				int val = attrList.getAddMagicAttackDamage() +  addMagicAttackDamage.getValue();
				attrList.setAddMagicAttackDamage(val);
			}
			
			if(defense != null &&  defense.next())
			{
			
				attrList.setDefense(attrList.getDefense() + defense.getValue());
			}
			
			if(addDefense != null &&  addDefense.next())
			{
			
				attrList.setAddDefense(attrList.getAddDefense() + addDefense.getValue());
			}
			
			
			
			
			if(addStr != null && addStr.next())
			{			
				attrList.setAddStr(attrList.getAddStr() + addStr.getValue());
			}
			
			if(addInt != null && addInt.next())
			{			
				attrList.setAddInt(attrList.getAddInt() + addInt.getValue());
			}
			
			if(addDex != null && addDex.next())
			{			
				attrList.setAddDex(attrList.getAddDex() + addDex.getValue());
			}
			
			if(addCon != null && addCon.next())
			{			
				attrList.setAddCon(attrList.getAddCon() + addCon.getValue());
			}
			
			
			if(addSpi != null && addSpi.next())
			{			
				attrList.setAddSpi(attrList.getAddSpi() + addSpi.getValue());
			}
			
			
			
			
			
			if(addMaxHp != null && addMaxHp.next())
			{
			
				attrList.setAddMaxHp(attrList.getAddMaxHp() + addMaxHp.getValue());
			}
			
			if(addMaxMp != null && addMaxMp.next())
			{
			
				attrList.setAddMaxMp(attrList.getAddMaxMp() + addMaxMp.getValue());
			}
			
			
			if(addAttackSpeed != null && addAttackSpeed.next())
			{
				attrList.setAddAttackSpeed(attrList.getAddAttackSpeed() + addAttackSpeed.getValue());			
	
			}
			
			if(addMoveSpeed != null && addMoveSpeed.next())
			{
				attrList.setAddMoveSpeed(attrList.getAddMoveSpeed() + addMoveSpeed.getValue());

			}
			
			if(addFireDamage != null && addFireDamage.next())
			{
				
				attrList.setAddFireDamage(attrList.getAddFireDamage() + addFireDamage.getValue());
										
			}
			

			if(stolenHp != null && stolenHpProbability != null && stolenHp.next() && stolenHpProbability.next())
			{
			
				attrList.setStolenHp(
						attrList.getStolenHp() + stolenHp.getValue(), 
						stolenHpProbability.getValue());
			}
			

			if(stolenMp != null && stolenMpProbability != null && stolenMp.next() && stolenMpProbability.next())
			{
			
				attrList.setStolenHp(
						attrList.getStolenHp() + stolenMp.getValue(), 
						stolenMpProbability.getValue());
			}
			
			
			
		}
		
		
	}
	

}
