package darkjserv.commandhandlers;

import java.awt.Rectangle;
import java.io.DataInputStream;
import java.util.List;

import darkjserv.net.*;
import darkjserv.storages.StorageFactory;
import darkjserv.syncs.AnimationSyncSetWalkTo;
import darkjserv.syncs.SyncObjWalkTo;


public class PlayerWalkToHandler 
{
	
	public Connection conn = null;
	
	public PlayerWalkToHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		int x1 = rd.readInt();
		int y1 = rd.readInt();
		byte dir = rd.readByte();
		
		int x2 = rd.readInt();
		int y2 = rd.readInt();
		
		
		int mapId = conn.player.getMapId();
		
		
		conn.player.setX(x1);
		conn.player.setY(y1);
		conn.player.direction = dir;
		
		
		int moveSpeed = conn.player.getMoveSpeed();
		
		
		double dist = Math.sqrt(Math.pow(x2- x1, 2) + Math.pow(y2-y1, 2));
		int duration = (int)(dist * 100.0 / (double)moveSpeed);
		
	
		//System.out.println(String.format("PlayerWalkTo pt1=%d, %d pt2=%d, %d dir=%d duration=%d", x1, y1, x2, y2, dir, duration));
		
		
		//broadcast
		Rectangle viewRect1 = conn.player.viewRect;
		Rectangle viewRect2 = new Rectangle(x2 - viewRect1.width / 2, y2-viewRect1.height/2, viewRect1.width, viewRect1.height);
		Rectangle viewRect = viewRect1.union(viewRect2);
		
	
		List<GamePlayer> allPlayers = conn.server.factory.hitPlayerViewsByRect(mapId, viewRect);	
		
		
		long startTime = System.currentTimeMillis();
		long startServTick = (int)(startTime - conn.server.factory.gameStartTime);
		SyncObjWalkTo syncNode = new SyncObjWalkTo(x1, y1, dir, x2, y2, startTime, startServTick, duration, 0);
		
		for(GamePlayer p : allPlayers)
		{
			if(p == conn.player) continue;			


			p.conn.syncQueue.put(conn.player, syncNode);
			
		}

		//updateCurrentPositionToPlayers(new ArrayList<GamePlayer>(allPlayers));
		conn.updateViewObjsInfo();	
		
		long expirytime = startTime + duration;
		
		AnimationSyncSetWalkTo syncState = new AnimationSyncSetWalkTo(conn.player, x1, y1, x2, y2, startTime, startServTick, duration, expirytime);
		
		conn.player.setCurrentAnimationSyncSet(syncState);
		
		StorageFactory.getInstance().savePlayer(conn.player);
		
	}
}
