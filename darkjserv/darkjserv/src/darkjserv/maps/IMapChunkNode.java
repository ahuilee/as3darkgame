package darkjserv.maps;

import java.awt.Rectangle;

public interface IMapChunkNode
{
	int getTemplateId();
	int getX();
	int getY();	
	Rectangle[] getBlocks();
	
}
