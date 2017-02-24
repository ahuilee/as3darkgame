package darkjserv.storages;

import java.util.ArrayList;
import java.util.HashMap;

public class UserAccountList
{

	public HashMap<String, UserAccountData> getAccountDataByUserName = null;
	
	public void save(StorageDataWriter w) throws Exception 
	{
		int count = getAccountDataByUserName.size();
		
		w.writeInt(count);
		
		for(UserAccountData act : getAccountDataByUserName.values())
		{
			w.writeHStrUTF(act.username);
			
			int charPksLen = act.charPks.size() & 0xff;
			w.writeByte(charPksLen);
			
			for(int i=0; i<charPksLen; i++)
			{
				w.writeInt(act.charPks.get(i));
			}
			
		}
		
		w.flush();
		
		System.out.println("UserAccountList Save success.");
	}
	
	public static UserAccountList load(StorageDataReader rd) throws Exception
	{
		UserAccountList list = new UserAccountList();
		list.getAccountDataByUserName = new HashMap<String, UserAccountData>();
		

		int count = rd.readInt();
		
		for(int i=0; i<count; i++)
		{
			UserAccountData act = new UserAccountData();
			act.charPks = new ArrayList<Integer>();
			
			act.username = rd.readHStrUTF();
			byte charCount = rd.readByte();
			
			for(int j=0; j<charCount; j++)
			{
				int charId = rd.readInt();
				
				System.out.println(String.format("%s LoadCharId=%d", act, charId));
				
				act.charPks.add(charId);
			}	
			
			list.getAccountDataByUserName.put(act.username, act);
			
		}			
		

		
		System.out.println("Load UserAccountList success.");
		
		return list;		
	}

	
	public String toString()
	{
		return String.format("<UserAccountList %d>", getAccountDataByUserName.size());
	}
	
}