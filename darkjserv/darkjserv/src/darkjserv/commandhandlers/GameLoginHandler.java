package darkjserv.commandhandlers;

import java.util.ArrayList;
import java.util.List;

import darkjserv.CItemFactory;
import darkjserv.GameTemplateEnums;
import darkjserv.MapFactory;
import darkjserv.items.ICItem;
import darkjserv.maps.IMapData;
import darkjserv.maps.MapPt;
import darkjserv.net.*;
import darkjserv.storages.StorageFactory;
import darkjserv.storages.UserCharacterInfo;
import darkjserv.storages.UserAccountData;

public class GameLoginHandler 
{
	
	public Connection conn = null;
	
	public GameLoginHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	private List<ICItem> makeItems()
	{
		ArrayList<ICItem> items = new ArrayList<ICItem>();
		
		CItemFactory itemFactory = CItemFactory.getInstance();		
	
		items.add(itemFactory.createMapScroll(101, 100));
		items.add(itemFactory.createMapScroll(102, 100));
		items.add(itemFactory.createMapScroll(103, 100));
		
		items.add(itemFactory.createWeapon02Base());
		
		return items;
	}
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		String username = rd.readBStrUTF();
		
		System.out.println(String.format("login = %s", username));
		
		UserAccountData act = StorageFactory.getInstance().getOrCreateUserAccountData(username);
		
		if(act.charPks.size() == 0)
		{
			UserCharacterInfo newCharInfo = StorageFactory.getInstance().createCharacter(act);
			
			newCharInfo.charName = username;
			//newCharInfo.templateId = GameTemplateEnums.TC_NPC001;
			newCharInfo.templateId = GameTemplateEnums.TC_NPC002;
			//newCharInfo.templateId = GameTemplateEnums.TC_NPC053;
		
			//newCharInfo.templateId = GameTemplateEnums.TC_DRAGON01;
			
			IMapData map = MapFactory.getInstance().getMapDataById(1);
			
			MapPt pt2 = map.randSafePt();
			
			newCharInfo.mapId = pt2.mapId;
			newCharInfo.x = pt2.x;
			newCharInfo.y = pt2.y;
			
			newCharInfo.maxHp = 50000;
			newCharInfo.maxMp = 5000;
			newCharInfo.hp = newCharInfo.maxHp;
			newCharInfo.mp = newCharInfo.maxMp;
			
			newCharInfo.charStr = 256;
			newCharInfo.charDex = 128;
			newCharInfo.charInt = 256;
			newCharInfo.charCon = 256;
			newCharInfo.exp = 0;
			
			List<ICItem> items = makeItems();
			for(ICItem item : items)
			{
				newCharInfo.getItemById.put(item.getItemId(), item);
			}
			
		}
		
		
		ArrayList<UserCharacterInfo> allChars = new ArrayList<UserCharacterInfo> ();
		
		for(int charPk : act.charPks)
		{
			UserCharacterInfo info = StorageFactory.getInstance().getCharacterInfoById(charPk);
			
			if(info != null)
			{
				allChars.add(info);
			}
				
		}
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);		
		
		answer.w.writeByte(allChars.size());
		for(UserCharacterInfo info : allChars)
		{
			answer.w.writeInt(info.charId);
			answer.w.writeBStrUTF(info.charName);
		}
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
