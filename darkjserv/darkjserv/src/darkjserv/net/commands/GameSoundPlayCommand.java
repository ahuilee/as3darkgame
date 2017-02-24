package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

import darkjserv.net.CommandCode;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class GameSoundPlayCommand  implements ICommand
{
	
	public int id = 0;
	public byte volume = 0;
	
	public ICommandCallback callback = null;
	
	public GameSoundPlayCommand(int id, byte volume)
	{
		this.id = id;
		this.volume = volume;

		
	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.GAME_SOUND_PLAY;
	}

	public byte[] getCommandBytes() throws Exception {
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataOutputStream w = new DataOutputStream(stream);
		
		w.writeInt(id);
		w.writeByte(volume);
		
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
