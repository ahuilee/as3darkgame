package darkjserv.http;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

public class FileResponse implements IResponse
{
	
	public String path = "";
	public String contentType = "";
	
	public FileResponse(String path, String contentType)
	{
		this.path = path;
		this.contentType = contentType;
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
		String.format("Content-Type: %s\r\n", contentType) +
		String.format("Content-Length: %d\r\n", contentBytes.length) +
		"\r\n";
		
		outputStream.write(header.getBytes());
		outputStream.write(contentBytes);
		
	}

}
