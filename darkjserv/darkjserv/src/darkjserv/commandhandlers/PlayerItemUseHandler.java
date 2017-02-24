package darkjserv.commandhandlers;

import java.awt.Rectangle;
import java.io.DataInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import darkjserv.GameEffectEnums;
import darkjserv.MapFactory;
import darkjserv.items.CItemEnums;
import darkjserv.items.ICItem;
import darkjserv.maps.IMapData;
import darkjserv.maps.MapPt;
import darkjserv.net.*;
import darkjserv.net.commands.*;
import darkjserv.storages.StorageFactory;

public class PlayerItemUseHandler 
{
	
	public Connection conn = null;
	
	public PlayerItemUseHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	

	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		int itemId = rd.readInt();
		ICItem item = conn.player.itemList.getItemById(itemId);
		
		System.out.println(String.format("ItemUse %s", item));
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		
		HashSet<Byte> results = new HashSet<Byte>();
		
		
		
		if(item != null)
		{
			
			byte itemType = CItemEnums.getItemTypeByBaseId(item.getItemBaseId());
			
			switch(itemType)
			{
				case CItemEnums.TYPE_LIQUID:
				
					break;
			
				case CItemEnums.TYPE_SCROLL:					
					handleScroll(item, results);
					
					
					break;
					
				
				
				case CItemEnums.TYPE_EQUIPMENT:
					if(conn.player.itemList.useEquipment(itemId))
					{
						results.add(CItemEnums.USE_RESULT_CLEARDICT);
						
					}
					
					results.add(CItemEnums.USE_RESULT_GETINFO);
					
					conn.player.clearStatusInfoCache();
					break;
			
			}
			
						
		}
		
		
		List<Byte> _results = new ArrayList<Byte>(results);
		
		byte rsCount = (byte)(_results.size() & 0xff);
		answer.w.writeByte(rsCount);
		
		for(int i=0;i<rsCount; i++)
		{
			answer.w.writeByte(_results.get(i));
		}
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));
	
		
		StorageFactory.getInstance().savePlayer(conn.player);
	}
	
	
	private void handleScroll(ICItem item, HashSet<Byte> results) throws Exception
	{
		int itemBaseId = item.getItemBaseId();
		
		switch(itemBaseId)
		{
			case 101:
				handleBackHome(item);
				break;
			case 102:
				gotoMap(item, 2);
				break;
			case 103:
				gotoMap(item, 3);
				break;
		}
		
		
		long lastCount = item.getItemCount();
		
		if(lastCount < 1)
		{
			results.add(CItemEnums.USE_RESULT_DELETE);
		
		}					
		
	}
	
	private void gotoMap(ICItem item, int mapId) throws Exception
	{
		IMapData mapData = MapFactory.getInstance().getMapDataById(mapId);
		
		System.out.println(String.format("gotoMap %d", mapId, mapData));
		
		MapPt pt = mapData.randEnterPt();
		
		doTeleport(pt.mapId, pt.x, pt.y);		
		
		item.setItemCount(item.getItemCount()-1);
		
	}
	
	private void handleBackHome(ICItem item) throws Exception
	{
		
		
		int mapId = conn.player.mapId;
		
		IMapData mapData = MapFactory.getInstance().getMapDataById(mapId);
		
		
		MapPt pt = mapData.randSafePt();
		
		doTeleport(pt.mapId, pt.x, pt.y);		
		
		item.setItemCount(item.getItemCount()-1);
			
	}
	
	private void doTeleport(int mapId, int x2, int y2) throws Exception
	{
		int x1 = conn.player.getX();
		int y1 = conn.player.getY();
		
		conn.player.setMapId(mapId);
		conn.player.setX(x2);
		conn.player.setY(y2);
		
		
		//update to other players

		Rectangle viewRect1 = conn.player.viewRect;
		Rectangle viewRect2 = new Rectangle(x1 - viewRect1.width / 2, y1-viewRect1.height/2, viewRect1.width, viewRect1.height);
		Rectangle viewRect = viewRect1.union(viewRect2);
		
		List<GamePlayer> allPlayers = conn.server.factory.hitPlayerViewsByRect(conn.player.getMapId(), viewRect);	
		

		ArrayList<Long> rmPks = new ArrayList<Long>();
		rmPks.add(conn.player.objId);
		
		
		RemoveObjCommand removeObj = new RemoveObjCommand(rmPks);
		
		SkillEffectPlayCommand effectPlay = new SkillEffectPlayCommand(GameEffectEnums.TELEPORT, x1, y1);		
			
		PlayerTeleportCommand cmd = new PlayerTeleportCommand(mapId, x2, y2, 100);	
		
		conn.putWork(new WriteCommandWork(effectPlay, conn));
		
		conn.putWork(new WriteCommandWork(cmd, conn));
		
		for(GamePlayer p : allPlayers)
		{
			if(p == conn.player) continue;			

				
			p.conn.writeCommand(removeObj);
			p.conn.writeCommand(effectPlay);
			
		}
		
	}
	
	
	
	
	
}
