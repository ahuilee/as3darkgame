package darkjserv.net;

import java.io.DataInputStream;
import java.io.InputStream;

public class DataReader extends DataInputStream
{
	
	public DataReader(InputStream inputStream)
	{
		super(inputStream);
		
	}
	
	public byte[] readBytes(int count)  throws Exception
	{
		byte[] data = new byte[count];
		int length = 0;
		while(length < count)
		{
			data[length++] = readByte();		
		}
		
		return data;
		
	}
	
	public String readBStrUTF() throws Exception
	{
		int len =  readByte() & 0xff;		
	
		if(len < 1) return "";
		
		return new String(readBytes(len), "UTF-8");		
	}
	
	public String readHStrUTF() throws Exception
	{
		int len =  readUInt16();		
	
		if(len < 1) return "";
		
		return new String(readBytes(len), "UTF-8");		
	}
	
	public int readUInt24() throws Exception
	{
		return ((readByte() << 16) & 0xff0000) | ((readByte() << 8) & 0x00ff00) | (readByte()  & 0x0000ff);
	}
	
	public int readInt24() throws Exception
	{
		int val = readUInt24();
		
		if(val > 0x7fffff)
		{
			val += -(0xffffff + 1);
		}
		
		return val;
	}
	
	public int readUInt16() throws Exception
	{
		return ((readByte() << 8) & 0xff00) | (readByte()  & 0x00ff);
	}

}
