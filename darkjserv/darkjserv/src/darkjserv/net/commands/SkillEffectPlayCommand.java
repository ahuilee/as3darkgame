package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class SkillEffectPlayCommand  implements ICommand
{
	
	public int id = 0;
	public int x2 =0;
	public int y2 = 0;
	public ICommandCallback callback = null;
	
	public SkillEffectPlayCommand(int id, int x2, int y2)
	{
		this.id = id;
		this.x2 = x2;
		this.y2 = y2;
		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.SKILL_EFFECT_PLAY;
	}

	public byte[] getCommandBytes() throws Exception {
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataWriter w = new DataWriter(stream);
		
		w.writeUInt24(id);
		w.writeInt(x2);
		w.writeInt(y2);
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
