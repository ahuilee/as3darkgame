package darkjserv.syncs;


import darkjserv.Factory;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.DataWriter;

public class SyncAnimation implements ISyncDataNode, ISyncTimeNode
{
	public IGameObj iobj = null;
	public short animationId = 0;
	
	public long startTime = 0;
	public long startServTicks = 0;
	public int duration = 0;
	public int debugType = 0;
	
	public SyncAnimation(IGameObj iobj, short animationId, long startTime, long startServTicks, int duration, int debugType)
	{
		this.iobj = iobj;
		this.animationId = animationId;
		
		this.startTime = startTime;
		this.startServTicks = startServTicks;
		
		this.duration = duration;
		this.debugType = debugType;
	}

	public short getType()
	{
		
		return SyncInfoTypes.ANIMATION;
	}

	public void saveData(DataWriter w, Factory factory) throws Exception
	{
		
		w.writeByte(iobj.getDirection());
		w.writeShort(animationId);

		w.writeUInt48(startServTicks);
		w.writeUInt24(duration);
		
	
		
		w.writeByte((byte)debugType);
	}

	public long getStartTime() {
		// TODO Auto-generated method stub
		return startTime;
	}
	
	
	public String toString()
	{
		
		return String.format("<SyncAnimation aId=%d startServTicks=%d>", animationId, startServTicks);
	}
	
}
