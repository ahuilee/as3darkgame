package darkjserv.commandhandlers;


import java.util.ArrayList;
import darkjserv.GameAssetFactory;
import darkjserv.IAssetLoadItem;
import darkjserv.net.*;

public class GameAssetGetInfoHandler 
{
	
	public Connection conn = null;
	
	public GameAssetGetInfoHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	public void handle(int ask, DataReader rd) throws Exception
	{	
		
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
