package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class DisplayTalkMessageCommand  implements ICommand
{
	
	public String text = "";
	
	
	public ICommandCallback callback = null;
	
	public DisplayTalkMessageCommand(String text)
	{
		this.text = text;	

	}
	
	public int getCommandCode()
	{
		// TODO Auto-generated method stub
		return CommandCode.DISPLAY_TALK_MESSAGE;
	}

	public byte[] getCommandBytes() throws Exception
	{
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		@SuppressWarnings("resource")
		DataWriter w = new DataWriter(stream);
		
		w.writeHStrUTF(text);		
		
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() 
	{
		// TODO Auto-generated method stub
		return callback;
	}

}
