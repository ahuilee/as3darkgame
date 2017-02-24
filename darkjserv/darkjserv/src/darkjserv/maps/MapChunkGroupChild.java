package darkjserv.maps;

import darkjserv.net.MapChunk;

public class MapChunkGroupChild
{
	public int rx = 0;
	public int ry = 0;
	
	public MapChunk mapChunk =null;
	
	
	public MapChunkGroupChild(int rx, int ry, MapChunk mapChunk)
	{
		this.rx = rx;
		this.ry = ry;
		this.mapChunk = mapChunk;
	}
	
	
	public String toString()	
	{
		return String.format("<MapChunkChild rx=%d ry=%d >", rx, ry);
	}
	
}
