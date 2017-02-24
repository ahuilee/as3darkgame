package darkjserv.commandhandlers;


import java.util.List;

import darkjserv.CItemFactory;
import darkjserv.Factory;
import darkjserv.Utils;
import darkjserv.items.CItemEnums;
import darkjserv.items.CItemGameObjWrap;
import darkjserv.items.ICItem;
import darkjserv.net.*;
import darkjserv.syncs.SyncCharPosition;


public class PlayerItemDropHandler 
{
	
	public Connection conn = null;
	
	public PlayerItemDropHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	

	public void handle(int ask, DataReader rd) throws Exception
	{
		int itemId = rd.readInt();
		ICItem item = conn.player.itemList.getItemById(itemId);
		
		System.out.println(String.format("Item Drop %s", item));
		
	
		
		GamePlayer player = conn.player;
		
		int mapId = player.getMapId();
		
		player.itemList.removeItem(itemId);
		
		Factory factory = Factory.getInstance();
		
		long expiry = System.currentTimeMillis() + 60000 * 5;
		
		CItemGameObjWrap itemObj = new CItemGameObjWrap(factory.makeObjId(), item, expiry);
		
		itemObj.setMapId(mapId);	
		itemObj.setX(player.getX());
		itemObj.setY(player.getY());
		
		byte randDir = (byte)Utils.rand.nextInt(8);
		itemObj.setDirection(randDir);
		
		factory.addGameObj(itemObj);
		
		System.out.println(String.format("down item = %s", itemObj));
		
		SyncCharPosition syncNode = new SyncCharPosition(itemObj);
				
		List<GamePlayer> viewPlayers = factory.hitPlayerViewsByRect(mapId, player.viewRect);
		
		for(GamePlayer p  : viewPlayers)
		{
			try			
			{
				p.conn.syncQueue.put(itemObj, syncNode);
				
			} catch(Exception ex)
			{
				
			}
			
			
		}
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		answer.w.writeByte(1);
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
	
	
	
}
