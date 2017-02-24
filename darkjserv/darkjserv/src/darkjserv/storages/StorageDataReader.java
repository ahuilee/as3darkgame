package darkjserv.storages;

import java.io.DataInputStream;
import java.io.InputStream;

public class StorageDataReader extends DataInputStream
{

	public StorageDataReader(InputStream arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}
	
	public String readHStrUTF() throws Exception
	{
		int len = readUShort();
		
		
		if(len < 1) return "";
		
		
		return new String(readBytes(len), "UTF-8");		
	}
	
	
	public int readUShort() throws Exception
	{
		return ((readByte() & 0xff) << 8) | (readByte() & 0xff);
	}
	
	public byte[] readHBytes() throws Exception
	{
		int len = readUShort();
		
		
		return readBytes(len);
	}
	
	public byte[] readBBytes() throws Exception
	{
		int len = readByte() & 0xff;
		
		
		return readBytes(len);
	}
	
	public byte[] readBytes(int count)  throws Exception
	{
		
		byte[] data = new byte[count];
		/*
		int length = 0;
		while(length < count)
		{
			data[length++] = readByte();		
		}*/
		
		readFully(data);
		
		
		
		return data;
		
	}
	

}
