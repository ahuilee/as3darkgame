package darkjserv.net.commands;

import java.io.ByteArrayOutputStream;
import java.util.List;


import darkjserv.Factory;
import darkjserv.ISyncDataNode;
import darkjserv.net.CommandCode;
import darkjserv.net.DataWriter;
import darkjserv.net.ICommand;
import darkjserv.net.ICommandCallback;

public class GameSyncDataCommand implements ICommand
{
	
	
	public List<GameSyncDataGroup> groups =null;
	
	public ICommandCallback callback = null;
	public Factory factory = null;
	
	public GameSyncDataCommand(List<GameSyncDataGroup> groups, Factory factory)
	{
		this.groups = groups;
		this.factory = factory;
	}

	public int getCommandCode() {
		
		return CommandCode.GAME_SYNC_DATA;
	}

	public byte[] getCommandBytes() throws Exception
	{
		
		
		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		DataWriter w = new DataWriter(stream);
		
		w.writeShort(groups.size());
		
		for(GameSyncDataGroup group : groups)
		{
			
			w.writeLong(group.objId);
			
			w.writeShort(group.nodes.size());
			
			for(ISyncDataNode node : group.nodes)
			{
				w.writeShort(node.getType());
				node.saveData(w, factory);
			}
		}
		
		return stream.toByteArray();
	}

	public ICommandCallback getCallback() {
		// TODO Auto-generated method stub
		return callback;
	}
	
	

}
