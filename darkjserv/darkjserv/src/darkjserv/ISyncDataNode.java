package darkjserv;


import darkjserv.net.DataWriter;

public interface ISyncDataNode 
{	
	
	 
	
	short getType();
	
	void saveData(DataWriter w, Factory factory) throws Exception;
}
