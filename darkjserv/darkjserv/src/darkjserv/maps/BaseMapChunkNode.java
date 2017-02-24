package darkjserv.maps;

import java.awt.Rectangle;

public class BaseMapChunkNode implements IMapChunkNode
{
	
	public int templateId = 0;
	public int x = 0;
	public int y = 0;
	public Rectangle[] blocks = null;

	
	public int getTemplateId() 
	{
		// TODO Auto-generated method stub
		return templateId;
	}

	public int getX() {
		// TODO Auto-generated method stub
		return x;
	}

	public int getY() {
		// TODO Auto-generated method stub
		return y;
	}

	public Rectangle[] getBlocks() {
		// TODO Auto-generated method stub
		return blocks;
	}

	

}
