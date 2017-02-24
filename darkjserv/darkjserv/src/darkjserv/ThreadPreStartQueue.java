package darkjserv;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

public class ThreadPreStartQueue 
{

	
	private Queue<IWork> _queue = null;
	
	public int preStartSize = 1;
	
	public ThreadPreStartQueue(int preStartSize)
	{
		this.preStartSize = preStartSize;
		_queue = new LinkedList<IWork>();
	}
	
	public void start()
	{
		_preStart();
		
	}
	
	
	public IWork get() throws Exception
	{
		synchronized(_queue)
		{
			while(_queue.size() == 0)
			{
				_queue.wait();
			}
			
			return _queue.poll();
		}
	}
	
	class Worker implements Runnable
	{
		public int id = 0;
		public ThreadPreStartQueue queue = null;
		private Thread _thread = null;
		
		public Worker(int id, ThreadPreStartQueue queue)
		{
			this.id = id;
			this.queue = queue;
		
		}
		
		public void start()
		{
			_thread = new Thread(this);
			_thread.start();
		}

		public void run() 
		{
			IWork work = null;
			
			try 
			{
				//System.out.println(String.format("start %s", this));
				work = queue.get();
				_removeWorker(this);
				//System.out.println(String.format("prestart work %s", work));
				
				work.run();
				
				
			} catch(Exception ex)
			{
				System.out.println(ex.getMessage());
				
				try 
				{
					work.except(ex);
					
				} catch(Exception ex2)
				{
					System.out.println(ex2.getMessage());
				}
				
			}
			
			_removeWorker(this);
			
			
		}
		
		public String toString()
		{
			return String.format("<Worker id=%d>", id);
		}
		
	}
	
	private ArrayList<Worker> _workers = new ArrayList<Worker> ();
	
	
	private void _removeWorker(Worker worker)
	{
		synchronized(_workers)
		{
			
			_workers.remove(worker);
		}
		
		_preStart();
	}
	
	private int _lastWorkerId = 0;
	
	private void _startWorker()
	{
		synchronized(_workers)
		{
			Worker worker = new Worker(++_lastWorkerId, this);
			_workers.add(worker);
			worker.start();
			
			
		}
	}
	
	private void _preStart()
	{
		
		
		synchronized(_workers)
		{
			int workerCount = _workers.size() ;
			
			//System.out.println(String.format("_preStart %d/%d",  workerCount, preStartSize));
			
			if(workerCount < preStartSize)
			{
				for(int i=0; i < (preStartSize-workerCount) ; i++)
				{
					_startWorker();
				}
			}
		}
	}
	
	
	public void put(IWork work)
	{
		synchronized(_queue)
		{
			 _preStart();
			
			_queue.offer(work);
			_queue.notify();
		}
	}

}
