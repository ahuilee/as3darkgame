package darkjserv;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

public class ThreadPoolWorkQueue 
{
	
	private Queue<IWork> _queue = new LinkedList<IWork>();
	
	public int threadPoolSize = 0;
	
	public ThreadPoolWorkQueue(int threadPoolSize)
	{
		this.threadPoolSize = threadPoolSize;
	}	
	
	public void put(IWork work)
	{
		synchronized(_queue)
		{
			_queue.offer(work);
			_queue.notifyAll();
		}		
	}
	
	public IWork get() throws Exception
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
	
	private ArrayList<Worker> _workers = null;
	
	
	public boolean isShutdown = false;
	
	public void start()
	{
		isShutdown = false;
		_workers = new ArrayList<Worker> ();
		
		for(int i=0; i<threadPoolSize; i++)
		{
			Worker worker = new Worker(this);
			worker.start();
			
			_workers.add(worker);
		}
		
		
	}
	
	public static int _lastId = 0;
	public static Object _syncLastId = new Object();
	
	class Worker
	{
		
		public ThreadPoolWorkQueue queue = null;		
		private Thread _thread = null;		
		public int id = 0;
		
		public Worker(ThreadPoolWorkQueue queue)
		{
			this.queue = queue;
			
			synchronized(_syncLastId)
			{
				this.id = ++_lastId;
			}
			
		}
		
		
		private void _loop() throws Exception
		{
			
			while(!queue.isShutdown)
			{
				IWork work = queue.get();
				
				//System.out.println(String.format("%s get %s", this, work));
				
				try
				{
					work.run();
					
				} catch(Exception ex)
				{
					work.except(ex);
				}
				
				
			}
			
		}
		
		public void start()
		{
			_thread = new Thread(new Runnable(){

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
		
		
		public String toString()
		{
			return String.format("<Worker id=%d>", id);
		}
		
		
	}
	
	
	
	

}
