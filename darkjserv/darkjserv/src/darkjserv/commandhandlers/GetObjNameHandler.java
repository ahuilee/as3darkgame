package darkjserv.commandhandlers;


import java.io.DataInputStream;
import java.util.List;

import darkjserv.IGameObj;
import darkjserv.net.*;


public class GetObjNameHandler 
{
	
	public Connection conn = null;
	
	public GetObjNameHandler(Connection conn)
	{
		this.conn = conn;
	}	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		
		long objId = rd.readLong();
		
		IGameObj iobj = conn.server.factory.getGameObj(objId);
		
		List<Byte> interactiveCodes = null;
		String objName  = "";
		
		if(iobj != null)
		{
			
			interactiveCodes = iobj.getInteractiveCodes();
			objName = iobj.getName();
		}
		
	
	
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);	
		
		if(interactiveCodes == null)
		{
			answer.w.writeByte(0);
			
		} else 
		{
		
			answer.w.writeByte(interactiveCodes.size());
			for(Byte code : interactiveCodes)
			{
				answer.w.writeByte(code);
			}	
			
		}
		
		
		
				
		answer.w.writeBStrUTF(objName);
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		//writeAnswer(answer);
		
	}
}
