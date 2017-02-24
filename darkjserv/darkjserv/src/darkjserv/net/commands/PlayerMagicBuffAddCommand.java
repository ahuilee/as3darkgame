package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class PlayerMagicBuffAddCommand  implements ICommand
{
	
	public int typeId = 0;
	public int templateId = 0;	
	public long expireServTick = 0;
	
	public ICommandCallback callback = null;
	
	public PlayerMagicBuffAddCommand(int typeId, int templateId, long expireServTick)
	{
		this.typeId = typeId;	
		this.templateId = templateId;
		this.expireServTick = expireServTick;
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.PLAYER_MAGIC_BUFF_ADD;
	}

	public byte[] getCommandBytes() throws Exception
	{
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		@SuppressWarnings("resource")
		DataWriter w = new DataWriter(stream);	
	
		w.writeUInt24(typeId);
		w.writeUInt24(templateId);
		w.writeUInt48(expireServTick);
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
