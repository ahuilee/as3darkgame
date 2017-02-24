package darkjserv.commandhandlers;


import darkjserv.net.AnswerSuccessResponse;
import darkjserv.net.Connection;
import darkjserv.net.DataReader;

import darkjserv.net.WriteAnswerWork;;

public class PlayerShortcutSetItemHandler
{
	public Connection conn = null;
	
	public PlayerShortcutSetItemHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		byte idx = rd.readByte();
		byte type = rd.readByte();
		int id = rd.readInt();
	
		conn.player.setShortcutItem(idx, type, id);
		
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));		
		
	}
}
