package darkjserv.commandhandlers;


import java.io.DataInputStream;
import java.util.ArrayList;
import java.util.List;

import darkjserv.IAnimationSyncSet;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.items.CItemGameObjWrap;
import darkjserv.net.*;
import darkjserv.syncs.AnimationSyncSetDead;

public class GetObjInfoHandler 
{
	
	public Connection conn = null;
	
	public GetObjInfoHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		short count = rd.readShort();
		
		
		//System.out.println(String.format("%s handleGetObjInfo count=%d", this, count));
		
		ArrayList<IGameObj> objs = new ArrayList<IGameObj>();	
		
		
		for(int i=0; i<count; i++)
		{
			long objId = rd.readLong();
			IGameObj iobj = conn.server.factory.getGameObj(objId);
			objs.add(iobj);	
			/*
			if(iobj instanceof CItemGameObjWrap)
			{
				System.out.println(String.format(">>>>%s handleGetObjInfo CItem=%s", this, iobj));
			}*/
			
		}
		
		long currentTime = System.currentTimeMillis();
		
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);		
		answer.w.writeShort((short)objs.size());
		
		for(IGameObj iobj : objs)
		{
			if(iobj == null)
			{
				answer.w.writeByte(0x00);
			} else
			{			
				
				answer.w.writeByte(0x01);
				answer.w.writeLong(iobj.getObjId());
				answer.w.writeByte(iobj.getObjType());
				answer.w.writeUInt24(iobj.getTemplateId());
				answer.w.writeInt(iobj.getX());
				answer.w.writeInt(iobj.getY());
				answer.w.writeByte(iobj.getDirection());
				
				/*
				List<Byte> interactiveCodes = iobj.getInteractiveCodes();
				answer.w.writeByte(interactiveCodes.size());
				for(Byte code : interactiveCodes)
				{
					answer.w.writeByte(code);
				}	*/		
				
				
				IAnimationSyncSet syncSet = iobj.getCurrentAnimationSyncSet();
				
				if(syncSet != null)
				{
					if(syncSet instanceof AnimationSyncSetDead)
					{
						System.out.println(String.format("syncSet instanceof AnimationSyncSetDead expiry=%s", syncSet.getExpiryTime() > currentTime));
					}				
					
					
					if(!syncSet.expiryEnabled() || syncSet.getExpiryTime() > currentTime)
					{
						
						//System.out.println(String.format("%s", syncSet));
						ISyncDataNode syncNode = syncSet.getSyncNode(conn);
						conn.syncQueue.put(iobj, syncNode);
					}
				}
				
			}
		}
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
