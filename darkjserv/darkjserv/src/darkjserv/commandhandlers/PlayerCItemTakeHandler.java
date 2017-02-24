package darkjserv.commandhandlers;



import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.List;

import darkjserv.Factory;
import darkjserv.IGameObj;
import darkjserv.items.CItemAddResultEnums;
import darkjserv.items.CItemEnums;
import darkjserv.items.CItemGameObjWrap;
import darkjserv.items.ICItem;
import darkjserv.net.*;
import darkjserv.net.commands.RemoveObjCommand;

public class PlayerCItemTakeHandler 
{
	
	public Connection conn = null;
	
	public PlayerCItemTakeHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	

	public void handle(int ask, DataReader rd) throws Exception
	{
		GamePlayer player = conn.player;
		if(player.getIsDead())
		{			
			return;
		}
		
		
		long takeObjId = rd.readLong();
		
		System.out.println(String.format("take obj=%d", takeObjId));
		
		
		Factory factory = Factory.getInstance();
		
		IGameObj iobj = factory.getGameObj(takeObjId);
		ICItem takeItem = null;
	
		
		byte addResult = 0;
		
		if(iobj instanceof CItemGameObjWrap)
		{
			
			
			
			CItemGameObjWrap itemObj = (CItemGameObjWrap)iobj;
			
			factory.removeGameObj(iobj);
			
			takeItem = itemObj.item;
			
			//String itemName = CItemEnums.getItemNameByBaseId(itemObj.item.getItemBaseId());
			//String takMsg = String.format("±z¾ß°_¤F %s", itemName);
			
			//DisplayTalkMessageCommand cmd = new DisplayTalkMessageCommand(takMsg);
			//player.conn.putWork(new WriteCommandWork(cmd, player.conn));
			
			addResult = player.itemList.addItem(itemObj.item);
			
			
	
			
			Rectangle viewRect = new Rectangle(iobj.getX() - 32, iobj.getY()-32, 64, 64);
			List<GamePlayer> viewPlayers = factory.hitPlayerViewsByRect(conn.player.getMapId(), viewRect);
			
			List<Long> rmObjPks = new ArrayList<Long>();
			rmObjPks.add(takeObjId);
			
			for(GamePlayer p: viewPlayers)
			{
			
				try
				{
					RemoveObjCommand removeObjCmd = new RemoveObjCommand(rmObjPks);
				
					p.conn.putWork(new WriteCommandWork(removeObjCmd, p.conn));
				
				} catch(Exception ex)
				{
					
				}
			
			}
			
			
			
			
		}
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		System.out.println(String.format("PlayerCItemTakeHandler response ask=%d %s", ask, takeItem));
		
		answer.w.writeByte(addResult);
		
		switch(addResult)
		{
			case CItemAddResultEnums.APPEND:
				answer.w.writeInt(takeItem.getItemId());
				answer.w.writeUInt24(CItemEnums.getTemplateIdByBaseId(takeItem.getItemBaseId()));
				break;
				
			case CItemAddResultEnums.STACK:
				answer.w.writeInt(takeItem.getItemId());
				break;
		}
		
		

		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
