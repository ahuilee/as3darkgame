package darkjserv.syncs;


import darkjserv.Factory;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.DataWriter;

public class SyncObjStand implements ISyncDataNode, ISyncTimeNode
{
	
	public IGameObj iobj = null;
	public long startTime = 0;
	public int debugType = 0;
	
	public SyncObjStand(IGameObj iobj, long startTime, int debugType)
	{
		this.iobj = iobj;
		this.startTime = startTime;
		this.debugType = debugType;
	}

	public short getType()
	{
		
		return SyncInfoTypes.STAND;
	}

	public void saveData(DataWriter w, Factory factory) throws Exception
	{
		
		w.writeInt(iobj.getX());
		w.writeInt(iobj.getY());
		w.writeByte(iobj.getDirection());
	
		w.writeByte(debugType);
	}


	public long getStartTime() {
		// TODO Auto-generated method stub
		return startTime;
	}
	
	public String toString()
	{
		return String.format("<SyncStand startTime=%d>", startTime);
	}

}
