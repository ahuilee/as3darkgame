package darkjserv.net;

public class Packet
{
	
	public static final byte COMMAND = 0x01;
	public static final byte ANSWER = 0x02;
	
	public static final byte ANSWER_SUCCESS = 0x01;
	public static final byte ANSWER_ERROR = 0x02;
	
	public int qid = 0;
	public byte type = 0;
	public byte[] data = null;
	
	
	public String toString()
	{
		return String.format("<Packet type=%d qid=%d>", type, qid);
	}
}
