package darkjserv.net;

import java.io.DataOutputStream;
import java.io.OutputStream;

public class DataWriter extends DataOutputStream
{
	
	public DataWriter(OutputStream baseStream)
	{
		super(baseStream);
	}
	
	public void writeUInt32(long value) throws Exception	
	{
	
		writeByte((byte)((value & 0x0000ff000000L) >> 24));
		writeByte((byte)((value & 0x000000ff0000L) >> 16));
		writeByte((byte)((value & 0x00000000ff00L) >> 8));
		writeByte((byte)(value  & 0x0000000000ffL));
	}
	
	
	public void writeUInt48(long value) throws Exception	
	{
		writeByte((byte)((value & 0xff0000000000L) >> 40));
		writeByte((byte)((value & 0x00ff00000000L) >> 32));
		writeByte((byte)((value & 0x0000ff000000L) >> 24));
		writeByte((byte)((value & 0x000000ff0000L) >> 16));
		writeByte((byte)((value & 0x00000000ff00L) >> 8));
		writeByte((byte)(value  & 0x0000000000ffL));
	}
	
	
	public void writeUInt16(int value) throws Exception	
	{
		
		writeByte((byte)((value & 0xff00) >> 8));
		writeByte((byte)(value & 0x00ff));
	}
	
	public void writeUInt24(int value) throws Exception	
	{
		writeByte((byte)((value & 0xff0000) >> 16));
		writeByte((byte)((value & 0x00ff00) >> 8));
		writeByte((byte)(value & 0x0000ff));
	}
	
	public void writeIntN(long value) throws Exception	
	{
		
		if(value >= Byte.MIN_VALUE && value <= Byte.MAX_VALUE)
		{
			writeByte(0x01);
			writeByte((byte)value);
			return;
		} 
		
		if(value >= Short.MIN_VALUE && value <= Short.MAX_VALUE)
		{
			writeByte(0x02);
			writeShort((short)value);
			return;
		}
		
		if(value >= Integer.MIN_VALUE && value <= Integer.MAX_VALUE)
		{
			writeByte(0x04);
			writeInt((int)value);
			return;
		}
		
		
	}
	
	public void writeHStrUTF(String text) throws Exception
	{
		byte[] bytes = text.getBytes("UTF8");
		
		int len = bytes.length;
		writeByte((len & 0xff00) >> 8);
		writeByte((len & 0x00ff));
		write(bytes);		
	}
	
	public void writeBStrUTF(String text) throws Exception
	{
		byte[] bytes = text.getBytes("UTF8");
		
		writeByte(bytes.length);
		write(bytes);
		
	}
	
	public void writeHBytes(byte[] data) throws Exception
	{
		writeUInt16(data.length);
		
		write(data);	
	}
	

}
