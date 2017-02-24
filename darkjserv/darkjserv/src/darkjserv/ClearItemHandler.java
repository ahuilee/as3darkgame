package darkjserv;

import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.List;

import darkjserv.items.CItemGameObjWrap;
import darkjserv.net.GamePlayer;
import darkjserv.net.commands.RemoveObjCommand;

public class ClearItemHandler 
{
	
	private static ClearItemHandler _instance = null;
	public static ClearItemHandler getInstance()
	{
		if(_instance == null)
		{
			_instance = new ClearItemHandler();
		}
		
		return _instance;
	}
	
	
	private void _loop() throws Exception
	{
		try
		{
			while(true)
			{
				
				Factory factory =  Factory.getInstance();
				
				
				long now = System.currentTimeMillis();
				
				List<CItemGameObjWrap> objs = factory.getAllItemObjs();
				
				for(CItemGameObjWrap obj : objs)
				{
					if(now > obj.expiryTime)
					{
						factory.removeGameObj(obj);
						
						//System.out.println(String.format("expiry item %s", obj));
						

						Rectangle rect = new Rectangle(obj.getX()-512, obj.getY()-512, 1024, 1024);
						
						List<GamePlayer> inViewPlayers1 = factory.hitPlayerViewsByRect(obj.getMapId(), rect);
						
						if(inViewPlayers1.size() > 0)
						{
							
							List<Long> removePks = new ArrayList<Long>();
							removePks.add(obj.getObjId());							
							
							for(GamePlayer p : inViewPlayers1)
							{
								try {
						
									RemoveObjCommand syncCmd = new RemoveObjCommand(removePks);
							
									p.conn.writeCommand(syncCmd);
								} catch(Exception ex)
								{
									
								}
							}
						}
						
						
					}
					
					
				}
				
				
				
				Thread.sleep(60000);
			}
		} catch(Exception ex)
		{
			
		}
		
	}
	
	private Thread _thread = null;
	
	public void start()
	{
		
		if(_thread == null)
		{
		
			_thread = new Thread(new Runnable()
			{
	
				public void run() 
				{
				
					try
					{
						_loop();
					
					} catch(Exception ex)
					{
						
					}
				}
				
			});
			
			_thread.start();
		
		}
		
	}
	

}
