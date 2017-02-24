package darkjserv.syncs;

import darkjserv.IAnimationSyncSet;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.Connection;

public class AnimationSyncSetAnimation  implements IAnimationSyncSet
{
	public IGameObj iobj = null;
	public short animationId = 0;
	
	public long startTime = 0;
	public long startServTick = 0;
	
	public int duration = 0;
	
	public long expiryTime = 0;
	public int debugType = 0;
	
	public AnimationSyncSetAnimation(IGameObj iobj, short animationId, long startTime, long startServTick,  int duration, long expiryTime, int debugType)
	{
		this.iobj = iobj;
		this.animationId = animationId;
		
		this.startTime = startTime;
		this.startServTick = startServTick;
		this.duration = duration;
		
		
		
		this.expiryTime = expiryTime;
		this.debugType = debugType;
	}

	public long getExpiryTime() {
		// TODO Auto-generated method stub
		return expiryTime;
	}

	public ISyncDataNode getSyncNode(Connection conn) {
		// TODO Auto-generated method stub
		SyncAnimation syncNode = new SyncAnimation(iobj, animationId, startTime, startServTick, duration, debugType);
		
		//System.out.println(String.format("AnimationSyncSetDead animationEndTime=%d", animationEndTime));
		
		return syncNode;
	}

	public boolean expiryEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}
