package darkjserv.commandhandlers;


import java.io.DataInputStream;

import darkjserv.Factory;
import darkjserv.MapFactory;
import darkjserv.maps.IMapData;
import darkjserv.net.AnswerSuccessResponse;
import darkjserv.net.Connection;
import darkjserv.net.GamePlayer;
import darkjserv.net.WriteAnswerWork;
import darkjserv.storages.StorageFactory;
import darkjserv.storages.UserCharacterInfo;

public class PlayerGameStart
{
	public Connection conn = null;
	
	public PlayerGameStart(Connection conn)
	{
		this.conn = conn;
	}
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		
		Factory factory = conn.server.factory;
		
		
		factory.removeConnObjs(conn);
		
		
		
		int charId = rd.readInt();		
		
		
		UserCharacterInfo info = StorageFactory.getInstance().getCharacterInfoById(charId);
		
		
		IMapData map = MapFactory.getInstance().getMapDataById(info.mapId);
		
		System.out.println();
		
		//int mapNumChunkOfX = map.getNumChunkOfX();
		//int mapNumChunkOfY = map.getNumChunkOfY();		
		
		
		long objId = conn.server.factory.makeObjId();
		
		
		int mapId = map.getMapId();
		
		
		GamePlayer player = conn.player;
		
		if(player == null)
		{
			player = new GamePlayer(charId, objId, info.charName, mapId, conn);
			conn.player = player;
			
			player.setPosition(info.x, info.y);
			player.setDex(info.charDex);
			player.setCharStr(info.charStr);
			player.setMaxHp(info.maxHp);
			player.setMaxMp(info.maxMp);
			player.setHp(info.hp);
			player.setMp(info.mp);
			player.templateId = info.templateId;
			
			player.setCurExp(info.exp);
			
			player.setViewBoundSize(conn.viewStageRect.width, conn.viewStageRect.height);
			
		}
		
		if(info.hp < 10)
		{
			info.hp = 10;
			player.hp = 10;
		}
		
		
		player.itemList.load();		
		
		
		player.loadSkills();
		player.loadShortcutItems();
		
		
		long servTicks = System.currentTimeMillis() - conn.server.factory.gameStartTime;
		
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		answer.w.writeUInt48(servTicks);
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
