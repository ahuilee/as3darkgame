package darkjserv.commandhandlers;


import java.io.DataInputStream;
import darkjserv.net.*;


public class PlayerPositionChangeHandler 
{
	
	public Connection conn = null;
	
	public PlayerPositionChangeHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		
		GamePlayer player = conn.player;
		//int x1 = player.getX();
				//int y1 = player.getY();
		int x2 = rd.readInt();
		int y2 = rd.readInt();
		byte dir = rd.readByte();
				
		player.setPosition(x2, y2);
			
		player.direction = dir;
				
				//System.out.println(String.format("pos change x=%d y=%d", x2, y2));
				
		conn.updateViewObjsInfo();
		
	}
}
