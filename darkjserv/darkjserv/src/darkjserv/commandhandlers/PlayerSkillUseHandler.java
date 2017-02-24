package darkjserv.commandhandlers;



import darkjserv.ICSkillSet;

import darkjserv.SkillFactory;
import darkjserv.SkillUseWork;
import darkjserv.net.*;
import darkjserv.net.commands.PlayerHealthUpdateCommand;

public class PlayerSkillUseHandler 
{
	
	public Connection conn = null;
	
	public PlayerSkillUseHandler(Connection conn)
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
		
		int skillId = rd.readInt24();
		long targetObjId = rd.readLong();
		int targetX = rd.readInt();
		int targetY = rd.readInt();
		byte dir2 = rd.readByte();
		
		player.setDirection(dir2);
		
		System.out.println(String.format("SkillUse dir2=%d", dir2));
		
		
	
		ICSkillSet skillSet = SkillFactory.getInstance().getSkillSetById(skillId);
		
		
		SkillUseWork skillWork = new SkillUseWork(player, skillSet, targetX, targetY, conn.server.factory);
		
		if(skillWork.run())
		{
			PlayerHealthUpdateCommand mpUpdateCmd = new PlayerHealthUpdateCommand(player.getHp(), player.getMp());
			
			player.conn.writeCommand(mpUpdateCmd);
		}
		
		
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
