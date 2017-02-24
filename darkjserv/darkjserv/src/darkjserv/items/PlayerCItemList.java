package darkjserv.items;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import darkjserv.CItemFactory;
import darkjserv.GameTemplateEnums;
import darkjserv.monsters.DropItemFactory;
import darkjserv.net.AddAttrResult;
import darkjserv.net.GamePlayer;
import darkjserv.storages.StorageFactory;


public class PlayerCItemList
{
	
	public GamePlayer player = null;
	private HashMap<Integer, ICItem> _getItemById = new HashMap<Integer, ICItem>();
	
	public PlayerCItemList(GamePlayer player)
	{
		this.player = player;	

	}
	
	public void load() throws Exception
	{
		_getItemById.clear();// = new ArrayList<IItem>();
		
		List<ICItem> _items = StorageFactory.getInstance().getCharAllItems(player.charId);
		
		for(ICItem item : _items)
		{
			_getItemById.put(item.getItemId(), item);
		}
		
		/*
		CItemFactory itemFactory = CItemFactory.getInstance();
		
		items.add(itemFactory.createCoin(10000000));
		items.add(itemFactory.createHomeBackMagicScroll(100));
		
		items.add(itemFactory.createHpLiquidMiddle(100));
		
		items.add(itemFactory.createHpLiquidSmall(100));
		
		items.add(itemFactory.createGotoMap02MagicScroll(100));
		items.add(itemFactory.createGotoMap03MagicScroll(100));
		
		
		
		SimpleEquipment item = itemFactory.createWeapon9Base();
		items.add(item);
		item.attrList.setAddInt(item.attrList.getAddInt() + 500);
		
		DropItemFactory dropFactory = new DropItemFactory();
		items.add(dropFactory.randWeapon9(5));*/
	}
	
	
	public void removeItem(int itemId) throws Exception
	{
		_getItemById.remove(itemId);
		
		StorageFactory.getInstance().removeCharItem(player.charId, itemId);
		
	}
	
	public byte addItem(ICItem item) throws Exception
	{
		
		
		if(item.getCanStack())
		{
			for(ICItem _item : _getItemById.values())
			{
				if(_item.getItemBaseId() == item.getItemBaseId())
				{
					long itemCount = _item.getItemCount()  + item.getItemCount();
					_item.setItemCount(itemCount);
					
					return CItemAddResultEnums.STACK;
				}
			}	
			
		} 
		
				
		_getItemById.put(item.getItemId(), item);
		StorageFactory.getInstance().addCharItem(player.charId, item);
		
		//StorageFactory.getInstance().savePlayer(player);
		
		return CItemAddResultEnums.APPEND;
	}
	
	public AddAttrResult calcAddAttrResult()
	{
		AddAttrResult rs = new AddAttrResult();
		
		
		for(ICItem _item : _getItemById.values())
		{
			int baseItemId = _item.getItemBaseId();
			byte itemType = CItemEnums.getItemTypeByBaseId(baseItemId);
			
			switch(itemType)
			{
				case CItemEnums.TYPE_EQUIPMENT:
					if(_item.getEquipmentIsUse())
					{
						CItemAttrList attrList =  _item.getAttrList();
						rs.maxHp += attrList.getAddMaxHp();
						rs.maxMp += attrList.getAddMaxMp();
						
						rs.attackDamage += attrList.getAttackDamage();
						rs.attackSpeed += attrList.getAddAttackDamage();
						
						rs.magicAttackDamage += attrList.getMagicAttackDamage();
						rs.magicAttackDamage += attrList.getAddMagicAttackDamage();
						
						rs.moveSpeed += attrList.getAddMoveSpeed();
						
						rs.defense += attrList.getDefense();
						rs.defense += attrList.getAddDefense();
						
						rs.magicDefense += attrList.getMagicDefense();
						
						rs.coldDamage +=  attrList.getAddColdDamage();
						rs.fireDamage +=  attrList.getAddFireDamage();
						rs.lightningDamage +=  attrList.getAddLightningDamage();
						rs.poisonDamage +=  attrList.getAddPoisonDamage();
						
						rs.charStr += attrList.getAddStr();
						rs.charInt += attrList.getAddInt();
						rs.charDex += attrList.getAddDex();
						rs.charCon += attrList.getAddCon();
					}
					break;
			}
			
			
			
		}
		
		return rs;		
	}
	
	public int calcMaxMp()
	{
		int value = 0;
		
		return value;
	}
	
	public int calcAttackDamage()
	{
		int damage = 0;
		
		
		
		for(ICItem item : _getItemById.values())
		{
			
			byte itemType = CItemEnums.getItemTypeByBaseId(item.getItemBaseId());
			
			if(itemType == CItemEnums.TYPE_EQUIPMENT)
			{
				
				
				damage += item.getAttrList().getAttackDamage();
			}
			
		}
		
		return damage;		
	}
	
	
	public boolean useEquipment(int itemId)
	{
		ICItem item = getItemById(itemId);
		
		
		int itemBaseId1 = item.getItemBaseId();
		int itemType1 = CItemEnums.getItemTypeByBaseId(itemBaseId1) ;
		
		System.out.println(String.format("useEquipment %s", item));
		
		if(itemType1 == CItemEnums.TYPE_EQUIPMENT)
		{
			
			byte placeType1 = CItemFactory.getInstance().getEquipmentPlaceTypeByBaseId(itemBaseId1);
			
			for(ICItem iitem : _getItemById.values())
			{
				if(CItemEnums.getItemTypeByBaseId(iitem.getItemBaseId()) == CItemEnums.TYPE_EQUIPMENT )
				{
					byte placeType2 = CItemFactory.getInstance().getEquipmentPlaceTypeByBaseId(iitem.getItemBaseId());
					
					if(placeType2 == placeType1 && iitem.getItemId() != itemId)
					{
						iitem.setEquipmentIsUse(false);
					}
				}
			}
			
			
			boolean isUse = !item.getEquipmentIsUse();		
			
			
			item.setEquipmentIsUse(isUse);
			
		}
		
		return true;
		
	}
	
	
	
	
	
	

	public List<ICItem> getItems()
	{		
		
		return new ArrayList<ICItem>(_getItemById.values());
	}
	
	public ICItem getItemById(int itemId)
	{
		
		return _getItemById.getOrDefault(itemId, null);
		
	}
	

}
