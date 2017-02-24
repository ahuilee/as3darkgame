package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class PlayerLevelUpdateCommand  implements ICommand
{
	
	public int level = 0;
	//0~255 = 0~100%
	public int expPercent = 0;

	public int maxHp = 0;
	public int maxMp = 0;
	
	public ICommandCallback callback = null;
	
	public PlayerLevelUpdateCommand(int level, int expPercent, int maxHp, int maxMp)
	{
		this.level = level;	
		this.expPercent = expPercent;
		
		this.maxHp = maxHp;
		this.maxMp = maxMp;
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.PLAYER_LEVEL_UPDATE;
	}

	public byte[] getCommandBytes() throws Exception
	{
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataWriter w = new DataWriter(stream);
		
		w.writeUInt16(level);
		w.writeByte(expPercent & 0xff);
		w.writeUInt24(maxHp);
		w.writeUInt24(maxMp);
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
