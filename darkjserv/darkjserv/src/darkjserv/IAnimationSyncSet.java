package darkjserv;

import darkjserv.net.Connection;



public interface IAnimationSyncSet 
{	
	public boolean expiryEnabled();
	public long getExpiryTime();
	public ISyncDataNode getSyncNode(Connection conn);
	// = null;

}
