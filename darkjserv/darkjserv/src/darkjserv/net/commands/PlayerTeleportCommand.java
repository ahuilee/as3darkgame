package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class PlayerTeleportCommand  implements ICommand
{
	
	public int mapId = 0;
	public int x = 0;
	public int y = 0;
	public int delay = 0;
	public ICommandCallback callback = null;
	
	public PlayerTeleportCommand(int mapId, int x, int y, int delay)
	{
		this.mapId = mapId;
		this.x = x;
		this.y = y;
		this.delay = delay;
		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.PLAYER_TELEPORT;
	}

	public byte[] getCommandBytes() throws Exception {
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataOutputStream w = new DataOutputStream(stream);
		
		w.writeInt(mapId);
		w.writeInt(x);
		w.writeInt(y);
		w.writeInt(delay);
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
