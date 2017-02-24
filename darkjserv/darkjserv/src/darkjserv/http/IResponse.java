package darkjserv.http;

import java.io.OutputStream;

public interface IResponse 
{
	
	void execute(OutputStream outputStream)  throws Exception;

}
