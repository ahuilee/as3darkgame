package darkjserv.net;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;


import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

import darkjserv.IWork;

public class ConnectionBase implements IWork
{
	
	public Socket sock = null;
	public Server server = null;
	
	public int id = 0;
	
	private InputStream _inputStream = null;
	private OutputStream _outputStream = null;
	
	
	private WorkQueue _workQueue = null;
	
	public byte status = 0;
	
	public static final byte CONNECTION_MADE = 1;
	public static final byte CONNECTION_LOST = 2;
	
	public Object syncWriteObj = new Object();
	
	public ConnectionBase(int id ,Socket sock, Server server)
	{
		this.id = id;
		this.sock = sock;
		this.server = server;	
		
		
	}
	
	public void putWork(IWork work)
	{
		_workQueue.put(work);
	}

	byte[] _buffer = new byte[4096];
	int _bufferLength = 0;
	
	
	public void write(byte[] data) throws Exception
	{
		_outputStream.write(data);
		
	}
	
	public void writeFlush() throws Exception
	{
		_outputStream.flush();
	}
	
	private Object _syncAsk = new Object();
	private short _lastReqId = 0;	
	private int _lastAsk = 0;	
	
	public short makeReqId()
	{
		synchronized(_syncAsk)
		{
			return ++_lastReqId;
		}		
	}
	
	public int makeAsk()
	{
		synchronized(_syncAsk)
		{
			return ++_lastAsk;
		}		
	}
	
	public boolean isShutdown = false;
	
	public void connectionLost(String reason)
	{
		
	}
	
	
	class WriteCommandWork implements IWork
	{
		
		public ICommand command = null;
		public ConnectionBase conn = null;
		
		public WriteCommandWork(ICommand command, ConnectionBase conn)
		{
			this.command = command;
			this.conn = conn;
		}

		public void run() throws Exception {
			
			conn.writeCommand(command);
			
		}

		public void except(Exception ex) 
		{
			// TODO Auto-generated method stub
			
		}
		
	}
	
	public void putCommand(ICommand command)
	{
		_workQueue.put(new WriteCommandWork(command, this));
	}
	
	
	private HashMap<Integer, CommandWrap> _getCommandWrapByAsk = new HashMap<Integer, CommandWrap> ();
	
	
	class CommandWrap
	{
		public ICommand command = null;
		public int ask = 0;
		public long time = 0;
		
		public String toString()
		{
			return String.format("<CommandWrap ask=%d %s>", ask, command);
		}
	}
	
	public void releaseOldCommandWraps()
	{
		synchronized(_getCommandWrapByAsk) 
		{
			
		}
	}
	
	public void writeCommand(ICommand command) throws Exception
	{
	
		synchronized(syncWriteObj)
		{
		
			byte[] header = new byte[15];
			byte[] body = command.getCommandBytes();
			
			short qid =  makeReqId();
			int ask = makeAsk();
			int cmdCode = command.getCommandCode();
			
			synchronized(_getCommandWrapByAsk) 
			{
				CommandWrap wrap = new CommandWrap();
				wrap.ask = ask;
				wrap.time = System.currentTimeMillis();
				wrap.command = command;
				
				_getCommandWrapByAsk.put(ask, wrap);
			}
			
			int offset = 0;
			int packetLength = 7;
			
			if(body != null)
			{
				packetLength += body.length;
			}
			
			header[offset++] = Packet.COMMAND;
			header[offset++] = (byte)((qid & 0xff00) >> 8);
			header[offset++] = (byte)(qid & 0x00ff);		
			
			header[offset++] = (byte)((packetLength & 0xff0000) >> 16);
			header[offset++] = (byte)((packetLength & 0x00ff00) >> 8);
			header[offset++] = (byte)(packetLength & 0x0000ff);
			
			offset = 8;
			header[offset++] = (byte)((ask & 0xff000000) >> 24);
			header[offset++] = (byte)((ask & 0x00ff0000) >> 16);
			header[offset++] = (byte)((ask & 0x0000ff00) >> 8);
			header[offset++] = (byte)(ask & 0x000000ff);
			
			header[offset++] = (byte)((cmdCode & 0xff0000) >> 16);
			header[offset++] = (byte)((cmdCode & 0x00ff00) >> 8);
			header[offset++] = (byte)(cmdCode & 0x0000ff);
			
			write(header);
			if(body != null)
			{
				write(body);
			}
			
			writeFlush();
		
		//System.out.println(String.format("%s writeCommand %s", this, command));
		}
		
	}
	

	public byte[] read(int count) throws Exception
	{
		byte[] buf = new byte[1];
		byte[] data = new byte[count];
		int length = 0;
		
		int recv = 0;
		
		
		while(length < count)
		{
			try
			{
				recv = _inputStream.read(buf);
			} catch(Exception ex)
			{
				throw new ConnectionLost(ex.getMessage());
			}
			
			if(recv < 1) throw new ConnectionLost(String.format("recv=%d", recv));
			
			data[length++] = buf[0];
		}
		
		return data;
	}
	
	public byte[] read2(int count) throws Exception
	{		
		
		byte[] data = new byte[count];
		
		if(_bufferLength >= count)
		{
			System.arraycopy(_buffer, 0, data, 0, count);			
			_bufferLength -= count;
			
			return data;			
		}  
		
		int length = 0;
		
		if(_bufferLength > 0)
		{			
			System.arraycopy(_buffer, 0, data, 0, _bufferLength);	
			length = _bufferLength;
			_bufferLength = 0;
		}
			
		int recv = 0;
		byte[] buf = new byte[4096];
		int r = count - length;
		
		while(r > 0)
		{		
			
			recv = _inputStream.read(buf);
			
			//System.out.println(String.format("recv=%d", recv));
			/*
			if(recv > count)
			{
				System.out.println(String.format("read more %s", new String(Arrays.copyOfRange(buf, 0, recv))));
			}*/
			
			if(recv < 1) throw new ConnectionLost(String.format("recv=%d", recv));
			
			
			
			
			if(recv < r)		
			{
				System.arraycopy(buf, 0, data, length, recv);
				length += recv;
				
			} else 
			{
				
				System.arraycopy(buf, 0, data, length, r);
				length += r;
				
				int more = recv - r;
				
				System.arraycopy(buf, r, _buffer, _bufferLength, more);
				_bufferLength += more;
			}
					
					
			
			r = count - length;
			
		}
		
		return data;
	}
	
	
	public  void answerReceived(Packet packet) throws Exception
	{
		
		DataReader rd = new DataReader(new ByteArrayInputStream(packet.data));
		
		int ask = rd.readInt();
		byte answerFlag = rd.readByte();
		CommandWrap wrap =null;
		synchronized(_getCommandWrapByAsk)
		{
			wrap = _getCommandWrapByAsk.getOrDefault(ask, null);
			_getCommandWrapByAsk.remove(ask);
		}
		
		if(wrap != null)
		{
			ICommandCallback callback = wrap.command.getCallback();
			
			if(callback != null)
			{
				if(answerFlag == Packet.ANSWER_SUCCESS)
				{
					callback.success(ask, rd);
				}
			}
		}

	}
	
	public  void commandReceived(Packet packet) throws Exception
	{
	

	}
	
	public void connectionMade()
	{
		status  = CONNECTION_MADE;
	}
	
	public String joinBytes(byte[] data)
	{
		String output= "";
		
		for(byte b : data)
		{
			output += String.format("%02x-", b);
					
		}
		
		return output;
	}
	
	public SyncNodeQueue syncQueue =null;
	
	public void run() throws Exception
	{
		
		_inputStream = sock.getInputStream();
		_outputStream = sock.getOutputStream();
		
		_workQueue = new WorkQueue(this);
		syncQueue = new 	SyncNodeQueue(this);
		isShutdown = false;
		try
		{
			connectionMade();
			
			_workQueue.start();
			syncQueue.start();
		
			
			while(!isShutdown)
			{
				//System.out.println("read header...");
				byte[] header = read(8);
				
				//System.out.println(String.format("header=%s", joinBytes(header)));
				
				int offset = 0;
				
				Packet packet = new Packet();
				
				packet.type = header[offset++];
				packet.qid = (header[offset++] << 8) & 0xff00 | header[offset++] & 0x00ff;
				int packetLength = (header[offset++] << 16) & 0xff0000
									| (header[offset++] << 8) & 0x00ff00
									| (header[offset++]) & 0x0000ff;
				
				//System.out.println(String.format("read =%s packetLength=%d", packet, packetLength));
				
				packet.data = read(packetLength);
				
				//System.out.println(String.format("recv %s", packet));
				
				switch(packet.type )
				{
					case Packet.COMMAND:
						commandReceived(packet);
						break;
					case Packet.ANSWER:
						answerReceived(packet);
						break;
					
				}
				
				
			}
		
		} catch(ConnectionLost ex)		
		{
			connectionLost(ex.getMessage());
		}
		
		isShutdown = true;
	}
	

	public void except(Exception ex) 
	{
		ByteArrayOutputStream bs = new ByteArrayOutputStream();
		PrintStream ps = new PrintStream(bs);
		
		ex.printStackTrace(ps);
		
		
		System.out.println(String.format("conn except %s", new String(bs.toByteArray())));
		
		if(ex instanceof ConnectionLost )
		{
			connectionLost(ex.getMessage());
		}
		
	}
	
	
	
	public String toString()
	{
		return String.format("<Conn id=%d>", id);
	}
	
	
	class WorkQueue
	{
		
		private Queue<IWork> _queue = new LinkedList<IWork>();
		public ConnectionBase conn = null;
		
		public WorkQueue(ConnectionBase conn)
		{
			this.conn = conn;
		}
		
		public void put(IWork work)
		{
			synchronized(_queue)
			{
				
				_queue.offer(work);
				_queue.notify();				
				
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
		
		private void _run()
		{
			try
			{
				while(!conn.isShutdown)
				{
					IWork work = get();
					
					//System.out.println(String.format("%d %s GetWork %s",System.currentTimeMillis(), conn, work));
					try
					{
						work.run();
						
					} catch(Exception ex)
					{
						work.except(ex);
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
					_run();
				}
				
				
			});
			
			_thread.start();
		}
		
		
	}
	
	
	
	

}
