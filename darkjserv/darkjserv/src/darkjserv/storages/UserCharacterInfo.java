package darkjserv.storages;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import darkjserv.CSkillEnums;
import darkjserv.items.CItemAttrList;
import darkjserv.items.CItemEnums;
import darkjserv.items.ICItem;
import darkjserv.items.SimpleEquipment;
import darkjserv.items.SimpleItem;



public class UserCharacterInfo 
{
	
	public int charId = 0;
	
	public String charName = "";
	
	public int mapId = 0;
	public int x = 0;
	public int y = 0;
	
	public int templateId = 0;
	
	public int maxHp = 0;
	public int maxMp = 0;
	public int hp = 0;
	public int mp = 0;
	
	public int charStr = 0;
	public int charDex = 0;
	public int charInt = 0;
	public int charCon = 0;	
	
	public long exp = 0;
	
	public HashMap<Integer, ICItem> getItemById = null;
	public HashMap<Integer, ICharShortcutItem> shortcutMap = new HashMap<Integer, ICharShortcutItem>();
	
	private byte[] makeCharInfoData() throws Exception
	{
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		StorageDataWriter w = new StorageDataWriter(out);
		
		w.writeInt(charId);
		w.writeHStrUTF(charName);
		
		w.writeInt(templateId);
		w.writeInt(mapId);
		w.writeInt(x);
		w.writeInt(y);
		
		w.writeLong(exp);
		
		w.writeInt(maxHp);
		w.writeInt(maxMp);
		w.writeInt(hp);
		w.writeInt(mp);
		
		w.writeInt(charStr);
		w.writeInt(charInt);
		w.writeInt(charDex);
		w.writeInt(charCon);
		
		return out.toByteArray();
	}
	
	private byte[] makeItemListData() throws Exception
	{	
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		StorageDataWriter w = new StorageDataWriter(out);
		
		int itemCount = 0;
		
		if(getItemById != null)
		{
			itemCount = getItemById.size();
		}
		
		System.out.println(String.format("makeItemListData numItems=%d", itemCount));
		
		w.writeInt(itemCount);
		
		if(getItemById != null)
		{
			for(ICItem item : getItemById.values())
			{
				w.writeHBytes(packItemBytes(item));
				
			}			
		}
		
		w.flush();
		
		return out.toByteArray();
	}
	
	private byte[] packItemBytes(ICItem item ) throws Exception
	{
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		StorageDataWriter w = new StorageDataWriter(out);
		
		w.writeInt(item.getItemId());	
		w.writeInt(item.getItemBaseId());
		w.writeLong(item.getItemCount());
		
		w.writeByte(item.getEquipmentIsUse() ? 1 : 0);
		
		
		byte[] attrBytes = item.getAttrList().makeBytes();
		w.writeHBytes(attrBytes);
		
		
		w.flush();
		
		return  out.toByteArray();
	}
	
	
	
	public void save(StorageDataWriter w) throws Exception 
	{
		
		w.writeHBytes(makeCharInfoData());
		w.writeHBytes(makeItemListData());
		
	
		
		
		w.flush();
	}
	
	@SuppressWarnings("resource")
	public static ICItem unpackItemBytes(byte[] data) throws Exception
	{
		ByteArrayInputStream in = new ByteArrayInputStream(data);
		StorageDataReader rd = new StorageDataReader(in);
		
		int itemId = rd.readInt();			
		int itemBaseId = rd.readInt();		
		long itemCount = rd.readLong();
		
		boolean equipIsUse = rd.readByte() == 1;
		
		byte[] attrBytes = rd.readHBytes();
		
		
		byte itemType = CItemEnums.getItemTypeByBaseId(itemBaseId);
		
		switch(itemType)
		{
			case CItemEnums.TYPE_ITEM:
			case CItemEnums.TYPE_LIQUID:
			case CItemEnums.TYPE_SCROLL:
				SimpleItem sItem = new SimpleItem(itemBaseId, itemId);
				sItem.itemCount = itemCount;
				sItem.getAttrList().load(attrBytes);
				
				return sItem;
				
			case CItemEnums.TYPE_EQUIPMENT:
				SimpleEquipment sEquipment = new SimpleEquipment(itemBaseId, itemId);
				sEquipment.itemCount = itemCount;
				sEquipment.setEquipmentIsUse(equipIsUse);
				sEquipment.getAttrList().load(attrBytes);
				
				return sEquipment;
				
		}
		
		return null;
	}
	
	
	
	private static HashMap<Integer, ICItem> _unpackCharItemList(byte[] data) throws Exception
	{
		ByteArrayInputStream in = new ByteArrayInputStream(data);
		StorageDataReader rd = new StorageDataReader(in);
		
		HashMap<Integer, ICItem> list = new HashMap<Integer, ICItem>();
		
		int numItems = rd.readInt();
		
		System.out.println(String.format("_unpackCharItemList numItems=%d", numItems));
		
		for(int i=0; i<numItems;i++)
		{
			
			byte[] itemBytes = rd.readHBytes();
			
			ICItem citem = unpackItemBytes(itemBytes);
			if(citem != null)
			{
				list.put(citem.getItemId(), citem);
			}
			
		}
		
		
		return list;
	}
	
	private static void _unpackCharBaseInfo(byte[] data, UserCharacterInfo info) throws Exception
	{
		
		ByteArrayInputStream in = new ByteArrayInputStream(data);
		StorageDataReader rd = new StorageDataReader(in);
		
		info.charId = rd.readInt();
		
		info.charName = rd.readHStrUTF();
		
		info.templateId = rd.readInt();
		info.mapId = rd.readInt();
		info.x = rd.readInt();
		info.y = rd.readInt();
		
		info.exp = rd.readLong();
		
		info.maxHp = rd.readInt();
		info.maxMp = rd.readInt();
		info.hp = rd.readInt();
		info.mp = rd.readInt();
		
		info.charStr = rd.readInt();
		info.charInt = rd.readInt();
		info.charDex = rd.readInt();
		info.charCon = rd.readInt();
	}
	
	public static final byte SHORTCUTS_SKILL = 0x01;
	
	public static HashMap<Integer, ICharShortcutItem> makeNewCharShortcutList() throws Exception
	{
		/*
		items.add(skillList.getSkillById(CSkillEnums.SKILL_033));		
		items.add(skillList.getSkillById(CSkillEnums.SKILL_008));
		
		items.add(skillList.getSkillById(CSkillEnums.SKILL_001));
		items.add(skillList.getSkillById(CSkillEnums.SKILL_002));	*/
		
		HashMap<Integer, ICharShortcutItem> items = new HashMap<Integer, ICharShortcutItem>();
		
		items.put(0, new CharShortcutItem(0, SHORTCUTS_SKILL, CSkillEnums.SKILL_033, 0));
		items.put(1, new CharShortcutItem(1, SHORTCUTS_SKILL, CSkillEnums.SKILL_008, 0));
		items.put(2, new CharShortcutItem(2, SHORTCUTS_SKILL, CSkillEnums.SKILL_001, 0));
		items.put(4, new CharShortcutItem(3, SHORTCUTS_SKILL, CSkillEnums.SKILL_002, 0));
		
		return items;
	}
	
	public static UserCharacterInfo load(StorageDataReader rd) throws Exception
	{
		UserCharacterInfo info = new UserCharacterInfo();
		
		byte[] infoData = rd.readHBytes();
		_unpackCharBaseInfo(infoData, info);
		
		byte[] itemListData = rd.readHBytes();
		
		info.getItemById = _unpackCharItemList(itemListData);
		info.shortcutMap = makeNewCharShortcutList();
		
		
		return info;
	}
	
	
	public String toString()
	{
		return String.format("<CharInfo id=%d name=%s>", charId, charName);
	}
	
	
}
