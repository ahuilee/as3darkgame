package darkjserv;

import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import darkjserv.items.CItemGameObjWrap;
import darkjserv.magics.MagicBuffFactory;
import darkjserv.net.Connection;
import darkjserv.net.GamePlayer;

public class Factory 
{
	
	private ArrayList<IGameObj> _gameObjs = new ArrayList<IGameObj>();
	
	public ISyncDelegate syncDelegate = null;
	
	public GameSysBroadcastHandler sysBroadcastHandler = null;
	public GameCharacterLevelTable characterLevelTable = null;
	
	public ThreadPoolWorkQueue attackQueue = null;
	
	public Factory()
	{
		characterLevelTable = new GameCharacterLevelTable();		
		
		sysBroadcastHandler = new GameSysBroadcastHandler(this);
		
		attackQueue = new ThreadPoolWorkQueue(2);
		
	}
	
	private static Factory _instance = null;
	
	public static Factory getInstance()
	{
		if(_instance == null)
		{
			_instance = new Factory();
		}
		
		return _instance;
	}

	
	
	public long gameStartTime = 0;
	
	private long _lastObjId = 0;
	
	private Object _syncLastObjId = new Object();
	
	public long makeObjId()
	{
		synchronized(_syncLastObjId)
		{
			return ++_lastObjId;
		}		
	}
	
	
	
	public void start()
	{
		
		gameStartTime = System.currentTimeMillis();
		
		
		sysBroadcastHandler.start();
		
		attackQueue.start();
		
		MagicBuffFactory.getInstance().start();
		
		ClearItemHandler.getInstance().start();
		// test();
	}
	
	
	
	public HashMap<Long, IGameObj> getObjById = new HashMap<Long, IGameObj>();
	
	public void addGameObj(IGameObj obj)
	{
		//System.out.println(String.format("addGameObj %s", obj));
		synchronized(_gameObjs)
		{
			_gameObjs.add(obj);
			
			getObjById.put(obj.getObjId(), obj);
		}
	}
	
	public void removeGameObj(IGameObj iobj)
	{
		synchronized(_gameObjs)
		{
			
			//System.out.println(String.format("removeGameObj %s", iobj));
			
			_gameObjs.remove(iobj);
			getObjById.remove(iobj.getObjId());
			
		}
	}
	
	public IGameObj getGameObj(long id)
	{
		synchronized(getObjById)
		{
			
			return getObjById.getOrDefault(id, null);
		}
	}
	
	public List<CItemGameObjWrap> getAllItemObjs()
	{
		ArrayList<CItemGameObjWrap> rs = new ArrayList<CItemGameObjWrap>();
		
		synchronized(_gameObjs)
		{
			for(IGameObj iobj :_gameObjs)
			{
				if(iobj instanceof CItemGameObjWrap)
				{
					rs.add((CItemGameObjWrap)iobj);
				}
			}
		}
		
		return rs;
	}
	
	public List<IGameObj> hitGameObjs(int mapId, Rectangle rect)
	{
		ArrayList<IGameObj> rs = new ArrayList<IGameObj>();
		
		synchronized(_gameObjs)
		{
			for(IGameObj iobj :_gameObjs)
			{
				if(iobj.getMapId() == mapId && rect.contains(iobj.getX(), iobj.getY()))
				{
					rs.add(iobj);
				}
			}
		}
		
		return rs;
	}
	
	public List<GamePlayer> getAllPlayers()
	{
		ArrayList<GamePlayer> rs = new ArrayList<GamePlayer>();
		synchronized(_gameObjs)
		{
			for(IGameObj iobj :_gameObjs)
			{
				if(iobj instanceof GamePlayer)
				{
					GamePlayer p = (GamePlayer)iobj;
					
					rs.add(p);
				}
			}
			
		}
		
		return rs;
	}
	
	
	public void removeConnObjs(Connection conn)
	{
		synchronized(_gameObjs)
		{
			ArrayList<IGameObj> rms = new ArrayList<IGameObj>();
			
			for(IGameObj iobj :_gameObjs)
			{
				if(iobj instanceof GamePlayer)
				{
					GamePlayer p = (GamePlayer)iobj;
					
					if(p.conn == conn)
					{
						rms.add(iobj);
					}
					
				}
			}	
			
			for(IGameObj iobj :rms)
			{
				removeGameObj(iobj);
			}
		}
	}
	
	public List<GamePlayer> hitPlayerViewsByRect(int mapId, Rectangle rect)
	{
		ArrayList<GamePlayer> rs = new ArrayList<GamePlayer>();
		
		
		synchronized(_gameObjs)
		{
			for(IGameObj iobj :_gameObjs)
			{
				if(iobj instanceof GamePlayer)
				{
					GamePlayer p = (GamePlayer)iobj;
							
					//System.out.println(String.format("%s %s hit %d, %d= %s", p, p.viewRect, x, y, p.viewRect.contains(x, y)));
					if(p.getMapId() == mapId && p.viewRect.intersects(rect))
					{
						rs.add(p);
					}							
					
				}				
			}			
		}
		
		return rs;
	}
	
	public List<GamePlayer> hitPlayerViews(int mapId, int x, int y)
	{
		ArrayList<GamePlayer> rs = new ArrayList<GamePlayer>();
		
		synchronized(_gameObjs)
		{
			for(IGameObj iobj :_gameObjs)
			{
				if(iobj instanceof GamePlayer)
				{
					GamePlayer p = (GamePlayer)iobj;
							
					//System.out.println(String.format("%s %s hit %d, %d= %s", p, p.viewRect, x, y, p.viewRect.contains(x, y)));
					if(p.getMapId() == mapId && p.viewRect.contains(x, y))
					{
						rs.add(p);
					}							
					
				}				
			}			
		}
		
		return rs;
	}
	

}
