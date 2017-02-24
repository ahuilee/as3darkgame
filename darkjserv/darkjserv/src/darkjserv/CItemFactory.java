package darkjserv;

import darkjserv.items.CItemEnums;
import darkjserv.items.ICItem;

import darkjserv.items.SimpleEquipment;
import darkjserv.items.SimpleItem;
import darkjserv.storages.StorageFactory;

public class CItemFactory 
{

	public CItemFactory()
	{
		synchronized(_syncLastItemId)
		{
			_lastItemId = StorageFactory.getInstance().getLastItemId();
		}
	}
	
	
	
	private static CItemFactory _instance = null;
	public static CItemFactory getInstance()
	{
		if(_instance == null)
		{
			_instance = new CItemFactory();
		}
		
		return _instance;
		
	}
	
	private static Object _syncLastItemId = 0;
	private static int _lastItemId = 0;
	public static int makeItemId()
	{
		synchronized(_syncLastItemId)
		{
			int id = ++_lastItemId;
			
			StorageFactory.getInstance().saveLastItemId(id);
			
			return id;
		}
	}
	
	
	
	public ICItem createCoin(long count)
	{
		int itemId = makeItemId();
		
		SimpleItem item = new SimpleItem(
				1,
				itemId
				);
		

		
		item.setItemCount(count);
		return item;
	}
	
	
	public ICItem createHpLiquidSmall(long count)
	{
		SimpleItem item = new SimpleItem(
				3,
				makeItemId()			
				
				);

		item.setItemCount(count);
		return item;
	}
	
	public ICItem createHpLiquidMiddle(long count)
	{
		SimpleItem item = new SimpleItem(
				4, 
				makeItemId()			
				);
		


		item.setItemCount(count);
		
		return item;
	}
	

	public ICItem createHomeBackMagicScroll(int count)
	{
		int itemId = makeItemId();
		
		SimpleItem item = new SimpleItem(
				101,
				itemId
				
				);
		
		item.setItemCount(count);
		return item;
	}
	
	public ICItem createMapScroll(int baseId, int count)
	{
		int itemId = makeItemId();
		
		SimpleItem item = new SimpleItem(baseId, itemId);
	

		item.setItemCount(count);
		return item;
	}
	
	public ICItem createGotoMap02MagicScroll(int count)
	{
		int itemId = makeItemId();
		
		SimpleItem item = new SimpleItem(
				102,
				itemId				
				
				);
	

		item.setItemCount(count);
		return item;
	}
	
	public ICItem createGotoMap03MagicScroll(int count)
	{
		int itemId = makeItemId();
		
		SimpleItem item = new SimpleItem(
				103,
				itemId					
				
				);

		item.setItemCount(count);
		return item;
	}
	
	public ICItem createRing1()
	{
		
		
		SimpleEquipment item = new SimpleEquipment(
				50001, 
				makeItemId()
			
				);
		
		

		
	
		
		item.attrList.setMagicAttackDamage(50);
		
		
		return item;
	}
	
	public SimpleEquipment createWeapon1Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				10001, 
				makeItemId()		
				);
	
		item.attrList.setAttackDamage(50);
		
		return item;
	}
	
	public SimpleEquipment createWeapon02Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				10002, 
				makeItemId()		
				);
		
	
		item.attrList.setAttackDamage(160);
		item.attrList.setMagicAttackDamage(10);
		
		return item;
	}
	

	public SimpleEquipment createWeapon9Base()
	{
		int itemId = makeItemId();
		
		SimpleEquipment item = new SimpleEquipment(
				10009,
				itemId		
				);

	
		//item.itemAttrs.add(new EquipmentAttackDamageAttr(item));
		
		item.attrList.setAttackDamage(5000);
		item.attrList.setMagicAttackDamage(500);
		
		item.attrList.setAddMagicDamage(100);
		item.attrList.setAddColdDamage(100);
		item.attrList.setAddFireDamage(100);
		item.attrList.setAddLightningDamage(100);
		item.attrList.setAddPoisonDamage(100);
		
		item.attrList.setAddLucky(100);
		
		item.attrList.setAddStr(100);
		item.attrList.setAddInt(100);
		item.attrList.setAddDex(100);
		item.attrList.setAddCon(100);
		
		item.attrList.setStolenHp(20, (byte)30);
		item.attrList.setStolenMp(20, (byte)30);
		
		return item;
	}
	
	public SimpleEquipment createArmor1Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				20001, 
				makeItemId()
				);
		

	
		item.attrList.setDefense(10);
		
		return item;
	}
	
	

	public SimpleEquipment createArmor2Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				20002, 
				makeItemId()			
				);
		
		
		
		item.attrList.setDefense(50);
		
		return item;
	}
	
	public SimpleEquipment createHelm01Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				30001, 
				makeItemId()			
				);	
		
		
		item.attrList.setDefense(30);
		
		return item;
	}
	
	public SimpleEquipment createHelm02Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				30002, 
				makeItemId()			
				);	
		
		
		item.attrList.setDefense(90);
		
		return item;
	}
	
	public SimpleEquipment createBoots01Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				40001, 
				makeItemId()			
				);	
		
		
		item.attrList.setDefense(30);
		item.attrList.setAddMoveSpeed(10);
		return item;
	}
	
	public SimpleEquipment createBoots02Base()
	{
		SimpleEquipment item = new SimpleEquipment(
				40002, 
				makeItemId()			
				);	
		
		
		item.attrList.setDefense(30);
		item.attrList.setAddMoveSpeed(20);
		return item;
	}
	
	
	
	public int getSceneTemplateIdByBaseId(int itemBaseId)
	{
		
		switch(itemBaseId)
		{
			case 1:
				return GameTemplateEnums.T_SCENEITEM_START;
				
			case 10001:	
				return GameTemplateEnums.T_SCENEITEM_START + 100;
			case 10002:
				return GameTemplateEnums.T_SCENEITEM_START + 101;
			case 10003:
			case 10004:
			case 10005:
			case 10006:
			case 10007:
			case 10008:
				
			case 10009:		
				return GameTemplateEnums.T_SCENEITEM_START + 108;
				
			case 20001:
			case 20002:
			case 20003:
			case 20004:
			case 20005:
				return GameTemplateEnums.T_SCENEITEM_START + 200;
				
			case 30001:
			case 30002:
				return GameTemplateEnums.T_SCENEITEM_START + 300;
				
			case 40001:
			case 40002:
				return GameTemplateEnums.T_SCENEITEM_START + 400;
		}
		
		return GameTemplateEnums.T_SCENEITEM_START + 1;
	}
	
	public boolean getItemStackableByBaseId(int itemBaseId)
	{
		switch(itemBaseId)
		{
			case 1:
			case 3:
			case 4:				
			case 101:
			case 102:
			case 103:
				return 	true;
		
		}
		
		return false;
	}
	
	public byte getEquipmentPlaceTypeByBaseId(int itemBaseId)
	{
		switch(itemBaseId)
		{
			case 10001:				
			case 10002:
			case 10003:
			case 10004:
			case 10009:		
				return CItemEnums.EQUIPMENT_WEAPON;
				
			case 20001:
			case 20002:
				return CItemEnums.EQUIPMENT_ARMOR;
				
			case 30001:
			case 30002:
				return CItemEnums.EQUIPMENT_HELMET;
				
			case 40001:
			case 40002:
			case 40003:
			case 40004:
			case 40005:
				return CItemEnums.EQUIPMENT_BOOTS;
			
			case 50001:
				return 	CItemEnums.EQUIPMENT_RING;
		}
		
		return 0;
	}
	

	public String getItemNameByBaseId(int itemBaseId)
	{
		switch(itemBaseId)
		{
			case 1:
				return "金幣";
			case 3:
				return "中型紅色藥水";
			case 4:
				return "中型紅色藥水";
				
			case 101:
				return "傳送回家的卷軸";
			case 102:
				return "傳送至天閻魔城的卷軸";
			case 103:
				return 	"傳送至妖市的卷軸";
			case 10001:
				return "長劍";
			case 10002:
				return "鋼刀";
			case 10003:
			case 10004:
			case 10009:		
				return "計都刀";
			
				
			case 20001:
				return "布衣";
			case 20002:
				return "青銅盔甲";
				
			case 30001:
				return "帽子";
				
			case 30002:
				return "軍帽";
				
				
			case 40001:
				return "皮靴";
			case 40002:
			case 40003:
			case 40004:
			case 40005:
				
				return "長靴";
			
			case 50001:
				return 	"魔法戒指";
		}
		
		return "";
	}
	
	
	
}
