package darkjserv.syncs;


import darkjserv.Factory;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.DataWriter;

public class SyncObjHurt implements ISyncDataNode, ISyncTimeNode
{
	
	public IGameObj iobj = null;
	public long startTime = 0;
	
	public SyncObjHurt(IGameObj iobj, long startTime)
	{
		this.iobj = iobj;
		this.startTime = startTime;
	}

	public short getType()
	{
		
		return SyncInfoTypes.HURT;
	}

	public void saveData(DataWriter w, Factory factory) throws Exception
	{
		long startTicks = startTime - factory.gameStartTime;		
		
		w.writeUInt48(startTicks);
		
		
	}

	public long getStartTime() {
		// TODO Auto-generated method stub
		return startTime;
	}

}
