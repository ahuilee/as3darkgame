package darkjserv.commandhandlers;


import java.io.DataInputStream;


import darkjserv.net.AddAttrResult;
import darkjserv.net.AnswerSuccessResponse;
import darkjserv.net.Connection;
import darkjserv.net.PlayerStatusInfo;
import darkjserv.net.WriteAnswerWork;

public class PlayerCharacterInfoHandler
{
	public Connection conn = null;
	
	public PlayerCharacterInfoHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		PlayerStatusInfo info = conn.player.getStatusInfo();
	

	
		answer.w.writeUInt24(info.maxHp);
		answer.w.writeUInt24(info.maxMp);
		
		answer.w.writeUInt24(info.getHp());
		answer.w.writeUInt24(info.getMp());
		
		answer.w.writeUInt24(info.charStr);
		answer.w.writeUInt24(info.charDex);
		answer.w.writeUInt24(info.charInt);
		answer.w.writeUInt24(info.charCon);
		answer.w.writeUInt24(info.charSpi);
		answer.w.writeUInt24(info.defense);
		
		answer.w.writeUInt24(info.moveSpeed);
		
		//long now = System.currentTimeMillis();
		
		//answer.w.writeInt()
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		//writeAnswer(answer);
		
	

		//init in screen game objs		
		
		
	}
}
