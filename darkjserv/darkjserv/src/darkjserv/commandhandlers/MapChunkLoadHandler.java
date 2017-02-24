package darkjserv.commandhandlers;

import java.awt.Rectangle;
import java.io.DataOutputStream;

import darkjserv.MapFactory;
import darkjserv.maps.IMapChunkNode;
import darkjserv.maps.IMapData;
import darkjserv.net.*;

public class MapChunkLoadHandler 
{
	
	public Connection conn = null;
	
	public MapChunkLoadHandler(Connection conn)
	{
		this.conn = conn;
	}	
	
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		int mapId = rd.readInt24();
		int cx = rd.readInt();
		int cy = rd.readInt();

		//System.out.println(String.format("MapChunkLoadHandler x,y=%d, %d mapId=%s", cx, cy, mapId));
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		MapChunk mapChunk = getMapChunk(mapId, cx, cy);
		
		//
		
		DataOutputStream w = answer.w;
		
		w.writeShort(mapChunk.tiles.length);
		w.writeShort(mapChunk.nodes.length);
		w.writeShort(mapChunk.blocks.length);
		
		
		
		for(int i=0; i<mapChunk.tiles.length; i++)
		{
			int n = mapChunk.tiles[i];
			w.writeInt(n);
			
		}
		
		
		for(IMapChunkNode node : mapChunk.nodes)
		{
			w.writeInt(node.getTemplateId());
			w.writeShort((short)node.getX());
			w.writeShort((short)node.getY());
		}
		
		for(Rectangle rect : mapChunk.blocks)
		{
			w.writeInt(rect.x);
			w.writeInt(rect.y);
			w.writeShort(rect.width);
			w.writeShort(rect.height);
		}
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		//writeAnswer(answer);		
		
		
	}
	
	public MapChunk getMapChunk(int mapId, int cx, int cy)
	{
		IMapData imap = MapFactory.getInstance().getMapDataById(mapId);
		
		MapChunk chunk = imap.getChunkByPt(cx, cy);
		
		if(chunk != null)
		{
			return chunk;
		}
		
		return imap.getDefaultChunk();
	}
	
	
}
