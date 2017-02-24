package darkjserv.net;

import java.io.ByteArrayOutputStream;

public class AnswerSuccessResponse 
{
	
	public int ask = 0;
	
	public ByteArrayOutputStream outputStream = null;
	public DataWriter w = null;
	
	public AnswerSuccessResponse(int ask) throws Exception
	{
		this.ask = ask;
		
		outputStream = new ByteArrayOutputStream();
		w = new DataWriter(outputStream);		
		
		w.writeInt(ask);
		w.writeByte(Packet.ANSWER_SUCCESS);
		
		
	}
	
	public String toString()
	{
		return String.format("<AnswerSuccessResponse ask=%d>", ask);
	}
	
	
	
	

}
