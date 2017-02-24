package darkjserv.commandhandlers;




import darkjserv.Factory;

import darkjserv.net.*;


public class GameInitDoneHandler 
{
	
	public Connection conn = null;
	
	public GameInitDoneHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		Factory factory = conn.server.factory;
		GamePlayer player = conn.player;
		
		PlayerStatusInfo statusInfo = conn.player.getStatusInfo();
	
		
		short weighted = 20 & 0xff;
		
		long curExp = conn.player.getCurExp();
		
		int level = factory.characterLevelTable.calcCharLevel(curExp) ;
		
		long nextLevelExp = factory.characterLevelTable.calcNextLevelExp(level) ;
		
		
		int expPercent = conn.server.factory.characterLevelTable.calcExpPercent(curExp);

		
		System.out.println(String.format("level=%d curExp=%d nextLevelExp=%d", level, curExp, nextLevelExp));
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);		
		
		answer.w.writeLong(conn.player.getObjId());
		answer.w.writeUInt24(conn.player.getTemplateId());
		answer.w.writeInt(conn.player.getX());
		answer.w.writeInt(conn.player.getY());
		answer.w.writeByte(conn.player.getDirection());	
		
		answer.w.writeUInt16(level);		
		answer.w.writeByte(expPercent & 0xff);		
		
		answer.w.writeUInt24(statusInfo.maxHp);
		answer.w.writeUInt24(statusInfo.maxMp);
		answer.w.writeUInt24(statusInfo.getHp());
		answer.w.writeUInt24(statusInfo.getMp());		
		answer.w.writeUInt24(statusInfo.defense);
		answer.w.writeByte(weighted);
		answer.w.writeShort(statusInfo.moveSpeed);
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
		conn.syncQueue.clear();
		
		conn.server.factory.addGameObj(player);	
		
		conn.updateCurrentPositionToPlayers(
				conn.server.factory.hitPlayerViews(conn.player.getMapId(), conn.player.getX(), conn.player.getY())
				);

		
		conn.updateViewObjsInfo();
		
	}
}
