package darkjserv.commandhandlers;


import java.util.List;

import darkjserv.GameEffectEnums;
import darkjserv.MapFactory;
import darkjserv.maps.IMapData;

import darkjserv.net.Connection;
import darkjserv.net.DataReader;
import darkjserv.net.GamePlayer;
import darkjserv.net.WriteCommandWork;
import darkjserv.net.commands.SkillEffectPlayCommand;


public class PlayerTeleportDoneHandler
{
	public Connection conn = null;
	
	public PlayerTeleportDoneHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		
		//Factory factory = conn.server.factory;
		
		int mapId = rd.readInt24();
		int x2 = rd.readInt();
		int y2 = rd.readInt();
	
		
		IMapData map = MapFactory.getInstance().getMapDataById(mapId);		
		
		
		conn.player.setMapId(mapId);
		conn.player.setX(x2);
		conn.player.setY(y2);
		
		List<GamePlayer> players = conn.server.factory.hitPlayerViews(map.getMapId(), x2, y2);
		
		SkillEffectPlayCommand effectPlay = new SkillEffectPlayCommand(GameEffectEnums.TELEPORT, x2, y2);
		
		System.out.println(String.format("PlayerMapLoadHandler mpaId=%d x2=%d, y2=%d players=%d", mapId, x2, y2, players.size()));
		
		for(GamePlayer p: players)
		{
			try
			{
				p.conn.putWork(new WriteCommandWork(effectPlay, p.conn));			
				
			}catch(Exception ex)
			{
				
			}
		}
		
		conn.updateCurrentPositionToPlayers(players);
		

		conn.updateViewObjsInfo();
	}
}
