package darkjserv.http;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import darkjserv.http.SimpleHttpServer.Request;

public class RequestHandler 
{
	
	public RequestHandler()
	{
		
	}
	
	
	public static final String CONTENT_TYPE_SWF = "application/x-shockwave-flash";
	
	public IResponse getResponse(Request request)
	{
		
		//System.out.println(request);
		
		if(request.url.equals("/"))
		{
			return new IndexResponse(request);// new HtmlFileResponse("html/main.html");
		}
	
			
		if(request.url.startsWith("/crossdomain.xml"))
		{	
			return new FileResponse("html/crossdomain.xml", "application/xml");
		}
		
		if(request.url.startsWith("/main.swf"))
		{
			return new FileResponse("html/main.swf", CONTENT_TYPE_SWF);
		}
			
		if(request.url.startsWith("/assets.swf"))
		{
			return new FileResponse("html/assets.swf", CONTENT_TYPE_SWF);
		}
		
		if(request.url.startsWith("/base.swf"))
		{
			return new FileResponse("html/base.swf", CONTENT_TYPE_SWF);
		}
		
		if(request.url.startsWith("/icons.swf"))
		{
			return  new FileResponse("html/icons.swf", CONTENT_TYPE_SWF);
		}
		
		
		if(request.url.startsWith("/maps.swf"))
		{
			return new FileResponse("html/maps.swf", CONTENT_TYPE_SWF);
		}
		
		if(request.url.startsWith("/skill_effect.swf"))
		{
			return new FileResponse("html/skill_effect.swf", CONTENT_TYPE_SWF);
		}
		
		if(request.url.startsWith("/sound.swf"))
		{
			return  new FileResponse("html/sound.swf", CONTENT_TYPE_SWF);
		}	
		
		if(request.url.startsWith("/ui.swf"))
		{
			return  new FileResponse("html/ui.swf", CONTENT_TYPE_SWF);
		}
		
		
		ArrayList<String> npcAssets = new  ArrayList<String>();
		
		npcAssets.add("npc001.swf");
		npcAssets.add("npc002.swf");
		npcAssets.add("npc003.swf");
		npcAssets.add("npc031.swf");
		npcAssets.add("npc051.swf");
		npcAssets.add("npc052.swf");
		npcAssets.add("npc053.swf");
		npcAssets.add("npc054.swf");
		
		for(String name : npcAssets)
		{
			String matchUrl = String.format("/assets/%s", name);
			if(request.url.startsWith(matchUrl))
			{
				return  new FileResponse(String.format("html/assets/%s", name), CONTENT_TYPE_SWF);
			}
		}
		
		return null;
	}
	
	
	public void handRequest(OutputStream outputStream, Request request) throws Exception
	{
		
		//System.out.println(String.format("handRequest %s", request));
		
		
				
		try 
		{
		
			IResponse response = getResponse(request);
			
			
			//System.out.println(String.format("getResponse %s", response));
			
			if(response == null)
			{
				throw new Exception(String.format("No Response! %s", request.url));
			}
			
			ByteArrayOutputStream tmpStream = new ByteArrayOutputStream();
		
			response.execute(tmpStream);
			
			outputStream.write(tmpStream.toByteArray());
			
		
		} catch(Exception ex)
		{
			
			
			
			String content = ex.getMessage();
			
			byte[] contentBytes= content.getBytes();
			
			String header = "HTTP/1.1 200 OK\r\n" +
			"Content-Type: text/html\r\n" +
			String.format("Content-Length: %d\r\n", contentBytes.length) +
			"\r\n";
			
			outputStream.write(header.getBytes());
			outputStream.write(contentBytes);
			
			
			System.out.println(ex.getMessage());
		}
		
		
		outputStream.flush();
		
		//System.out.println(String.format("outputStream flush %s", request));
	}
	

}
