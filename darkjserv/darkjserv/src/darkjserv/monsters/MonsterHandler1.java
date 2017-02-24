package darkjserv.monsters;


import java.util.ArrayList;
import java.util.List;


import darkjserv.Factory;
import darkjserv.IGameMonster;
import darkjserv.IGameObj;
import darkjserv.MapFactory;
import darkjserv.MonsterFactory;
import darkjserv.Utils;
import darkjserv.maps.IMapData;
import darkjserv.monsters.*;
import darkjserv.net.GamePlayer;
import darkjserv.syncs.SyncCharPosition;

public class MonsterHandler1
{
	
	public MonsterFactory factory = null;
	ArrayList<MonsterSet> _allSets = null;
	
	public MonsterHandler1(MonsterFactory factory)
	{		
		this.factory = factory;
		
		loadTable();
	}
	
	public void loadTable()
	{
		_allSets = new ArrayList<MonsterSet>();
		
		List<IMapData> allMapData = MapFactory.getInstance().getAllMapData();
		
		System.out.println(String.format("allMapData = %d", allMapData.size()));
		
		
		for(IMapData mapData : allMapData)
		{
			List<IMonsterBorn> allBorns = mapData.getAllMonsterBorns();
			
			System.out.println(String.format("%s born %d", mapData, allBorns.size()));
			
			for(IMonsterBorn born : allBorns)
			{
				MonsterSet set1 = new MonsterSet();
				
				set1.born = born;
				set1.delegate = null;
				_allSets.add(set1);
				
			}
			
		}

	}
	
	
	class MonsterSet
	{
		
		public IMonsterBorn born = null;
		
		public IMonsterDelegate delegate = null;
		
	}
	
	
	
	private void broadcastUpdate(IGameObj iobj)
	{
		List<GamePlayer> hitPlayers = Factory.getInstance().hitPlayerViews(iobj.getMapId(), iobj.getX(), iobj.getY());
		
		//System.out.println(String.format("createMonster hitPlayers=%s", hitPlayers.size()));
		
	
		SyncCharPosition syncNode = new SyncCharPosition(iobj);
		
		
		for(GamePlayer p : hitPlayers)
		{
			p.conn.syncQueue.put(iobj, syncNode);
			
		}
	}
	
	
	private void _loop()
	{
		try 
		{			
			System.out.println(String.format("start %s", this));
			
			while(true)
			{				
				Thread.sleep(1000 * 10);	
				
				for(MonsterSet set : _allSets)
				{
					if(set.delegate == null || set.delegate.getMonster().getIsReleased())
					{
						IMonsterDelegate delegate = set.born.createMonsterDelegate();
						
						if(delegate != null)
						{
							IGameMonster iobj = delegate.getMonster();
							
							
							
							Factory.getInstance().addGameObj(iobj);
							
							delegate.startAI();
							
							set.delegate = delegate;
							
							broadcastUpdate(iobj);
						
						}
					}
				}
				
			}
		
		} catch(Exception ex)
		{
			
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
