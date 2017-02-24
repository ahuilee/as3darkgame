package darkjserv.commandhandlers;

import java.io.DataInputStream;
import java.util.ArrayList;

import darkjserv.items.ShopItem;
import darkjserv.net.*;

public class ShopItemListHandler
{
	
	public Connection conn = null;
	
	public ShopItemListHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		
		
		ArrayList<ShopItem> items = new ArrayList<ShopItem>();
		
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);	
		
		answer.w.writeUInt24(items.size());
		
		for(ShopItem item: items)
		{
			answer.w.writeInt(item.id);
			answer.w.writeUInt24(item.templateId);
			answer.w.writeBStrUTF(item.name);
		}
		
		conn.putWork(new WriteAnswerWork(answer, conn));		
		
		
	}
}
