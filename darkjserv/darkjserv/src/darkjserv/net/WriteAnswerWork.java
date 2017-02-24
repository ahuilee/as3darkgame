package darkjserv.net;

import darkjserv.IWork;


public class WriteAnswerWork implements IWork
{
	
	public AnswerSuccessResponse answer = null;
	public Connection conn = null;
	
	public WriteAnswerWork(AnswerSuccessResponse answer, Connection conn)
	{
		this.answer = answer;
		this.conn = conn;
	}

	public void run() throws Exception 
	{
		// TODO Auto-generated method stub
		conn.writeAnswer(answer);
	}

	public void except(Exception ex) {
		// TODO Auto-generated method stub
		
	}
	
	public String toString()
	{
		return String.format("<WriteAnswerWork %s>", answer);
	}
	
}
