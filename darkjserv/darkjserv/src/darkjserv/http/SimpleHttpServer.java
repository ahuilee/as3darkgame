package darkjserv.http;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Arrays;

import darkjserv.IWork;
import darkjserv.ThreadPreStartQueue;

public class SimpleHttpServer
{
	public int port = 0;
	private ServerSocket _servSock = null;
	private Thread _thread = null;
	
	public ThreadPreStartQueue workQueue = null;
	
	public SimpleHttpServer(int port)
	{
		this.port = port;
	}
	
	public void serveForever() throws Exception
	{
		System.out.println(String.format("Http Server start...%d", port));
		
		_servSock = new ServerSocket(port);
		
		workQueue = new ThreadPreStartQueue(12);
		workQueue.start();
		
		while(true)
		{
			Socket sock = _servSock.accept();
			
			System.out.println(String.format("Http Server accept...%s", sock));
			
			Connection conn = new Connection(sock, this);
			workQueue.put(conn);
		}
		
	}
	
	
	class Request
	{
		public String url = "";
		public String method = "";
		public String host = "";
		
		
		public String toString()
		{
			return String.format("<Request method=%s url=%s>", method, url);
		}
	}
	
	class Connection implements IWork
	{
		public SimpleHttpServer server = null;
		public Socket sock = null;
		
		
		private InputStream _inputStream = null;
		private OutputStream _outputStream = null;
		
		public Connection(Socket sock, SimpleHttpServer server)
		{
			this.sock = sock;
			this.server = server;
		}
		
		
		

		public void run() throws Exception
		{
			
			_inputStream = sock.getInputStream();
			_outputStream = sock.getOutputStream();
			
			byte[] buf = new byte[8192];
			
			int recv  = _inputStream.read(buf);
			
			String text = new String(Arrays.copyOfRange(buf, 0, recv));
			
			int headerEnd = text.indexOf("\r\n\r\n") ;
			
			if(headerEnd > 0)
			{
				String header = text.substring(0, headerEnd);
				
				System.out.println(String.format("request %s", header));
				
				String[] lines = header.split("\r\n");
				
				Request request = new Request();
				request.host = "127.0.0.1";
				
				String line1 = lines[0];
				int spIdx1 = line1.indexOf(" ");
				int spIdx2 = line1.indexOf(" ", spIdx1+1);
				
				
				
				request.method = line1.substring(0, spIdx1);
				request.url = line1.substring(spIdx1 + 1, spIdx2);
				
				
				
				for(int i=1; i<lines.length; i++ )
				{
					String line = lines[i];
					String lineUpper = line.toUpperCase();
					if(lineUpper.startsWith("HOST:"))
					{
						int idx1 = line.indexOf(": ");
						String host = line.substring(idx1+2);
						
						int idx2 = host.indexOf(":");
						if(idx2 > 0)
						{
							host = host.substring(0, idx2);
						}
						
						request.host = host;
						
						//System.out.println(String.format("host=%s", host));
					}
				}
				
				RequestHandler requestHandler = new RequestHandler();
				requestHandler.handRequest(_outputStream, request);
				
				close();
			}		
			
			
		}
		
		public void close()
		{
			
						try {
							
							sock.close();
							
							if(_outputStream != null)
							{
								_outputStream.close();
								
								_outputStream= null;
							}
						
						} catch(Exception ex2)
						{
							
						}
		}

		public void except(Exception ex) {
			
			
		}
		
		
	}
	
	public void start()
	{
		_thread = new Thread(new Runnable(){

			public void run() {
				
				try 
				{
					
					serveForever();
				} catch(Exception ex)
				{
					System.out.println(ex.getMessage());
				}
				
				// TODO Auto-generated method stub
				
			}
			
			
		});
		
		_thread.start();
	}

}
