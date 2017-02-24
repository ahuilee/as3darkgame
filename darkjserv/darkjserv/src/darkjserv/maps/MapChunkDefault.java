package darkjserv.maps;

import java.awt.Rectangle;
import java.util.ArrayList;

import darkjserv.net.MapChunk;

public class MapChunkDefault extends MapChunk
{
	
	public  MapChunkDefault()
	{
	
		/*
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
				
				};*/
		
		int[] tiles = new int[256];
		for(int i=0; i<256; i++)

		{
			tiles[i] = i +1;
		}
		
		this.tiles = tiles;

		
		ArrayList<IMapChunkNode> mapNodes = new ArrayList<IMapChunkNode>();
	
		
		
		//mapNodes.add(new MSceneItemLazy(SceneItemOpts.DESK01, 5, 7));
		//mapNodes.add(new MSceneItemLazy(SceneItemOpts.WOOD03, 0, 15));
		//mapNodes.add(new MSceneItemLazy(SceneItemOpts.WOOD02, 10, 5));
		//mapNodes.add(new MSceneItemLazy(SceneItemOpts.WOOD01, 10, 10));
		
		
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
