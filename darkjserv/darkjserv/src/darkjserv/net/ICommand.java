package darkjserv.net;

public interface ICommand 
{
	
	int getCommandCode();
	
	byte[] getCommandBytes() throws Exception;
	
	ICommandCallback getCallback();

}
