package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class SkillEffectPlayFollowCommand  implements ICommand
{
	
	public int id = 0;
	public long objId =0;

	public ICommandCallback callback = null;
	
	public SkillEffectPlayFollowCommand(int id, long objId)
	{
		this.id = id;
		this.objId = objId;
		
		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.SKILL_EFFECT_PLAY_FOLLOW;
	}

	public byte[] getCommandBytes() throws Exception {
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataWriter w = new DataWriter(stream);
		
		w.writeUInt24(id);
		w.writeLong(objId);
	
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
