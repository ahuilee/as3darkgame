package darkjserv.maps;

import java.awt.Rectangle;

import darkjserv.GameTemplateEnums;

public class MStoneLazy extends BaseMapChunkNode
{
	
	public MStoneLazy(int tIndex, int x, int y)
	{
		this.templateId = GameTemplateEnums.T_STONE_START + tIndex;
		this.x = x;
		this.y = y;
		
		
		switch(tIndex)
		{
			case 0:
				this.blocks = new Rectangle[] {
						new Rectangle((x)*64, (y)*64, 192, 192),
						new Rectangle((x-1)*64, (y-1)*64, 64, 64),
						new Rectangle((x+2)*64, (y-2)*64, 128, 128),
						//new Rectangle((x-4)*64, (y-4)*64, 128, 128),
						new Rectangle((x)*64, (y-2)*64, 64*2, 64 * 2),
						new Rectangle((x-2)*64, (y)*64, 64 * 2, 64*2),
						};
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
