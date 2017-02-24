package darkjserv;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class PolicyServer 
{
	
	public int port = 0;
	
	private ServerSocket _servSock = null;
	
	public ThreadPreStartQueue workQueue = null;

	public PolicyServer(int port)
	{
		this.port = port;
	}
	
	
	private Thread _thread = null;
	
	public void start()
	{
		_thread = new Thread(new Runnable(){

			public void run() {
				try {
					serveForever();
					
				} catch(Exception ex)
				{
					System.out.println(String.format("policy server... %s", ex.getMessage()));
					
				}
				
			}	
			
			
		});
		
		_thread.start();
	}
	
	public void serveForever() throws Exception
	{
		System.out.println(String.format("PolicyServer start...%d", port));
		
		_servSock = new ServerSocket(port);
		
		workQueue = new ThreadPreStartQueue(8);
		workQueue.start();
		
		
		
		while(true)
		{
			Socket sock = _servSock.accept();
			makeConnection(sock);
		}		
	}
	
	private void makeConnection(Socket sock)
	{
		
		
		Connection conn = new Connection(sock);
		workQueue.put(conn);
		
		System.out.println(String.format("policy connect %s  %s", this, conn));
	}
	
	class Connection implements IWork
	{
		
		public Socket sock = null;
		
		private InputStream _inputStream = null;
		private OutputStream _outputStream = null;
		
		public Connection(Socket sock)
		{
			
			this.sock = sock;
			
		}

		public void run() throws Exception
		{
	
			
			_inputStream = sock.getInputStream();
			_outputStream = sock.getOutputStream();
			
			byte[] buf = new byte[4096];
			
			int recv = _inputStream.read(buf);
			
			if(recv < 1) throw new Exception(String.format("recv = %d", recv));
			
			String root = new File(".").getCanonicalPath();
			File file = new File(root, "policyfile.txt");
			FileInputStream fInputStream = new FileInputStream(file);
			
			byte[] contentBytes = new byte[(int)file.length()];
			
			
			
			fInputStream.read(contentBytes);
			fInputStream.close();
			_outputStream.write(contentBytes);
			
			//end
			_outputStream.write(new byte[]{0});
			_outputStream.flush();
			
			System.out.println(String.format("response %s", new String(contentBytes)));
		}

		public void except(Exception ex) 
		{
			System.out.println(ex.getMessage());
			
		}
		
	
	}
	
}
