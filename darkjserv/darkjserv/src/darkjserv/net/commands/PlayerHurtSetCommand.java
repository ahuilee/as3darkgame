package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class PlayerHurtSetCommand  implements ICommand
{
	
	
	
	public ICommandCallback callback = null;
	
	public PlayerHurtSetCommand()
	{

		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.PLAYER_HURT_SET;
	}

	public byte[] getCommandBytes() throws Exception {
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		//DataOutputStream w = new DataOutputStream(stream);
		
		
		
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
