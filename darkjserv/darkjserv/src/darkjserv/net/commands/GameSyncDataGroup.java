package darkjserv.net.commands;

import java.util.ArrayList;
import java.util.List;

import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;

public class GameSyncDataGroup 
{
	
	public long objId = 0;
	public List<ISyncDataNode> nodes = new ArrayList<ISyncDataNode>();

}
