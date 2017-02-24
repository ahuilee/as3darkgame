package darkjserv.http;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

public class HtmlFileResponse implements IResponse
{
	
	public String path = "";
	
	public HtmlFileResponse(String path)
	{
		this.path = path;
	}

	public void execute(OutputStream outputStream) throws Exception
	{
		
		String root =new File(".").getCanonicalPath();
		
		File file = new File(root, path);
		
		FileInputStream fInputStream = new FileInputStream(file);
		
		//System.out.println(String.format("HtmlFileResponse %s", file));
		
		byte[] contentBytes = new byte[(int)file.length()];
		
		
		
		fInputStream.read(contentBytes);	
		fInputStream.close();
		
		String header = "HTTP/1.1 200 OK\r\n" +
		"Content-Type: text/html\r\n" +
		String.format("Content-Length: %d\r\n", contentBytes.length) +
		"\r\n";
		
		outputStream.write(header.getBytes());
		outputStream.write(contentBytes);
		
	}

}
