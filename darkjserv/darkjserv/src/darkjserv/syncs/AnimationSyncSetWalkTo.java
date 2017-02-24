package darkjserv.syncs;


import darkjserv.IAnimationSyncSet;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.Connection;

public class AnimationSyncSetWalkTo implements IAnimationSyncSet
{
	
	
	
	public IGameObj iobj = null;
	public int x1 = 0;
	public int y1 = 0;
	public int x2 = 0;
	public int y2 = 0;
	
	public long startTime = 0;
	public long startServTicks = 0;
	public int duration = 0;
	public long expiryTime = 0;
	
	public AnimationSyncSetWalkTo(IGameObj iobj, int x1, int y1, int x2, int y2, long startTime, long startServTicks, int duration, long expiryTime)
	{
		this.iobj = iobj;
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
		this.startTime =  startTime;
		this.startServTicks = startServTicks;
		this.duration = duration;
		this.expiryTime = expiryTime;
	}
	
	

	public long getExpiryTime() 
	{
		// TODO Auto-generated method stub
		return expiryTime;
	}

	public ISyncDataNode getSyncNode(Connection conn) 
	{
		//int x1 = iobj.getX();
		//int y1 = iobj.getY();
		byte direction = iobj.getDirection();
		
		//int duration = (int)( endTime - System.currentTimeMillis());
		
		//System.out.println(String.format("getSyncNode duration=%d", duration));
		
		//Calendar endTimeCalendar = conn.makeEndTime(duration);
		
		SyncObjWalkTo syncNode = new SyncObjWalkTo(
				x1, y1, direction, x2, y2, 
				startTime, startServTicks, duration, 0);
		
		return syncNode;
	}
	
	public String toString()
	{
		return String.format("<AnimationSyncSetWalkTo x2=%d y2=%d startServTicks=%d>", x2, y2, startServTicks);
	}



	public boolean expiryEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
