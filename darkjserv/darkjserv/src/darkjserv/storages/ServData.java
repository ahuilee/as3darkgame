package darkjserv.storages;

public class ServData 
{
	
	public int lastCharId;
	public int lastItemId;	
	
	
	public void save(StorageDataWriter w) throws Exception 
	{
		w.writeInt(lastCharId);
		w.writeInt(lastItemId);
	}
	
	public static ServData load(StorageDataReader rd) throws Exception
	{
		ServData data = new ServData();
		data.lastCharId = rd.readInt();
		data.lastItemId = rd.readInt();
		
		return data;
	}
	
	public String toString()
	{
		return String.format("<ServData lastCharId=%d lastItemId=%d>", lastCharId, lastItemId);
	}
	

}
