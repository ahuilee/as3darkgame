package darkjserv.maps;

import java.awt.Rectangle;

import darkjserv.GameTemplateEnums;

public class MTreeLazy extends BaseMapChunkNode
{
	
	public MTreeLazy(int tIndex, int x, int y)
	{
		this.templateId = GameTemplateEnums.T_TREE_START + tIndex;
		this.x = x;
		this.y = y;
		
		
		switch(tIndex)
		{
			
			case 0:

			
			
				break;
				
		}
		
		if(this.blocks == null)
		{
			this.blocks = new Rectangle[] {
					new Rectangle(x*64, y*64, 64, 64)	
					};
		}
		
		
		
	}

}
