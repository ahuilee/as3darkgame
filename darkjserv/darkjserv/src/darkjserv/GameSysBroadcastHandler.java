package darkjserv;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import darkjserv.net.GamePlayer;
import darkjserv.net.commands.DisplayTalkMessageCommand;

public class GameSysBroadcastHandler 
{
	
	public Factory factory = null;
	
	public GameSysBroadcastHandler(Factory factory)
	{
		this.factory = factory;
		
		_queue = new LinkedList<Item>();
	}
	
	
	public class Item
	{
		public String text = "";
	}
	
	private Queue<Item> _queue = null;
	
	
	public void put(String text)
	{
		
		//System.out.println(String.format("put broadcast %s", text));
		synchronized(_queue)
		{
			Item item = new Item();
			item.text = text;
			_queue.offer(item);
			_queue.notifyAll();
		}
		
	}
	
	public Item get() throws Exception
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
	
	private void _loop()
	{
		try
		{
			
			//System.out.println(String.format("Broadcast Loop %s", this));
			
			while(true)
			{
				
				Item item = get();
				
				//System.out.println(String.format("Broadcast get %s", item.text));
				
					
				List<GamePlayer> players = factory.getAllPlayers();
					
				for(GamePlayer p :players)
				{
					try
					{
						DisplayTalkMessageCommand cmd = new DisplayTalkMessageCommand(item.text);
							
						p.conn.writeCommand(cmd);
							
							
					} catch(Exception ex)
					{						
						
					}
						
				}
					
				
				
			}
			
		} catch(Exception ex)
		{
			System.out.println(String.format("Broadcast Error %s", ex.getMessage()));
		}
		
	}
	
	private Thread _thread = null;
	
	public void start()
	{
		
		
		
		_thread = new Thread(new Runnable(){

			public void run() 
			{
				
				_loop();
			}
			
		});	
		
		_thread.start();
		
		
		Thread testTh = new Thread(new Runnable(){

			public void run() {
				try
				{
					int loopCount = 0;
					while(true)
					{
						
						Thread.sleep(10000);
						
						String text = String.format("系統公告 Test %d", ++loopCount);
						
						put(text);
					}
				} catch(Exception ex)
				{
					
				}
			}});
		
		testTh.start();
		
	}

}
