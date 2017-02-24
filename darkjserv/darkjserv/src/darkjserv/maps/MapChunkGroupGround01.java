package darkjserv.maps;

import java.util.ArrayList;
import java.util.List;



public class MapChunkGroupGround01 {

	
	
	public List<MapChunkGroupChild> makeChunks()
	{
		ArrayList<MapChunkGroupChild> output = new ArrayList<MapChunkGroupChild> ();
		
		
		output.add(new MapChunkGroupChild(0, 0, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(1, 0, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(2, 0, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(3, 0, new LazyChunk(CHUNK_TILE_G02)));
		
		output.add(new MapChunkGroupChild(0, 1, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(1, 1, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(2, 1, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(3, 1, new LazyChunk(CHUNK_TILE_G02)));
		
		
		output.add(new MapChunkGroupChild(0, 2, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(1, 2, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(2, 2, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(3, 2, new LazyChunk(CHUNK_TILE_G02)));
		
		output.add(new MapChunkGroupChild(0, 3, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(1, 3, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(2, 3, new LazyChunk(CHUNK_TILE_G02)));
		output.add(new MapChunkGroupChild(3, 3, new LazyChunk(CHUNK_TILE_G02)));
		
	
		return output;
	}
	
	public static int G02 = 1 + 256;
	public static int G03 = G02+256;
	

	public static int[] CHUNK_TILE_G02 = makeBaseArray(G02);
	public static int[] CHUNK_TILE_G03 = makeBaseArray(G03);
	
	public static int[] makeBaseArray(int startIndex)
	{
		int[] data = new int[256];
		
		for(int i=0; i<data.length; i++)
		{
			data[i] = startIndex + i;
		}	
		
		return data;
		
	}
	
}
