package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import darkjserv.net.CommandCode;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class PlayerDeadCommand  implements ICommand
{
	

	
	public ICommandCallback callback = null;
	
	public PlayerDeadCommand()
	{
		
		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.PLAYER_DEAD;
	}

	public byte[] getCommandBytes() throws Exception
	{
		ByteArrayOutputStream stream = new ByteArrayOutputStream();	
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
