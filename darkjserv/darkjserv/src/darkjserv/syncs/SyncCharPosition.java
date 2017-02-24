package darkjserv.syncs;


import darkjserv.Factory;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.DataWriter;

public class SyncCharPosition implements ISyncDataNode
{
	
	public IGameObj iobj = null;
	
	public SyncCharPosition(IGameObj iobj)
	{
		this.iobj = iobj;
	}

	public short getType()
	{
		
		return SyncInfoTypes.CHARACTER_POSITION;
	}

	public void saveData(DataWriter w, Factory factory) throws Exception
	{
		
		w.writeInt(iobj.getX());
		w.writeInt(iobj.getY());
		w.writeByte(iobj.getDirection());
		
	}

}
