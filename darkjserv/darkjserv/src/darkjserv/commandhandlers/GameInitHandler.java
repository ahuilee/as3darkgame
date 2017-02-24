package darkjserv.commandhandlers;


import java.util.List;


import darkjserv.MapFactory;
import darkjserv.maps.IMapData;
import darkjserv.maps.MapPt;
import darkjserv.net.*;


public class GameInitHandler 
{
	
	public Connection conn = null;
	
	public GameInitHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		GamePlayer player = conn.player;
		
		IMapData map = MapFactory.getInstance().getMapDataById(player.mapId);
		
		
		if(player.state == GamePlayer.STATE_DEAD)
		{
			System.out.println(String.format("%s Is DEAD!!", player));
			
			MapPt safePt = map.randSafePt();
			
			player.setMapId(safePt.mapId);
			player.setX(safePt.x);
			player.setY(safePt.y);
			player.setIsDead(false);
			player.state = GamePlayer.STATE_NONE;
		}
		
		IMapData map2 = MapFactory.getInstance().getMapDataById(player.getMapId());
		
	
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);		
		
		answer.w.writeUInt24(map2.getMapId());
		answer.w.writeUInt16(map2.getNumChunkOfX());
		answer.w.writeUInt16(map2.getNumChunkOfY());
		
		
		List<Integer> assetPks = map.getAssetPks();	
		
		
		answer.w.writeUInt16(assetPks.size());
		
		for(int i=0; i<assetPks.size(); i++)
		{
			Integer assetPk = assetPks.get(i);
			
			answer.w.writeUInt16(assetPk);
			//answer.w.writeByte(item.getType());
			//answer.w.writeBStrUTF(item.getURL());
		}
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
