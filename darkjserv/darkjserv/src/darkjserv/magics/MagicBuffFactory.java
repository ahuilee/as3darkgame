package darkjserv.magics;

import java.util.List;

import darkjserv.Factory;
import darkjserv.net.GamePlayer;



public class MagicBuffFactory 
{
	
	private static MagicBuffFactory _instance = null;
	
	public static MagicBuffFactory getInstance()
	{
		if(_instance == null)
		{
			_instance = new MagicBuffFactory();
		}
		
		return _instance;		
	}
	
	private void _loop() throws Exception
	{

		while(true)
		{
			Thread.sleep(3000);
			
			long now = System.currentTimeMillis();
			
			try
			{
				List<GamePlayer> players = Factory.getInstance().getAllPlayers();
				
				for(GamePlayer p : players)
				{
					
					List<IMagicBuff> expireBuffs = p.magicBuffList.getExpireItems(now);
					
					for(IMagicBuff buff : expireBuffs)
					{
						System.out.println(String.format("expireBuffs =%s", buff));
					}					
					
				}
				
				
			} catch(Exception ex)
			{
				
			}
			
		
		}
	}
	
	private Thread _thread = null;
	
	public void start()
	{
		if(_thread == null)
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
