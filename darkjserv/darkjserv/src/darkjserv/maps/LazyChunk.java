package darkjserv.maps;

import java.awt.Rectangle;

import darkjserv.net.MapChunk;

public class LazyChunk extends MapChunk
{
	
	public LazyChunk(int[] tiles)
	{
		this.tiles = tiles;
		this.nodes = new IMapChunkNode[0];
		this.blocks =  new Rectangle[0];
		
	}
	
	
}