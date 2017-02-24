package darkjserv.maps;

import java.awt.Rectangle;
import java.util.ArrayList;

import darkjserv.net.MapChunk;

public class MapChunkLeftSide1 extends MapChunk
{
	
	public  MapChunkLeftSide1()
	{
		
		
		this.tiles = new int[]
				{
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,  1, 1, 1,
		};
		
		ArrayList<IMapChunkNode> mapNodes = new ArrayList<IMapChunkNode>();
		
		//mapNodes.add(new MStoneLazy(0, 0, 0));
		int i = 0;
		for(i=0; i<5; i++)
		{
			mapNodes.add(new MFlowerLazy(31, 0,  i * 3));
		}
		
		
		//mapNodes.add(new MTreeLazy(11, 13, 3));
		//mapNodes.add(new MFlowerLazy(0, 8, 8));
		
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
