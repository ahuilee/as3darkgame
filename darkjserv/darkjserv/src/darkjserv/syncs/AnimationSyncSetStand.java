package darkjserv.syncs;

import darkjserv.IAnimationSyncSet;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.Connection;

public class AnimationSyncSetStand   implements IAnimationSyncSet
{
	public IGameObj iobj = null;
	
	public long startTime = 0;
	public int debugType = 0;
	
	public AnimationSyncSetStand(IGameObj iobj, long startTime, int debugType)
	{
		this.iobj = iobj;
		this.startTime = startTime;
		this.debugType = debugType;
		
	}

	public long getExpiryTime() 
	{
		// TODO Auto-generated method stub
		return 0;
	}

	public ISyncDataNode getSyncNode(Connection conn) {
		// TODO Auto-generated method stub
		SyncObjStand syncNode = new SyncObjStand(iobj, startTime, debugType);
		
		//System.out.println(String.format("AnimationSyncSetDead animationEndTime=%d", animationEndTime));
		
		return syncNode;
	}

	public boolean expiryEnabled() {
		// TODO Auto-generated method stub
		return false;
	}
}
