package darkjserv.storages;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;


import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.Queue;





import darkjserv.CSkillEnums;
import darkjserv.IShortcutItem;
import darkjserv.items.CItemEnums;
import darkjserv.items.ICItem;
import darkjserv.items.SimpleEquipment;
import darkjserv.items.SimpleItem;
import darkjserv.net.GamePlayer;

public class StorageFactory 
{
	
	private static StorageFactory _instance = null;
	
	public static StorageFactory getInstance()
	{
		if(_instance == null)
		{
			_instance = new StorageFactory();
		}
		
		return _instance;		
	}
	
	private Object _syncObj = new Object();
	private UserAccountList _userAccountList = null;
	
	private UpdateWorker _updateWorker = null;
	
	
	private HashMap<Integer, UserCharacterInfo> _getCharInfoById = null;
	
	public StorageFactory()
	{
		
		_getCharInfoById = new HashMap<Integer, UserCharacterInfo>();
		
	}
	
	public void load()
	{
		ServData servData = getServData();
		UserAccountList actList = getUserAccountList();
		
		System.out.println(String.format("Storage load %s", servData));
		System.out.println(String.format("Storage load %s", actList));
	}
	
	public void start()
	{
		if(_updateWorker == null)
		{
			_updateWorker = new UpdateWorker(this);	
			_updateWorker.start();
		}
	}
	
	
	public int getLastCharacterId()
	{
		return getServData().lastCharId;
	}
	
	public int getLastItemId()
	{
		return getServData().lastItemId;
	}
	
	private ServData _servData = null;
	
	public ServData getServData()
	{
		if(_servData == null)
		{
			
			_servData = _loadServData();
			
		}
		
		return _servData;
	}
	
	public void saveLastCharacterId(int charId)
	{
		ServData data =  getServData();
		data.lastCharId = charId;
		_updateWorker.put(new ServDataUpdate(data));
		
	}
	
	public void saveLastItemId(int itemId)
	{
		ServData data =  getServData();
		data.lastItemId = itemId;
		_updateWorker.put(new ServDataUpdate(data));		
	}
	
	public void saveUserAccountList()
	{
		if(_userAccountList != null)
		{
			_updateWorker.put(new UserAccountListUpdate(_userAccountList));	
		}
	}
	
	
	public void saveCharInfo(UserCharacterInfo info)
	{
		_updateWorker.put(new PlayerUpdate(info));
	}
	
	public void savePlayer(GamePlayer player)  throws Exception
	{
		UserCharacterInfo info = getCharacterInfoById(player.charId);
		
		info.mapId = player.getMapId();
		info.x = player.getX();
		info.y = player.getY();
		
		info.maxHp = player.getMaxHp();
		info.maxMp = player.getMaxMp();
		info.hp = player.getHp();
		info.mp = player.getMp();
		info.exp = player.getCurExp();
		
		
		info.templateId = player.templateId;
		info.charStr = player.charStr;
		info.charInt = player.charInt;
		info.charDex = player.charDex;
		info.charCon = player.charCon;
		
		
		saveCharInfo(info);
	}
	
	
	public void addCharItem(int charId, ICItem item) throws Exception
	{
		UserCharacterInfo info = getCharacterInfoById(charId);
		
		
		
		info.getItemById.put(item.getItemId(), item);
		
		saveCharInfo(info);
		
	}
	
	

	public void removeCharItem(int charId, int itemId) throws Exception
	{
		UserCharacterInfo info = getCharacterInfoById(charId);
		
		if(info != null && info.getItemById == null)
		{
			 info.getItemById.remove(itemId);
			 
			 saveCharInfo(info);		
		}
		
		
	}
	
	
	public List<ICharShortcutItem> getCharShortcutItems(int charId) throws Exception
	{
		UserCharacterInfo info = getCharacterInfoById(charId);
		
		System.out.println(String.format("getCharShortcutItems %d",  info.shortcutMap.size()));
		
		ArrayList<ICharShortcutItem> rs = new ArrayList<ICharShortcutItem>();
		
		for(Entry<Integer, ICharShortcutItem> entry : info.shortcutMap.entrySet())
		{
			ICharShortcutItem value =  entry.getValue();
			rs.add(value);
		}
		
		return rs;
	}
	
	public void setCharShortcutItem(int charId, int idx, byte type, int id) throws Exception
	{
		UserCharacterInfo info = getCharacterInfoById(charId);
		
		if(info != null)
		{
			if(type == 0x01)
			{
				info.shortcutMap.put(idx, new CharShortcutItem(idx, type, id, 0));
			} else if(type == 0x02)
			{
				info.shortcutMap.put(idx, new CharShortcutItem(idx, type, 0, id));
			}
		}
		
		
	}
	
	public List<ICItem> getCharAllItems(int charId) throws Exception
	{
		UserCharacterInfo info = getCharacterInfoById(charId);
		
		ArrayList<ICItem> items = new ArrayList<ICItem> ();
		
		if(info.getItemById == null)
		{
			info.getItemById = new HashMap<Integer, ICItem>();
			
		}
		
		items.addAll(info.getItemById.values());
		
		return items;	
	}
	
	static String makeStorageKeyByCharId(int charId)
	{
		return String.format("char_%d", charId);
	}
	
	
	public UserCharacterInfo getCharacterInfoById(int charId) throws Exception
	{
		synchronized(_syncObj)
		{
			UserCharacterInfo info = _getCharInfoById.getOrDefault(charId, null);			
			
			if(info == null)
			{
				
				info = _loadCharInfoFromStorage(charId);
				if(info != null)
				{
					_getCharInfoById.put(charId, info);
				}
				
			}
			
			
			return info;
		}
	}
	
	public UserCharacterInfo createCharacter(UserAccountData userAccount) throws Exception
	{
		synchronized(_syncObj)
		{
			//UserCharacterList charList = getCharList();
			
			int lastCharId = getLastCharacterId();
			
			int charId = ++lastCharId;
			
			
			
			UserCharacterInfo info = new UserCharacterInfo();
			info.charId = charId;
			info.getItemById = new HashMap<Integer, ICItem>();
			info.shortcutMap = UserCharacterInfo.makeNewCharShortcutList();
			
			_getCharInfoById.put(charId, info);
			
			userAccount.charPks.add(charId);		
			
			saveLastCharacterId(charId);
			saveCharInfo(info);		
			saveUserAccountList();
			
			System.out.println(String.format("createCharacter %s", info));
			
			
			return info;
		
		}
	}
	
	
	private UserAccountList getUserAccountList()
	{
		synchronized(_syncObj)
		{
			if(_userAccountList == null)
			{
				_userAccountList = _loadAccountListFromStorage();				
			}
			
			return _userAccountList;
		}
	}
	
	
	public UserAccountData getOrCreateUserAccountData(String username) throws Exception
	{
		synchronized(_syncObj)
		{
			
			
			UserAccountList actList = getUserAccountList();
			
			UserAccountData act = actList.getAccountDataByUserName.getOrDefault(username, null);
			
			if(act == null)
			{
				act = new UserAccountData();
				act.username = username;
				
				actList.getAccountDataByUserName.put(username, act);
				
				saveUserAccountList();
				//_updateWorker.put(new UserAccountListUpdate(_userAccountList));
				
			}
			
			return act;
			
		}
		
	}
	
	
	public static File getServDataRoot() throws Exception
	{
		String root = new File(".").getCanonicalPath();
		
		return new File(root, "gameserv");
	}
	
	public static File getServDataFile() throws Exception
	{
		File file = new File(getServDataRoot(), "serv.dat");
		
		return file;
	}	
	
	
	
	
	
	private ServData _loadServData()
	{
		ServData servData = null;
		
		try
		{ 
			InputStream in = _getStorageInputStreamByKey(SK_SERVDATA);
			
			if(in != null)
			{
				StorageDataReader rd = new StorageDataReader(in);	
				
				
				
				servData = ServData.load(rd);
			}			
			
		} catch(Exception ex)
		{
			
			
			ByteArrayOutputStream s = new ByteArrayOutputStream();
			ex.printStackTrace(new PrintStream(s));
			
			System.out.println(String.format("_loadCharList %s", s.toString()));
		}
		
		if(servData == null)
		{
			servData = new ServData();
		}
	
		
		
		return servData;
	}
	
	
	
	


	public static final String SK_USER_ACTLIST = "accounts";
	public static final String SK_SERVDATA = "serv";
	
	private UserCharacterInfo _loadCharInfoFromStorage(int charId)
	{
		
		try
		{ 
			
			String key = makeStorageKeyByCharId(charId);
			
			InputStream in = _getStorageInputStreamByKey(key);
			
			if(in != null)
			{
				StorageDataReader rd = new StorageDataReader(in);	
				
				UserCharacterInfo info = UserCharacterInfo.load(rd);
				
				
				return info;
			}			
			
		} catch(Exception ex)
		{
		
		}
		
		
		return null;	
		
	}
	
	
	
	
	private UserAccountList _loadAccountListFromStorage()
	{
		UserAccountList list = null;
		
		try
		{ 
			
			InputStream in = _getStorageInputStreamByKey(SK_USER_ACTLIST);
			
			
			//System.out.println(String.format("_loadAccountListFromStorage %s", in));
			
			if(in != null)
			{
				StorageDataReader rd = new StorageDataReader(in);			
		
				list = UserAccountList.load(rd);
				
			}
			
			
		} catch(Exception ex)
		{
			ByteArrayOutputStream s = new ByteArrayOutputStream();
			ex.printStackTrace(new PrintStream(s));
			
			System.out.println(String.format("_loadAccountList %s", s.toString()));
		}
		

		if(list == null)
		{
			list = new UserAccountList();
			list.getAccountDataByUserName = new HashMap<String, UserAccountData>();
		}
		
		return list;
	}
	
	
	
	
	
	interface IStorageUpdate
	{
		String getKey();
		
		void save(StorageDataWriter w) throws Exception;
		
	}
	

	class ServDataUpdate implements IStorageUpdate
	{
		
		public ServData servData = null;
		
		public ServDataUpdate(ServData servData)
		{
			this.servData = servData;
			
		}

		public String getKey() {
			// TODO Auto-generated method stub
			return SK_SERVDATA;
		}

		public void save(StorageDataWriter w) throws Exception 
		{
			servData.save(w);
			
		}
		
		public String toString()
		{
			return String.format("<ServDataUpdate %s>", servData);
		}
	}
	
	class PlayerUpdate implements IStorageUpdate
	{
		
		public UserCharacterInfo info = null;
		
		public PlayerUpdate(UserCharacterInfo info)
		{
		
			this.info = info;
		}

		public String getKey() 
		{			
			return makeStorageKeyByCharId(info.charId); 
		}

		public void save(StorageDataWriter w) throws Exception 
		{
			
			info.save(w);
			
			
		}
		
		public String toString()
		{
			return String.format("<PlayerUpdate charId=%d>", info.charId);
		}
		
	}

	class UserAccountListUpdate implements IStorageUpdate
	{
		
		public UserAccountList list;
		
		public UserAccountListUpdate(UserAccountList list)
		{
			this.list = list;
		}

		public String getKey() {
			// TODO Auto-generated method stub
			return SK_USER_ACTLIST;
		}

		public void save(StorageDataWriter w) throws Exception
		{
			list.save(w);
			
			
		}
		
		
		public String toString()
		{
			return String.format("<UserAccountListUpdate>");
		}
	}
	
	private static Object _syncStorage = new Object();
	
	private InputStream _getStorageInputStreamByKey(String key) 
	{
		try
		{
			synchronized(_syncStorage)
			{
			
				File file = getServDataFile();
				if(file.exists())
				{
					SimpleStorageFileBase storage = new SimpleStorageFileBase(file);
					storage.open();
					
					InputStream in = storage.getInputStreamByKey(key);
					
					storage.close();
					
					return in;
				}
			}
		
		} catch(Exception ex)
		{

		}		
		
		return null;
		
	}
	
	class UpdateWorker
	{
		
		public StorageFactory storage = null;
		
		public UpdateWorker(StorageFactory storage)
		{
			this.storage = storage;
			
		}
		
		
		private Queue<IStorageUpdate> _queue = new LinkedList<IStorageUpdate>();
		
		
		public void put(IStorageUpdate iupdate)
		{
			synchronized(_queue)
			{
				_queue.add(iupdate);
				_queue.notifyAll();
			}			
		}
		
		public IStorageUpdate get() throws Exception
		{			
			synchronized(_queue)
			{
				while(_queue.isEmpty())
				{
					_queue.wait();
				}
				
				return _queue.poll();
			}	
		}
		
		public IStorageUpdate get(int timeout) throws Exception
		{			
			long t1 = System.currentTimeMillis();
			
			synchronized(_queue)
			{
				while(_queue.isEmpty())
				{
					long delta = System.currentTimeMillis() - t1;
					
					if(delta > timeout)
					{
						throw new Exception("Queeu GetTimeout!");
					}
					
					int waitTime = (int)(timeout - delta);
					if(waitTime < 1)
					{
						waitTime = 1;
					}
					
					_queue.wait(waitTime);
				}
				
				return _queue.poll();
			}	
		}
		
		private void _save(List<IStorageUpdate> updates) throws Exception
		{
			synchronized(_syncStorage)
			{
				File file = getServDataFile();
				SimpleStorageFileBase storage = new SimpleStorageFileBase(file);
				
				storage.open();
				
				
				for(IStorageUpdate upateItem : updates)
				{
					String key = upateItem.getKey();
					
					System.out.println(String.format("StorageUpdate %s %s", key, upateItem));
					
					OutputStream out = storage.getOutputStreamByKey(key);
						
					StorageDataWriter w = new StorageDataWriter(out);
					
					upateItem.save(w);
					
				}				
				
				
				storage.save();
				storage.close();
			}		
			
		}
		
		private void _loop() throws Exception
		{
			
			int totalTimeout = 30000 * 1;

			while(true)
			{
				
				
				HashMap<String, IStorageUpdate> items = new HashMap<String, IStorageUpdate>();
				
				
				IStorageUpdate iUpdate = get();
				items.put(iUpdate.getKey(), iUpdate);
				
				
				try
				{
					long t1 = System.currentTimeMillis();
					
					for(int i=0; i<1024; i++)
					{
						long delta = System.currentTimeMillis() - t1;
						
						if(delta > totalTimeout) break;
						
						iUpdate = get(5000);
						
						items.put(iUpdate.getKey(), iUpdate);
						
					}					
					
					
				}catch(Exception ex)
				{
					
				}
				
				_save(new ArrayList<IStorageUpdate>(items.values()));

			}		
			
		}
		
		
		private Thread _thread = null;
		
		public void start()
		{
			_thread = new Thread(new Runnable(){
				
				
				public void run() {
					try
					{
						_loop();
						
					}catch(Exception ex)
					{					
					}
					
				}
			});
			
			_thread.start();
		}
		
		
		
		
		
	}
	
	
	
	
}
