package darkjserv.commandhandlers;

import java.io.DataInputStream;
import java.util.List;

import darkjserv.items.CItemEnums;
import darkjserv.items.ICItem;
import darkjserv.net.*;

public class PlayerItemListHandler 
{
	
	public Connection conn = null;
	
	public PlayerItemListHandler(Connection conn)
	{
		this.conn = conn;
	}	
	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		List<ICItem> items = conn.player.itemList.getItems();
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);	
		
		answer.w.writeUInt24(items.size());
		
		for(ICItem item: items)
		{
			answer.w.writeInt(item.getItemId());
			answer.w.writeUInt24(CItemEnums.getTemplateIdByBaseId(item.getItemBaseId()));		
			
		}
		
		conn.putWork(new WriteAnswerWork(answer, conn));		
		
		
	}
}
