package darkjserv.net;

import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.TimeZone;

import darkjserv.Factory;
import darkjserv.ThreadPreStartQueue;

public class Server 
{
	
	public int port = 0;
	
	private ServerSocket _servSock = null;
	
	public ThreadPreStartQueue connWorkQueue = null;	
	
	private ArrayList<Connection> _connList = new ArrayList<Connection>();
	
	
	public Factory factory = null;
	
	public TimeZone timeZone = null;
	
	public Server(int port)
	{
		this.port = port;
		timeZone = TimeZone.getTimeZone("UTC");
		
		factory = Factory.getInstance();
	}
	
	
	public void serveForever() throws Exception
	{
		try {
			System.out.println(String.format("Server start...%d", port));
			_servSock = new ServerSocket(port);
			
			connWorkQueue = new ThreadPreStartQueue(2);
			connWorkQueue.start();
			
			factory.start();
			
			while(true)
			{
				Socket sock = _servSock.accept();
				
				
				makeConnection(sock);			
				
			}
		} catch(Exception ex)
		{
			System.out.println(String.format("Server %s", ex.getMessage()));
		}
		
	}
	
	private int _lastConnId = 0;
	
	private void makeConnection(Socket sock)
	{
		System.out.println(String.format("makeConnection %s", sock));
		
		synchronized(_connList)
		{
			Connection conn = new Connection(++_lastConnId, sock, this);
			connWorkQueue.put(conn);
			
			_connList.add(conn);
	
		}
	}
	
	

}
