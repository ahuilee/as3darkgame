package darkjserv.net;

import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.concurrent.TimeoutException;

import darkjserv.GameAnimationEnums;
import darkjserv.IGameObj;
import darkjserv.ISyncDataNode;
import darkjserv.net.commands.GameSyncDataCommand;
import darkjserv.net.commands.GameSyncDataGroup;
import darkjserv.syncs.ISyncTimeNode;
import darkjserv.syncs.SyncAnimation;
import darkjserv.syncs.SyncInfoTypes;
import darkjserv.syncs.SyncObjWalkTo;

public class SyncNodeQueue
{
	
	public ConnectionBase conn = null;
	
	private LinkedList<Item> _queue = null;
	
	public int state = 0;
	
	public static final int STATE_NONE = 0;
	public static final int STATE_CLEAR = 1;
	
	public SyncNodeQueue(ConnectionBase conn)
	{
		this.conn = conn;
		state = STATE_NONE;
		_queue= new LinkedList<Item>();	
		
	}
	
	public void clear() throws Exception
	{
		synchronized(_syncObj)
		{
			_clearDone = false;
			synchronized(_queue)
			{
				state = STATE_CLEAR;
				_queue.notifyAll();
			}
			
			while(_clearDone == false)
			{
				_syncObj.wait();
			}
			
			System.out.println("SyncQueue Clear");
		}
	}
	
	private Object _syncObj = new Object();
	private boolean _clearDone = false;
	
	public void put(IGameObj iobj, ISyncDataNode node)
	{
		synchronized(_queue)
		{
			Item item = new Item();
			item.iobj = iobj;
			item.node = node;
			//_queue.add(item);
			_queue.offer(item);
			_queue.notifyAll();
		}
	}
	
	class Item
	{
		public IGameObj iobj = null;
		public ISyncDataNode node = null;
	}
	
	class ClearException extends Exception
	{

		private static final long serialVersionUID = 1L;
		
	}
	
	private Item get() throws Exception
	{
		synchronized(_queue)
		{
			while(_queue.isEmpty())
			{
				if(state == STATE_CLEAR)
				{
					throw new ClearException();
				}
				_queue.wait();
			}
			
			//Item item = _queue.get(0);
			//_queue.remove(0);
			//return item;
			return _queue.poll();
		}
	}
	
	private Item get(int timeout) throws Exception
	{
		long t1 = System.currentTimeMillis();
		int delay = 0;
		
		synchronized(_queue)
		{
			while(_queue.isEmpty())
			{
				if(state == STATE_CLEAR)
				{
					throw new ClearException();
				}
				
				long delta = System.currentTimeMillis() - t1;
				
				if(delta > timeout) throw new TimeoutException();
				
				delay = (int)(timeout - delta);
				
				if(delay < 1) delay = 1;
				
				_queue.wait(delay);
			}
			
			return _queue.poll();
		}
	}
	
	
	
	private void _innerLoop() throws Exception
	{

		ArrayList<Item> items = new ArrayList<Item>();
		
		int singleTimeout = 10;
		int totalTimeout = 200;
		
		items.add(get());
		long curTime = System.currentTimeMillis();				
		
		
		try 
		{					
			
			long delta = 0;
			for(int i=0; i<512; i++)
			{
				delta = System.currentTimeMillis() - curTime;
				//
				if(delta > totalTimeout)
				{
					throw new TimeoutException();
				}						
				
				Item item = get(singleTimeout);
				
				items.add(item);						
			}
		} catch(TimeoutException ex)
		{					
		}catch(ClearException ex)
		{
			throw ex;
		}
		catch(Exception ex)
		{
			System.out.println(String.format("SyncNodeQueue %s", ex));
		}
		
		
		//long allDelta = System.currentTimeMillis() - curTime;
		
		//System.out.println(String.format("SyncNodeQueue allDelta = %d", allDelta));
		
		
		HashMap<Long, HashMap<Short, ISyncDataNode>> getGroupByObjId = new HashMap<Long, HashMap<Short, ISyncDataNode>> ();
		
		for(Item item : items)
		{
			
			HashMap<Short, ISyncDataNode> map = getGroupByObjId.getOrDefault(item.iobj.getObjId(), null);
			
			if(map == null)
			{
				
				map = new HashMap<Short, ISyncDataNode>();
				
				getGroupByObjId.put(item.iobj.getObjId(), map);
			}
			
			if(item.node != null)
			{					
				map.put(item.node.getType(), item.node);
				
				
				
			}
			
		}
		
		
		ArrayList<GameSyncDataGroup> gs = new ArrayList<GameSyncDataGroup>();
		
		
		
		for(Entry<Long, HashMap<Short, ISyncDataNode>> entry : getGroupByObjId.entrySet())
		{
			long objId = entry.getKey();
			HashMap<Short, ISyncDataNode> nodes = entry.getValue();
			
			GameSyncDataGroup g = new GameSyncDataGroup();
			
			g.objId = objId;
			
			if(nodes.containsKey(SyncInfoTypes.OBJ_DEAD))
			{
				
				g.nodes.add(nodes.get(SyncInfoTypes.OBJ_DEAD));
				
			} else
			{				
				
				
				ArrayList<ISyncTimeNode> _timeNodes = new ArrayList<ISyncTimeNode>();
			
				boolean hasAttackAni = false;
				
				for(ISyncDataNode node : nodes.values())
				{
					if(node instanceof ISyncTimeNode)
					{
						_timeNodes.add((ISyncTimeNode)node);
					}
					else
					{
						g.nodes.add(node);
					}		
					
					
					if(node.getType() == SyncInfoTypes.ANIMATION)
					{
						SyncAnimation syncAni = (SyncAnimation)(node);
						
						if(syncAni.animationId == GameAnimationEnums.ATTACK1)
						{
							hasAttackAni = true;
						}
					}
				}
				
				if(hasAttackAni)
				{
					System.out.println(String.format("SyncQueue hasAttack _timeNodes= %d ", _timeNodes.size()));
				
					for(int i=0; i<_timeNodes.size(); i++)
					{
						ISyncTimeNode timeNode = _timeNodes.get(i);
						
						System.out.println(String.format("SyncQueue hasAttack %s", timeNode));
					}
				}
				
				if(_timeNodes.size() > 0)
				{				
					ISyncTimeNode latestNode = _timeNodes.get(0);
					long latestNodeStartTime = latestNode.getStartTime();
					for(int i=1; i<_timeNodes.size(); i++)
					{
						ISyncTimeNode nextNode = _timeNodes.get(i);
						long nextNodeStartTime = nextNode.getStartTime();
						if(nextNodeStartTime > latestNodeStartTime)
						{
							latestNode = nextNode;
							latestNodeStartTime = nextNodeStartTime;
						}
					}
					
					//System.out.println(String.format("latestNode %s", latestNode));
					
					ISyncDataNode lastSyncNode = (ISyncDataNode)latestNode;
					
					g.nodes.add(lastSyncNode);
					
					
					//System.out.println(String.format("SyncQueue %d %s", System.currentTimeMillis(), latestNode));
					
					
					if(lastSyncNode.getType() == SyncInfoTypes.ANIMATION)
					{
						SyncAnimation syncAni = (SyncAnimation)(lastSyncNode);
						
						if(syncAni.animationId == GameAnimationEnums.ATTACK1)
						{
						
							System.out.println(String.format("SyncQueue %d %s startServTicks=%d", System.currentTimeMillis(), syncAni, syncAni.startServTicks));
						}
					}
				}
			
			}
			
			gs.add(g);
		}

		//System.out.println(String.format("%s Sync Get=%d groups=%d ", this.conn, items.size(), gs.size()));
		
		SyncCommandCallback callback = new SyncCommandCallback();
		
		
		GameSyncDataCommand syncCmd = new GameSyncDataCommand(gs, conn.server.factory);
		syncCmd.callback = callback;
		
		conn.putCommand(syncCmd);
		
		try 
		{
			callback.waitCallback(1000);
		} catch(Exception ex)
		{
			System.out.println(String.format("SyncQueue CallbackTimeout=%s", ex.getMessage()));
		}
	}
	
	private void _loop()
	{
		try
		{
		
			while(!conn.isShutdown)
			{

				try
				{
					_innerLoop();
				
				} catch(ClearException ex)
				{
					
				}
				
				
				
				synchronized(_syncObj)
				{
					if(state == STATE_CLEAR)
					{
						state = STATE_NONE;
						
						_queue.clear();
						
						
						
						_clearDone = true;
						
						_syncObj.notifyAll();
						
					}
				}
				//GameSyncDataGroup g=  		
				
				
				//syncGroups.add(g);
				
				
			
				//conn.writeCommand(syncCmd);
			}
			
		} catch(Exception ex)
		{
			ByteArrayOutputStream s = new ByteArrayOutputStream();
			PrintStream printStream = new PrintStream(s);
			ex.printStackTrace(printStream);
			System.out.println(String.format("SyncNodeQueue err=%s", s.toString()));
		}
	}
	
	class SyncCommandCallback implements ICommandCallback
	{
		
		private Object _syncObj = new Object();
		
		public void waitCallback(long timeout) throws Exception
		{
			synchronized(_syncObj)
			{
				_syncObj.wait(timeout);
			}
		}

		public void success(int ask, DataInputStream rd)
		{
			synchronized(_syncObj)
			{
				_syncObj.notify();
			}			
			
			//System.out.println(String.format("SyncCommandCallback success=%d", ask));
			
			// TODO Auto-generated method stub
			
		}
		
	}
	
	private Thread _thread = null;
	public void start()
	{
		_thread = new Thread(new Runnable(){

			public void run() {
				// TODO Auto-generated method stub
				_loop();
			}
			
		});
		
		_thread.start();
	}

}
