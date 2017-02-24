package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.util.List;

import darkjserv.net.CommandCode;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class RemoveObjCommand implements ICommand
{
	
	
	public List<Long> objPks =null;
	
	
	public RemoveObjCommand(List<Long> objPks)
	{
		this.objPks = objPks;
	}

	public int getCommandCode() {
		
		return CommandCode.GAME_REMOVE_OBJ;
	}

	public byte[] getCommandBytes() throws Exception
	{
		
		
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataOutputStream w = new DataOutputStream(stream);
		
		w.writeShort(objPks.size());
		
		for(Long pk : objPks)
		{
			
			w.writeLong(pk);			
		}
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
