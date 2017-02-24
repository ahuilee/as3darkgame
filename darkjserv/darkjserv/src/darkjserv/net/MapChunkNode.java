package darkjserv.net;

public class MapChunkNode
{
	
	public int templateId = 0;
	public int x = 0;
	public int y = 0;
	
	public MapChunkNode(int x, int y, int templateId)
	{
		this.x = x;
		this.y = y;
		this.templateId = templateId;
		
	}
}
