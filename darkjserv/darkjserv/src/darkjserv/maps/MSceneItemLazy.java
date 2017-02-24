package darkjserv.maps;

import java.awt.Rectangle;

import darkjserv.GameTemplateEnums;

public class MSceneItemLazy extends BaseMapChunkNode
{
	
	public MSceneItemLazy(int tIndex, int x, int y)
	{
		this.templateId = GameTemplateEnums.T_SCENEITEM_START + tIndex;
		this.x = x;
		this.y = y;
		
		
		switch(tIndex)
		{
			//wood02
			case 1:
				this.blocks = new Rectangle[] {
						new Rectangle((x-2)*64, (y-1)*64, 256, 64)	,
						new Rectangle((x)*64, (y+1)*64, 128, 128)	
						};
				
				
				break;
			//wood03
			case 2:
				this.blocks = new Rectangle[] {
						//new Rectangle((x-2)*64, (y-1)*64, 256, 64)	,
						new Rectangle((x-2)*64, (y-1)*64, 192, 128)	
						};
				
				
				break;
				
			//desk
			case 10:
				this.blocks = new Rectangle[] {
						new Rectangle(x*64, y*64, 128, 128)	
						};
				
				break;
				
			case SceneItemOpts.WELLD02:
				this.blocks = new Rectangle[] {
						new Rectangle(x*64, y*64, 128, 128)	
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
