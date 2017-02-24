package darkjserv.commandhandlers;

import java.util.List;

import darkjserv.ICSkillSet;
import darkjserv.net.AnswerSuccessResponse;
import darkjserv.net.Connection;
import darkjserv.net.DataReader;

import darkjserv.net.WriteAnswerWork;;

public class PlayerSkillListHandler
{
	public Connection conn = null;
	
	public PlayerSkillListHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		List<ICSkillSet> allSkills = conn.player.skillList.getAllSkills();
		
		answer.w.writeShort(allSkills.size());		
	
		
		for(ICSkillSet skill : allSkills)
		{
			answer.w.writeUInt24(skill.getSkillId());
			answer.w.writeByte(skill.getTargetType());
			answer.w.writeUInt24(skill.getTemplateId());
			answer.w.writeBStrUTF(skill.getSkillName());
		}	
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));		
		
	}
}
