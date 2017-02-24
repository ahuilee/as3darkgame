package darkjserv.net;

import darkjserv.IWork;

public class WriteCommandWork implements IWork
{
	
	public ICommand command = null;
	public Connection conn = null;
	
	public WriteCommandWork(ICommand command, Connection conn)
	{
		this.command = command;
		this.conn = conn;
	}

	public void run() throws Exception 
	{
		conn.writeCommand(command);
		
	}

	public void except(Exception ex) {
		// TODO Auto-generated method stub
		
	}

}
