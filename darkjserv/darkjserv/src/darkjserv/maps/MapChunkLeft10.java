package darkjserv.maps;

import java.awt.Rectangle;
import java.util.ArrayList;

import darkjserv.net.MapChunk;

public class MapChunkLeft10 extends MapChunk
{
	
	public  MapChunkLeft10()
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
		
		mapNodes.add(new MStoneLazy(0, 0, 0));
		//mapNodes.add(new MTreeLazy(11, 13, 3));
		mapNodes.add(new MFlowerLazy(0, 8, 8));
		
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
