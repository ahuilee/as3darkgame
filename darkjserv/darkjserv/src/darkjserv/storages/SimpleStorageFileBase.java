package darkjserv.storages;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map.Entry;

public class SimpleStorageFileBase 
{
	
	public static final int HEADER_SIZE = 512;
	public static final int PAGE_SIZE = 4096;
	public static final int PAGE_HEADER_SIZE = 16;
	
	public static final byte PAGETYPE_PAYLOAD = 0x01;
	public static final byte PAGETYPE_SCHEMA = 0x02;
	public static final byte PAGETYPE_DATA = 0x03;
	
	
	public static final int PAGE_CONTENT_SIZE = PAGE_SIZE - PAGE_HEADER_SIZE - 2;
	
	
	public SimpleStorageFileBase(File file)
	{
		this._file = file;
	}
	
	private File _file = null;
	private RandomAccessFile _f = null;
	
	
	private Header _header = null;
	
	public void open() throws Exception
	{
		
		_f = new RandomAccessFile(_file, "rw");
		
		_header = _loadHeader();
			
		
		if(_header == null)
		{
			_header = new Header();
		}
		
		System.out.println(String.format("open %s", _header));
		
	}
	
	private Object _syncPageId = new Object();
	
	private int makePageId()
	{
		synchronized(_syncPageId)
		{
			int pageId =  ++_header.pageCount;
			
			_changedPageIds.add(pageId);
			
			return pageId;
		}
	}
	
	private Header _loadHeader() throws Exception
	{
		_f.seek(0);
		
		byte[] data =  new byte[512];
		
		int recv = _f.read(data);
		
		if(recv < HEADER_SIZE) return null;
		
		int offset = 0;
		
		
		Header header = new Header();
		
		header.pageCount = ((data[offset++] << 24) & 0xff000000) | ((data[offset++] << 16) & 0x00ff0000) 
				| ((data[offset++] << 8) & 0x0000ff00) | (data[offset++] & 0x000000ff);
				
		header.schemaPageId = ((data[offset++] << 24) & 0xff000000) | ((data[offset++] << 16) & 0x00ff0000) 
				| ((data[offset++] << 8) & 0x0000ff00) | (data[offset++] & 0x000000ff);
		
		
		
		return header;		
		
	}
	
	private static byte[] makeHeaderBytes(Header header)
	{
		byte[] data = new byte[HEADER_SIZE];
		
		
		//System.out.println(String.format("makeHeaderBytes %s", header));
		
		int length = 0;
		data[length++] = (byte)((header.pageCount & 0xff000000) >> 24);
		data[length++] = (byte)((header.pageCount & 0x00ff0000) >> 16);
		data[length++] = (byte)((header.pageCount & 0x0000ff00) >> 8);
		data[length++] = (byte)(header.pageCount & 0x000000ff);
		
		data[length++] = (byte)((header.schemaPageId & 0xff000000) >> 24);
		data[length++] = (byte)((header.schemaPageId & 0x00ff0000) >> 16);
		data[length++] = (byte)((header.schemaPageId & 0x0000ff00) >> 8);
		data[length++] = (byte)(header.schemaPageId & 0x000000ff);
		
		
		
		return data;
	}
	
	
	public InputStream getInputStreamByKey(String key) throws Exception
	{
		SchemaPage schemaPage = getSchemaPageOrCreate();
		SchemaNode node = schemaPage.getNodeByKey.getOrDefault(key, null);
		
		
		if(node != null)
		{
			IPage page = loadPage(node.pageId);
			
			if(page != null)
			{
				
				return _getInputStreamByPage(page);
			}
		}
		
		
		
		return null;
	}
	
	
	public OutputStream getOutputStreamByKey(String key)
	{
		ByteArrayOutputStream o = new ByteArrayOutputStream();
		
		_getStreamByKey.put(key, o);
		
		return o;		
	}
	
	private HashMap<String, ByteArrayOutputStream> _getStreamByKey = new HashMap<String, ByteArrayOutputStream>();
	
	
	private HashMap<Integer, IPage> _getPageById = new HashMap<Integer, IPage>();
	private HashSet<Integer> _changedPageIds = new HashSet<Integer>();
	
	private void _saveOutStream(IPage ipage, ByteArrayOutputStream s) throws Exception
	{
		byte[] data = s.toByteArray();
		
		int offset = 0;
		
		IPage prevPage = null;
		IPage curPage = ipage;
		
		while(offset < data.length)
		{
			int chunkLen = PAGE_CONTENT_SIZE;
			
			if((offset + chunkLen) > data.length)
			{
				chunkLen = data.length - offset;
			}
				
				
			byte[] chunk = new byte[chunkLen];
			
			System.arraycopy(data, offset, chunk, 0, chunkLen);
			
			//System.out.println(String.format("_saveOutStream offset=%d chunkLen=%d", offset, chunkLen));
			
			
			curPage.setContentBytes(chunk);
			_changedPageIds.add(curPage.getPageId());
			
			if(prevPage != null)
			{
				prevPage.setPayloadPageId(curPage.getPageId());
				
			}
			
			offset += chunkLen;
			
			if(!(offset < data.length))break;
			
			int payloadPageId = curPage.getPayloadPageId();
			
			
			//System.out.println(String.format("save playload next=%d", payloadPageId));
			
			prevPage = curPage;
			
			IPage payload = getPayloadPageOrCreateById(payloadPageId);
			curPage = payload;
			
			//System.out.println(String.format("payload=%s", payload));
			
			
			
			
			
		}
		
		
	}
	
	private boolean _saveChangedPages() throws Exception
	{
		
		/*
		for(Entry<Integer, IPage> entry : _getPageById.entrySet())
		{
			System.out.println(String.format("_getPageById = %d =%s", entry.getKey(), entry.getValue()));
		}
		*/
		boolean hasChanged = false;
		
		for(Integer pageId : _changedPageIds)
		{
			hasChanged = true;
			
			IPage iPage = _getPageById.getOrDefault(pageId, null);
		
			
			//System.out.println(String.format("_SaveChange Page %d = %s",  pageId, iPage));
			
			long offset = calcPageOffset(pageId);
			
			_f.seek(offset);
			
			byte[] data = new byte[PAGE_SIZE];
			int length = 0;
			int payloadPageId = iPage.getPayloadPageId();
			
			data[length++] = iPage.getPageType();
			data[length++] = (byte)((payloadPageId & 0xff000000) >> 24);
			data[length++] = (byte)((payloadPageId & 0x00ff0000) >> 16);
			data[length++] = (byte)((payloadPageId & 0x0000ff00) >> 8);
			data[length++] = (byte)(payloadPageId & 0x000000ff);
			
			length = PAGE_HEADER_SIZE;
			
			int contentByteLen = 0;
			
			byte[] pageContentBytes = iPage.getContentBytes();
			
			
			if(pageContentBytes != null)
			{
				contentByteLen = Math.min(pageContentBytes.length, PAGE_CONTENT_SIZE);

			}
			
			data[length++] = (byte)((contentByteLen & 0xff00) >> 8);
			data[length++] = (byte)(contentByteLen & 0x00ff);
			
			if(contentByteLen > 0)
			{
				System.arraycopy(pageContentBytes, 0, data, length, contentByteLen);
			}
			
			_f.write(data, 0, PAGE_SIZE);
			
			
			//System.out.println(String.format("Save pageId = %d %s", pageId, iPage));
		}
		
		_changedPageIds.clear();
		
		return hasChanged;
	}
	
	private void _saveSchemaPage() throws Exception
	{
		

		SchemaPage schema = getSchemaPageOrCreate();
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		@SuppressWarnings("resource")
		DataWriter w = new DataWriter(out);
		
		w.writeInt(schema.getNodeByKey.size());
		
		for(Entry<String, SchemaNode> entry : schema.getNodeByKey.entrySet())
		{
			String key =  entry.getKey();
			SchemaNode node = entry.getValue();
			
			
			//System.out.println(String.format("saveNode=%s", key));
			
			w.writeHStrUTF(key);
			w.writeInt(node.pageId);
			
		}
		
		w.flush();
		
		//System.out.println(String.format("_saveSchemaPage %d", out.toByteArray().length));
		
		_saveOutStream(schema, out);
		
	}
	
	public void save() throws Exception
	{
		
	
		
		for(Entry<String, ByteArrayOutputStream> entry : _getStreamByKey.entrySet())
		{
			String key  = entry.getKey();
			ByteArrayOutputStream outStream  = entry.getValue();		
			
			
			SchemaNode node = _getOrCreateSchemaNodeByKey(key);
			
			IPage dataPage = getDataPageOrCreateById(node.pageId);
			
			_saveOutStream(dataPage, outStream);
			
			//System.out.println(String.format("Key=%s outStream= %d firstPageId=%d", key, outStream.size(), dataPage.getPageId()));
		}
		
		_saveSchemaPage();
		
		_saveChangedPages();
		
		//save header
		
		_f.seek(0);
		_f.write(makeHeaderBytes(_header),  0, HEADER_SIZE);
		
	}
	
	
	
	public void close() throws Exception
	{
		_f.close();
		
	}
	
	
	private SchemaNode _getOrCreateSchemaNodeByKey(String key)
	{
		
		SchemaPage schemaPage = getSchemaPageOrCreate();
		SchemaNode node = schemaPage.getNodeByKey.getOrDefault(key, null);
		
		//System.out.println(String.format("_getOrCreateSchemaNodeByKey =%s %s", key, node));
		
		if(node == null)
		{
			node = new SchemaNode();
			node.key = key;
			
			int pageId = makePageId();
			DataPage dataPage = new DataPage(pageId);
			_getPageById.put(pageId, dataPage);
			node.pageId = pageId;
			
			schemaPage.getNodeByKey.put(key, node);
			
			_changedPageIds.add(schemaPage.getPageId());
		}
		
		return node;
	}
	
	 
	
	
	
	private long calcPageOffset(int pageId)
	{
		return HEADER_SIZE + (pageId - 1) * PAGE_SIZE;
	}
	
	
	private IPage loadPage(int pageId) throws Exception
	{
		IPage iPage = _getPageById.getOrDefault(pageId, null);
		
		if(iPage == null)
		{
			
			iPage = _loadPageFromFile(pageId);
			
			_getPageById.put(pageId, iPage);
			
		}
		
		
		return iPage;
	}
	
	private IPage _loadPageFromFile(int pageId) throws Exception
	{
		
		
		long pageOffset = calcPageOffset(pageId);
		
		
		_f.seek(pageOffset);
		
		byte[] data =  new byte[PAGE_SIZE];
		
		if(_f.read(data) == PAGE_SIZE)
		{
			
			int offset = 0;
			
			
			byte pageType = data[offset++];
			int payloadPageId = ((data[offset++] << 24) & 0xff000000) | ((data[offset++] << 16) & 0x00ff0000) | ((data[offset++] << 8) & 0x0000ff00)
					 | (data[offset++] & 0x000000ff);
			
			
			offset = PAGE_HEADER_SIZE;
			
			int contentByteLen = ((data[offset++] << 8) & 0xff00) | (data[offset++] & 0x00ff); 
			
			byte[] contentBytes = new byte[contentByteLen];
			System.arraycopy(data, offset, contentBytes, 0, contentByteLen);
		
			//System.out.println(String.format("LoadPage pid=%d type=%d payloadPageId=%d", pageId, pageType, payloadPageId));
			
			switch(pageType)
			{
				case PAGETYPE_PAYLOAD:
					PayloadPage payloadPage = new PayloadPage(pageId);
					payloadPage.payloadPageId = payloadPageId;							
					payloadPage.setContentBytes(contentBytes);
					
					return payloadPage;
					
					
				case PAGETYPE_SCHEMA:
					
					//System.out.println(String.format(">>PAGETYPE_SCHEMA %d contentBytes=%d", pageId, contentBytes.length));
					
					SchemaPage schemaPage = new SchemaPage(pageId);
					schemaPage.payloadPageId = payloadPageId;
					schemaPage.setContentBytes(contentBytes);
					
					_loadSchemaPage(schemaPage);
					return schemaPage;
					
				case PAGETYPE_DATA:
					DataPage dataPage = new DataPage(pageId);
					dataPage.payloadPageId = payloadPageId;
					dataPage.setContentBytes(contentBytes);	
					
					return dataPage;
			}
		}
		
		
		return null;
		
	}
	
	private ByteArrayInputStream _getInputStreamByPage(IPage iPage) throws Exception
	{
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		
		IPage curPage = iPage;
		
		while(true)
		{
			int payloadPageId = curPage.getPayloadPageId();
			byte[] contentBytes = curPage.getContentBytes();
			
			//System.out.println(String.format("_getInputStreamByPage payloadPageId=%d %s", payloadPageId, contentBytes));
			
			if(contentBytes == null) break;
			
			out.write(contentBytes);
		
			
			if(payloadPageId < 1) break;
			
			IPage nextPage = loadPage(payloadPageId);
			
			if(nextPage == null) break;
			
			
			
			curPage = nextPage;
			
		}
		
		
		byte[] data = out.toByteArray();
		
		//System.out.println(String.format("load InputStream length= %d", data.length));
		
		return new ByteArrayInputStream(data);		
	}
	
	private void _loadSchemaPage(SchemaPage page) throws Exception
	{
		
		
		try
		{
			page.getNodeByKey.clear();		
			
			ByteArrayInputStream in = _getInputStreamByPage(page);
			
			
			
			@SuppressWarnings("resource")
			DataReader rd = new DataReader(in);
			
	
			
			int nodeCount = rd.readInt();
			
			//System.out.println(String.format("LoadSchema nodeCount=%d", nodeCount));
			
			for(int i=0; i<nodeCount; i++)
			{
				String key = rd.readHStrUTF();
				int pageId = rd.readInt();
				
				SchemaNode node = new SchemaNode();
				node.key = key;
				node.pageId = pageId;
				
				//System.out.println(String.format("LoadSchema %s pid=%d", key, pageId));
				
				page.getNodeByKey.put(key, node);
			}
		
		} catch(Exception ex)
		{
		
			
			System.out.println(String.format("schema err %s", ex.getMessage()));
		}
		
	}
	
	DataPage getDataPageOrCreateById(int pageId)
	{
		DataPage page = null;
		
		try {
			page = (DataPage)loadPage(pageId);
		} catch(Exception ex)
		{
			
		}
		
		if(page == null)
		{
			int pid = makePageId();
			page = new DataPage(pid);			
			
			_getPageById.put(pid, page);
		}
		
		return page;
		
	}
	
	
	PayloadPage getPayloadPageOrCreateById(int pageId)
	{
		PayloadPage page = null;
		
		try {
			page = (PayloadPage)loadPage(pageId);
		} catch(Exception ex)
		{
			
		}
		
		if(page == null)
		{
			int pid = makePageId();
			page = new PayloadPage(pid);		
			
			_getPageById.put(pid, page);
		}
		
		return page;
		
	}
	
	
	SchemaPage getSchemaPageOrCreate()
	{
		SchemaPage page = null;
		
		//System.out.println(String.format("getSchemaPageOrCreate headerPid=%d", _header.schemaPageId));
		
		
		try {
			page = (SchemaPage)loadPage(_header.schemaPageId);
		} catch(Exception ex)
		{
			
		}
		
		
		
		if(page == null)
		{
			int pageId = makePageId();
			page = new SchemaPage(pageId);
			_header.schemaPageId = pageId;
			
			_getPageById.put(pageId, page);
			
			//System.out.println(String.format("Create SchemaPage %s", page));
		}
		
		
		
		return page;
		
	}
	
	
	class SchemaNode
	{
		public String key;
		public int pageId;
		
		public String toString()
		{
			
			return String.format("<SchemaNode key=%s pid=%d>", key, pageId);
		}
		
	}
	
	class SchemaPage extends  PageBase
	{
		

		
		public HashMap<String, SchemaNode> getNodeByKey;
		
		public SchemaPage(int pageId)
		{
			super(pageId);
			getNodeByKey = new HashMap<String, SchemaNode>();
			
		}

		public byte getPageType() 
		{
			
			return PAGETYPE_SCHEMA;
		}

		
		public String toString()
		{
			return String.format("<SchemaPage pid=%d payload=%d>", pageId, payloadPageId);
		}
		
	}
	

	
	class PayloadPage  extends  PageBase
	{
		
		public PayloadPage(int pageId)
		{
			super(pageId);
			
		}


		public byte getPageType() {
			// TODO Auto-generated method stub
			return PAGETYPE_PAYLOAD;
		}

		
		public String toString()
		{
			return String.format("<PayloadPage pid=%d payload=%d>", pageId, payloadPageId);
		}


		
	}
	
	class DataPage extends  PageBase
	{

		public DataPage(int pageId) {
			super(pageId);
			// TODO Auto-generated constructor stub
		}
		
		
		public byte getPageType() {
			// TODO Auto-generated method stub
			return PAGETYPE_DATA;
		}
	
		public String toString()
		{
			return String.format("<DataPage pid=%d payload=%d>", pageId, payloadPageId);
		}
	}
	
	class PageBase implements IPage
	{
		
		public int pageId = 0;
		public int payloadPageId = 0;
		
		public PageBase(int pageId)
		{
			this.pageId = pageId;
			
		}	
	

		public byte getPageType()
		{
			// TODO Auto-generated method stub
			return 0;
		}

		public int getPageId() {
			// TODO Auto-generated method stub
			return pageId;
		}

		public int getPayloadPageId() {
			// TODO Auto-generated method stub
			return payloadPageId;
		}
		
		
		public String toString()
		{
			return String.format("<DataPage pid=%d payload=%d>", pageId, payloadPageId);
		}



		public void setPayloadPageId(int pid)
		{
			payloadPageId = pid;			
		}



		public byte[] getContentBytes() 
		{
			
			return contentBytes;
		}


		public byte[] contentBytes = null;

		public void setContentBytes(byte[] data)
		{
			this.contentBytes = data;			
		}
		
	}
	
	
	public interface IPage
	{		
		byte getPageType();
		int getPageId();
		int getPayloadPageId();

		void setPayloadPageId(int pid);
	
		byte[] getContentBytes();
		void setContentBytes(byte[] data);
	}
	
	
	class Header
	{
		public int pageCount;
		public int schemaPageId;
		
		public String toString()
		{
			return String.format("<Header pageCount=%d schemaPageId=%d>", pageCount, schemaPageId);
		}
		
	}
	
	
	public class DataWriter extends DataOutputStream
	{

		public DataWriter(OutputStream arg0) {
			super(arg0);
			// TODO Auto-generated constructor stub
		}
		
		public void writeHStrUTF(String text) throws Exception
		{
			byte[] bytes = text.getBytes("UTF8");
			
			int len = bytes.length;
			writeByte((len & 0xff00) >> 8);
			writeByte((len & 0x00ff));
			write(bytes);		
			
		}
		
	}
	
	public class DataReader extends DataInputStream
	{

		public DataReader(InputStream arg0) 
		{
			super(arg0);
			
		}
		
		public String readHStrUTF() throws Exception
		{
			int len = readUInt16();
			
			
			if(len < 1) return "";
			
			
			return new String(readBytes(len), "UTF-8");		
		}
		
		public int readUInt16() throws Exception
		{
			return ((readByte() & 0xff) << 8) | (readByte() & 0xff);
		}

		
		public byte[] readBytes(int count)  throws Exception
		{
			byte[] data = new byte[count];
			int length = 0;
			while(length < count)
			{
				data[length++] = readByte();		
			}
			
			return data;
			
		}
		
	}
	

}
