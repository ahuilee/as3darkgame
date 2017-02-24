import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.HashMap;

import darkjserv.MapFactory;
import darkjserv.MonsterFactory;
import darkjserv.PolicyServer;
import darkjserv.http.SimpleHttpServer;
import darkjserv.net.Server;
import darkjserv.storages.SimpleStorageFileBase;
import darkjserv.storages.StorageFactory;


public class Main {

	/**
	 * @param args
	 */
	

	public static void main(String[] args) 	
	{
		
		
		try 
		{
			
			//HashMap<Integer, Integer> map = new HashMap<Integer, Integer> ();
			//map.remove(10);
			System.out.println("start Game Server...");
			
			
			
			
			SimpleHttpServer httpServer = new SimpleHttpServer(16091);
			
			httpServer.start();
			
			PolicyServer policyServ = new PolicyServer(16095);
			
			policyServ.start();
			
			StorageFactory.getInstance().load();
			StorageFactory.getInstance().start();
			
			MapFactory.getInstance().load();
			MonsterFactory.getInstance().load();
			MonsterFactory.getInstance().start();
			
			
			Server server = new Server(16096);
			
			server.serveForever();
			
		} catch(Exception ex)
		
		{
			System.out.println(ex.getMessage());
		}
		
		
		
		

	}
	
	private static void testStorage() throws Exception
	{
		try
		{
			
			
			
			
			String key = "ServData";
			String root = new File(".").getCanonicalPath();
			
			File f =  new File(root, "simplestorage.test");
			
			SimpleStorageFileBase storage = new SimpleStorageFileBase(f);
			
			storage.open();
			
			OutputStream o1 = storage.getOutputStreamByKey(key);
			
			DataOutputStream w1 = new DataOutputStream(o1);
			
			int count = 65535;
			w1.writeInt(count);
			
			for(int i=0; i<count; i++)
			{
				w1.writeInt(i);
			}
			
			
			storage.save();
			storage.close();
			
			storage = new SimpleStorageFileBase(f);
			
			storage.open();
			
			InputStream in1 = storage.getInputStreamByKey(key);
			
			DataInputStream rd1 = new DataInputStream(in1);
			
			int count2 = rd1.readInt();
			
			for(int i=0; i<count2; i++)
			{
				int idx = rd1.readInt();
				
				System.out.println(String.format("read idx=%d", idx));
			}
			
		
		} catch(Exception ex)
		{
			ByteArrayOutputStream s = new ByteArrayOutputStream();
			ex.printStackTrace(new PrintStream(s));
			
			System.out.println(String.format("err %s", s.toString("UTF-8")));		
			
		}
	}
	
	public static void main2(String[] args) 	
	{
		try
		{
			/*
			byte[] a = {0, 0, 1, 2, 3, 4, 5, 6};
			byte[] b = {99, 99, 99};
			
			
			System.arraycopy(a, 0, b, 0, 1);
			
			for(int i=0; i<a.length;i++)
			{
				System.out.println(String.format("a i=%d %d", i, a[i]));
			}
			
			for(int i=0; i<b.length;i++)
			{
				System.out.println(String.format("b i=%d %d", i, b[i]));
			}*/
			testStorage();
		}
		catch(Exception ex)
		{
				
			
		}
		
	}
	

}
