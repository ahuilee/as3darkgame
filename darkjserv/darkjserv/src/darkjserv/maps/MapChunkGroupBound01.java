package darkjserv.maps;

import java.util.ArrayList;
import java.util.List;



public class MapChunkGroupBound01 {

	
	
	public List<MapChunkGroupChild> makeChunks()
	{
		ArrayList<MapChunkGroupChild> output = new ArrayList<MapChunkGroupChild> ();
		
		
		output.add(new MapChunkGroupChild(0, 0, new LazyChunk(CHUNK_TILE_BONE02)));
		output.add(new MapChunkGroupChild(1, 0, new LazyChunk(CHUNK_TILE_BONE03)));
		output.add(new MapChunkGroupChild(2, 0, new LazyChunk(CHUNK_TILE_BONE04)));
		
		

		output.add(new MapChunkGroupChild(0, 1, new LazyChunk(CHUNK_TILE_BONE04)));
	
		return output;
	}
	
	public static int B01 = 1024;
	public static int B02 = B01+256+1;
	public static int B03 = B02+256+1;
	public static int B04 = B03+256+1;
	
	//¨Fºz°©ÀY
	public static int[] CHUNK_TILE_BONE02 = makeBaseBone(B02);
	public static int[] CHUNK_TILE_BONE03 = makeBaseBone(B03);
	public static int[] CHUNK_TILE_BONE04 = makeBaseBone(B04);
	
	public static int[] makeBaseBone(int startIndex)
	{
		int[] data = new int[256];
		
		for(int i=0; i<data.length; i++)
		{
			data[i] = startIndex + i;
		}	
		
		return data;
		
	}
	
}
