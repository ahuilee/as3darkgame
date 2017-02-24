package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class PlayerHealthUpdateCommand  implements ICommand
{
	
	public int curHp = 0;
	public int curMp = 0;	
	
	public ICommandCallback callback = null;
	
	public PlayerHealthUpdateCommand(int curHp, int curMp)
	{
		this.curHp = curHp;	
		this.curMp = curMp;
		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.PLAYER_HEALTH_UPDATE;
	}

	public byte[] getCommandBytes() throws Exception
	{
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		@SuppressWarnings("resource")
		DataWriter w = new DataWriter(stream);	
	
		w.writeUInt24(curHp);
		w.writeUInt24(curMp);
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
