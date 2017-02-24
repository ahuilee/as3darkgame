package darkjserv.commandhandlers;


import darkjserv.net.*;


public class SetStageSizeHandler 
{
	
	public Connection conn = null;
	
	public SetStageSizeHandler(Connection conn)
	{
		this.conn = conn;
	}	
	
	
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		int width = rd.readUInt24();
		int height = rd.readUInt24();
		
		
		
		int width2 = width * 2;
		int height2 = height * 2;
		
		conn.setViewBoundSize(width2, height2);
		
		
		
		System.out.println(String.format("SetStageSize w=%d h=%d viewBound=%s", width, height, conn.viewStageRect));
	
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);	
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		//writeAnswer(answer);
		
	}
}
