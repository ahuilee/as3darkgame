package darkjserv.maps;

import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import darkjserv.net.MapChunk;

public class MapChunkHomeGroup 
{
	
	
	public MapChunkHomeGroup()
	{
		
		
	}
	
	
	
	
	public List<MapChunkGroupChild> makeChunks()
	{
		ArrayList<MapChunkGroupChild> output = new ArrayList<MapChunkGroupChild> ();
		
		
		output.add(new MapChunkGroupChild(0, 0, new LazyChunk(CHUNK_TILE_BRICKN01)));
		output.add(new MapChunkGroupChild(1, 0, new LazyChunk(CHUNK_TILE_BRICKN01)));
		output.add(new MapChunkGroupChild(2, 0, new LazyChunk(CHUNK_TILE_BRICKN01)));
		output.add(new MapChunkGroupChild(3, 0, new LazyChunk(CHUNK_TILE_BRICKN01)));
		
		output.add(new MapChunkGroupChild(0, 1, new LazyChunk(CHUNK_TILE_BRICKN02)));
		output.add(new MapChunkGroupChild(1, 1, new LazyChunk(CHUNK_TILE_BRICKN05)));
		output.add(new MapChunkGroupChild(2, 1, new LazyChunk(CHUNK_TILE_BRICKN06)));
		output.add(new MapChunkGroupChild(3, 1, new LazyChunk(CHUNK_TILE_BRICKN07)));
		
		output.add(new MapChunkGroupChild(0, 2, new LazyChunk(CHUNK_TILE_BRICKN03)));
	
		
		
		
		
		return output;		
	}
	
	
	
	public static int[] CHUNK_TILE_BASE01 = new int[]
	{
		1,   2,  3,  4, 5,   6,  7,  8,  1,  2,   3,  4,  5,  6,  7,  8,
		9,  10, 11, 12, 13, 14, 15, 16,  9,  10, 11, 12, 13, 14, 15, 16,
		17, 18, 19, 20, 21, 22, 23, 24,  17, 18, 19, 20, 21, 22, 23, 24,
		25, 26, 27, 28, 29, 30, 31, 32,  25, 26, 27, 28, 29, 30, 31, 32,
		33, 34, 35, 36, 37, 38, 39, 40,  33, 34, 35, 36, 37, 38, 39, 40,
		41, 42, 43, 44, 45, 46, 47, 48,  41, 42, 43, 44, 45, 46, 47, 48,
		49, 50, 51, 52, 53, 54, 55, 56,  49, 50, 51, 52, 53, 54, 55, 56,
		57, 58, 59, 60, 61, 62, 63, 64,  57, 58, 59, 60, 61, 62, 63, 64,		
		
		1,   2,  3,  4, 5,   6,  7,  8,  1,   2, 3,   4,  5,  6,  7,  8,
		9,  10, 11, 12, 13, 14, 15, 16,  9,  10, 11, 12, 13, 14, 15, 16,
		17, 18, 19, 20, 21, 22, 23, 24,  17, 18, 19, 20, 21, 22, 23, 24,
		25, 26, 27, 28, 29, 30, 31, 32,  25, 26, 27, 28, 29, 30, 31, 32,
		33, 34, 35, 36, 37, 38, 39, 40,  33, 34, 35, 36, 37, 38, 39, 40,
		41, 42, 43, 44, 45, 46, 47, 48,  41, 42, 43, 44, 45, 46, 47, 48,
		49, 50, 51, 52, 53, 54, 55, 56,  49, 50, 51, 52, 53, 54, 55, 56,
		57, 58, 59, 60, 61, 62, 63, 64,  57, 58, 59, 60, 61, 62, 63, 64,
	};
	
	public static int[] CHUNK_TILE_GREEN01 = cloneAndAppend(CHUNK_TILE_BASE01, 0);
	public static int[] CHUNK_TILE_BRICKN01 = cloneAndAppend(CHUNK_TILE_BASE01, 64*1);
	public static int[] CHUNK_TILE_BRICKN02 = cloneAndAppend(CHUNK_TILE_BASE01, 64*2);
	public static int[] CHUNK_TILE_BRICKN03 = cloneAndAppend(CHUNK_TILE_BASE01, 64*3);
	public static int[] CHUNK_TILE_BRICKN04 = cloneAndAppend(CHUNK_TILE_BASE01, 64*4);
	public static int[] CHUNK_TILE_BRICKN05 = cloneAndAppend(CHUNK_TILE_BASE01, 64*5);
	public static int[] CHUNK_TILE_BRICKN06 = cloneAndAppend(CHUNK_TILE_BASE01, 64*6);
	public static int[] CHUNK_TILE_BRICKN07 = cloneAndAppend(CHUNK_TILE_BASE01, 64*7);
	
	
	

	
	
	static int[] cloneAndAppend(int[] src, int count)	
	{
		int[] data = Arrays.copyOfRange(src, 0, src.length);
		for(int y=0; y<16; y++)
		{
			for(int x=0; x<16; x++)
			{
				data[y*16+x] += count;
			}
		}
	
	
		return data;
	}
	
	
	
	
	
	public class MapChunkHome00 extends MapChunk
	{
		
		public  MapChunkHome00()
		{
			
		
			
			this.tiles = new int[]
			{
					1,   2,  3,  4, 5,   6,  7, 8,   1, 2, 3, 4, 5, 6, 7, 8,
					9,  10, 11, 12, 13, 14, 15, 16,  9, 10, 11, 12, 13, 14, 15, 16,
					17, 18, 19, 20, 21, 22, 23, 24,  17, 18, 19, 20, 21, 22, 23, 24,
					25, 26, 27, 28, 29, 30, 31, 32,  25, 26, 27, 28, 29, 30, 31, 32,
					33, 34, 35, 36, 37, 38, 39, 40,  33, 34, 35, 36, 37, 38, 39, 40,
					41, 42, 43, 44, 45, 46, 47, 48,  41, 42, 43, 44, 45, 46, 47, 48,
					49, 50, 51, 52, 53, 54, 55, 56,  49, 50, 51, 52, 53, 54, 55, 56,
					57, 58, 59, 60, 61, 62, 63, 64,  57, 58, 59, 60, 61, 62, 63, 64,
					
					
					1,   2,  3,  4, 5,   6,  7, 8,   1, 2, 3, 4, 5, 6, 7, 8,
					9,  10, 11, 12, 13, 14, 15, 16,  9, 10, 11, 12, 13, 14, 15, 16,
					17, 18, 19, 20, 21, 22, 23, 24,  17, 18, 19, 20, 21, 22, 23, 24,
					25, 26, 27, 28, 29, 30, 31, 32,  25, 26, 27, 28, 29, 30, 31, 32,
					33, 34, 35, 36, 37, 38, 39, 40,  33, 34, 35, 36, 37, 38, 39, 40,
					41, 42, 43, 44, 45, 46, 47, 48,  41, 42, 43, 44, 45, 46, 47, 48,
					49, 50, 51, 52, 53, 54, 55, 56,  49, 50, 51, 52, 53, 54, 55, 56,
					57, 58, 59, 60, 61, 62, 63, 64,  57, 58, 59, 60, 61, 62, 63, 64,
					
			};
			
			for(int y=0; y<16; y++)
			{
				for(int x=0; x<16; x++)
				{
					int idx = y*16 + x;
					this.tiles[idx] += 64;
				}
			}
			

			
			ArrayList<IMapChunkNode> mapNodes = new ArrayList<IMapChunkNode>();
			
			
			mapNodes.add(new MSceneItemLazy(SceneItemOpts.WELLD02, 8, 8));
			mapNodes.add(new MStoneLazy(0, 0, 0));
			//mapNodes.add(new MTreeLazy(11, 13, 3));
			mapNodes.add(new MFlowerLazy(0, 0, 8));
			
			this.nodes = mapNodes.toArray(new IMapChunkNode[mapNodes.size()]);
			
			ArrayList<Rectangle> blockRects = new ArrayList<Rectangle>();
			
			for(IMapChunkNode node : mapNodes)
			{
				Rectangle[] blocks = node.getBlocks();
				
				//System.out.println(String.format("blocks %s", blocks));
				
				if(blocks != null)
				{
					for(Rectangle block : blocks) {
						blockRects.add(block);
					}
				}
			}
			
			this.blocks = blockRects.toArray(new Rectangle[blockRects.size()]);
			
		}

	}
	
	

}
