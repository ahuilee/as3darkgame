package darkjserv.commandhandlers;


import java.util.List;

import darkjserv.IShortcutItem;
import darkjserv.net.AnswerSuccessResponse;
import darkjserv.net.Connection;
import darkjserv.net.DataReader;

import darkjserv.net.WriteAnswerWork;;

public class PlayerGetShortcutInfoHandler
{
	public Connection conn = null;
	
	public PlayerGetShortcutInfoHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
	
		List<IShortcutItem> items = conn.player.getShortcutItems();
		
		
		
		//count
		answer.w.writeByte(items.size());	
		
		for(int i=0; i<items.size(); i++)
		{
			IShortcutItem item = items.get(i);
			
			
			if(item == null)
			{
				answer.w.writeByte(0x00);
				answer.w.writeByte(0x00);
				
			} else
			{
				System.out.println(String.format("shortcut %d", item.getIdx()));
				
				answer.w.writeByte(item.getIdx());	
				answer.w.write(item.makeShortcutItemBytes());
			}
		}
	
	
		
		conn.putWork(new WriteAnswerWork(answer, conn));		
		
	}
}
