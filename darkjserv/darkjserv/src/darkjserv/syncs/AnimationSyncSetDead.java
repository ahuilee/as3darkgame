package darkjserv.syncs;

import darkjserv.IAnimationSyncSet;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.Connection;

public class AnimationSyncSetDead   implements IAnimationSyncSet
{
	public IGameObj iobj = null;
	public long startTime = 0;
	
	
	public AnimationSyncSetDead(IGameObj iobj, long startTime)
	{
		this.iobj = iobj;
		this.startTime = startTime;
		
	}

	public long getExpiryTime() {
		// TODO Auto-generated method stub
		return 0;
	}

	public ISyncDataNode getSyncNode(Connection conn) {
		// TODO Auto-generated method stub
		SyncObjDead syncDead = new SyncObjDead(iobj, startTime);
		
		//System.out.println(String.format("AnimationSyncSetDead animationEndTime=%d", animationEndTime));
		
		return syncDead;
	}

	public boolean expiryEnabled() {
		// TODO Auto-generated method stub
		return false;
	}
}
