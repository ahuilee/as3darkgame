package darkjserv.commandhandlers;


import java.awt.Point;
import java.io.DataInputStream;
import java.util.ArrayList;
import java.util.List;

import darkjserv.AssetNPCLoadItem;
import darkjserv.GameAssetEnums;
import darkjserv.GameAssetFactory;
import darkjserv.GameTemplateEnums;
import darkjserv.IAnimationSyncSet;
import darkjserv.IAssetLoadItem;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.Utils;
import darkjserv.maps.IMapData;
import darkjserv.net.*;
import darkjserv.storages.StorageFactory;
import darkjserv.storages.UserAccountData;
import darkjserv.syncs.AnimationSyncSetDead;

public class GameAssetGetInfoHandler 
{
	
	public Connection conn = null;
	
	public GameAssetGetInfoHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	public void handle(int ask, DataReader rd) throws Exception
	{
		GamePlayer player = conn.player;
		
		GameAssetFactory assetFactory = GameAssetFactory.getInstance();
		
		int count = rd.readUInt16();
		
		ArrayList<IAssetLoadItem> items = new ArrayList<IAssetLoadItem>();
		
		for(int i=0; i<count; i++)
		{
			int assetPk = rd.readUInt16();
			
		
			
			IAssetLoadItem  item = assetFactory.getAssetById(assetPk);
			
			System.out.println(String.format("GetAssetInfo %d item=%s", assetPk, item));
			
			if(item != null)
			{
				items.add(item);
			}
			
		}
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		answer.w.writeUInt16(items.size());
		
		for(IAssetLoadItem item : items)
		{
			answer.w.writeUInt16(item.getAssetId());
			answer.w.writeByte(item.getType());
			answer.w.writeBStrUTF(item.getURL());
		}
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
}
