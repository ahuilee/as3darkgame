package darkjserv.storages;

import java.io.DataOutputStream;
import java.io.OutputStream;

public class StorageDataWriter extends DataOutputStream
{

	public StorageDataWriter(OutputStream arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}
	
	public void writeHStrUTF(String text) throws Exception
	{
		byte[] bytes = text.getBytes("UTF8");
		
		int len = bytes.length;
		writeByte((len & 0xff00) >> 8);
		writeByte((len & 0x00ff));
		write(bytes);		
		
	}
	
	public void writeUShort(int value) throws Exception
	{
		
		writeByte((value & 0xff00) >> 8);
		writeByte((value & 0x00ff));
		
	}
	
	public void writeHBytes(byte[] data) throws Exception
	{
		writeUShort(data.length);
		
		write(data);	
	}
	
	public void writeBBytes(byte[] data) throws Exception
	{
		writeByte(data.length & 0xff);
		
		write(data);	
	}
	

}
