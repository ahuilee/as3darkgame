package darkjserv.syncs;

import darkjserv.Factory;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.DataWriter;

public class SyncObjDead  implements ISyncDataNode, ISyncTimeNode
{
	
	public IGameObj iobj = null;
	public long startTime = 0;
	//public int duration = 0;
	
	public SyncObjDead(IGameObj iobj, long startTime)
	{
		this.iobj = iobj;
		this.startTime = startTime;
		
	}

	public short getType() 
	{
		
		return SyncInfoTypes.OBJ_DEAD;
	}

	public void saveData(DataWriter w, Factory factory) throws Exception 
	{
		
		long startTicks = startTime - factory.gameStartTime;		
		
		System.out.println(String.format("SyncObjDead=%d", startTicks));;
		
		w.writeUInt48(startTicks);
		w.writeInt(iobj.getX());
		w.writeInt(iobj.getY());
		w.writeByte(iobj.getDirection());
		
	}

	public long getStartTime() {
		// TODO Auto-generated method stub
		return startTime;
	}

}
