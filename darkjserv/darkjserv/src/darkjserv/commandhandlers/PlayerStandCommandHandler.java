package darkjserv.commandhandlers;


import java.io.DataInputStream;
import java.util.List;

import darkjserv.net.*;
import darkjserv.storages.StorageFactory;
import darkjserv.syncs.SyncObjStand;



public class PlayerStandCommandHandler 
{
	
	public Connection conn = null;
	
	public PlayerStandCommandHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
	
		
		int x2 = rd.readInt();
		int y2 = rd.readInt();
		byte dir = rd.readByte();
		
		int mapId = conn.player.getMapId();
		
		conn.player.setX(x2);
		conn.player.setY(y2);
		conn.player.direction = dir;	
		
		
		//broadcast	
	
		List<GamePlayer> allPlayers = conn.server.factory.hitPlayerViewsByRect(mapId, conn.player.viewRect);			
		
		long startTime = System.currentTimeMillis();
		

		for(GamePlayer p : allPlayers)
		{
			if(p == conn.player) continue;			

				
			SyncObjStand syncNode = new SyncObjStand(conn.player, startTime, 1);
			p.conn.syncQueue.put(conn.player, syncNode);
			
		}
		
		StorageFactory.getInstance().savePlayer(conn.player);

		//updateCurrentPositionToPlayers(new ArrayList<GamePlayer>(allPlayers));
		//conn.updateViewObjsInfo();	
		
		
		
		//AnimationSyncSetWalkTo syncState = new AnimationSyncSetWalkTo(conn.player, x2, y2, endTime);
		
		//conn.player.setCurrentAnimationSyncSet(syncState);
		
	}
}
