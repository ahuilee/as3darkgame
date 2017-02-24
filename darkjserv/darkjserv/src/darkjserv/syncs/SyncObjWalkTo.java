package darkjserv.syncs;


import darkjserv.Factory;
import darkjserv.ISyncDataNode;
import darkjserv.net.DataWriter;

public class SyncObjWalkTo implements ISyncDataNode, ISyncTimeNode
{
	
	public int x1 = 0;
	public int y1 = 0;
	public byte direction1 = 0;
	
	
	public int x2 = 0;
	public int y2 = 0;
	
	public long startTime = 0;
	public long startServTicks = 0;
	public int duration = 0;
	public int debugType = 0;
	
	public SyncObjWalkTo(int x1, int y1, byte direction1, int x2, int y2, long startTime, long startServTicks, int duration, int debugType)
	{
		this.x1 = x1;
		this.y1 = y1;
		this.direction1 = direction1;
		
		this.x2 = x2;
		this.y2 = y2;
		
		this.startTime = startTime;
		this.startServTicks = startServTicks;
		this.duration = duration;
		this.debugType = debugType;
	}

	public short getType() 
	{
		// TODO Auto-generated method stub
		return SyncInfoTypes.WALK_TO;
	}

	public void saveData(DataWriter w, Factory factory) throws Exception
	{
		w.writeInt(x1);
		w.writeInt(y1);
		w.writeByte(direction1);
		
		w.writeInt(x2);
		w.writeInt(y2);
		
	
		
		//System.out.println(String.format("endTicks=%d", endTicks));
		w.writeUInt48(startServTicks);
		w.writeUInt24(duration);
		
		w.writeByte((byte)debugType);
		
	}
	
	public String toString()
	{
		return String.format("<SyncObjWalkTo startServTicks=%d duration=%d>", startServTicks, duration);
	}

	

	public long getStartTime() {
		// TODO Auto-generated method stub
		return startTime;
	}

}
