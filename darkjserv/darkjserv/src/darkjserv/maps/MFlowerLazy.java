package darkjserv.maps;

import java.awt.Rectangle;

import darkjserv.GameTemplateEnums;

public class MFlowerLazy extends BaseMapChunkNode
{
	
	public MFlowerLazy(int tIndex, int x, int y)
	{
		this.templateId = GameTemplateEnums.T_FLOWER_START + tIndex;
		this.x = x;
		this.y = y;
		
		
		switch(tIndex)
		{
			case 8:
				this.blocks = new Rectangle[] {
						//new Rectangle((x-3)*64, (y-1)*64, 128, 128),
						new Rectangle((x-4)*64, (y-5)*64, 448, 384),
						//new Rectangle((x+1)*64, (y-1)*64, 128, 128),
						};
				
				break;
				
			case 31:
				this.blocks = new Rectangle[] {
						
						new Rectangle((x-2)*64, (y-1)*64, 256, 256),
						};
				
				break;
		
			default:
					this.blocks = new Rectangle[] {
					new Rectangle(x*64, y*64, 64, 64)	
					};
			
			break;
				
		}
		
		
		
	}

}
