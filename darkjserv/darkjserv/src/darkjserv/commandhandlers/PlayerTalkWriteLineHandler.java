package darkjserv.commandhandlers;




import java.awt.Rectangle;
import java.util.List;

import darkjserv.net.AnswerSuccessResponse;
import darkjserv.net.Connection;
import darkjserv.net.DataReader;
import darkjserv.net.GamePlayer;
import darkjserv.net.WriteAnswerWork;
import darkjserv.net.commands.DisplayTalkMessageCommand;

public class PlayerTalkWriteLineHandler
{
	public Connection conn = null;
	
	public PlayerTalkWriteLineHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		String text = rd.readHStrUTF();
		
		System.out.println(String.format("PlayerTalkWriteLineHandler %s", text));
		
		
		Rectangle rect = new Rectangle(0, 0, 2048, 2048);
		rect.x = conn.player.getX() - rect.width / 2;
		rect.y = conn.player.getY() - rect.height / 2;
		
		List<GamePlayer> players = conn.server.factory.hitPlayerViewsByRect(conn.player.getMapId(), rect);
		
		String talkText = String.format("%s: %s", conn.player.getName(), text);
		
		for(GamePlayer p :players)
		{
			try
			{
				DisplayTalkMessageCommand cmd = new DisplayTalkMessageCommand(talkText);
				
				p.conn.writeCommand(cmd);
				
				
			} catch(Exception ex)
			{						
			
			}
			
		}
		
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		
		//long now = System.currentTimeMillis();
		
		//answer.w.writeInt()
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		//writeAnswer(answer);
		
		

		//init in screen game objs		
		
		
	}
}
