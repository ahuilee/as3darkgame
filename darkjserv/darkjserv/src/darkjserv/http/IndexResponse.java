package darkjserv.http;

import java.io.OutputStream;

import darkjserv.http.SimpleHttpServer.Request;

public class IndexResponse implements IResponse
{
	
	public Request request = null;
	
	public IndexResponse(Request request)
	{
		this.request = request;
	}
	
	



	public void execute(OutputStream outputStream) throws Exception 
	{
		// TODO Auto-generated method stub
		
		String servHost = request.host;
		long t = System.currentTimeMillis();
		
		String mainSWF = String.format("main.swf?t=%d", t);
		
		String content = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
				+ "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"zh-TW\" xml:lang=\"zh-TW\">"
				+ "<head>"
				+ "<title>main</title>"
				+ "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />"
				+ "<style type=\"text/css\" media=\"screen\">"
				+ "html, body { height:100%; background-color: #333333;}" 
				+ "body { margin:0; padding:0; overflow:hidden; }"
				+ "#flashContent { width:100%; height:100%; }"
				+ "</style>"
				+ "</head>"
				+ "	<body>"
				
				+ "<div id=\"flashContent\">"
				
				+ "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" width=\"100%\" height=\"100%\" id=\"main\" align=\"middle\">"
				+ "<param name=\"movie\" value=\"" + mainSWF + "\" />"
				+ "<param name=\"quality\" value=\"high\" />"
				+ "<param name=\"bgcolor\" value=\"#333333\" />"
				+ "<param name=\"play\" value=\"true\" />"
				+ "<param name=\"loop\" value=\"true\" />"
				+ "<param name=\"wmode\" value=\"window\" />"
				+ "<param name=\"scale\" value=\"showall\" />"
				+ "<param name=\"menu\" value=\"true\" />"
				+ "<param name=\"devicefont\" value=\"false\" />"
				+ "<param name=\"salign\" value=\"\" />"
				+ "<param name=\"allowScriptAccess\" value=\"sameDomain\" />"
				+ "	<!--[if !IE]>-->"
				+ "<object type=\"application/x-shockwave-flash\" data=\"main.swf\" width=\"100%\" height=\"100%\">"
				+ " <param name=\"movie\" value=\"" + mainSWF + "\" />"
				+ "<param name=\"quality\" value=\"high\" />"
				+ "<param name=\"bgcolor\" value=\"#333333\" />"
				+ "<param name=\"play\" value=\"true\" />"
				+ "<param name=\"loop\" value=\"true\" />"
				+ "<param name=\"wmode\" value=\"window\" />"
				+ "<param name=\"scale\" value=\"showall\" />"
				+ "<param name=\"menu\" value=\"true\" />"
				+ "<param name=\"devicefont\" value=\"false\" />"
				+ "<param name=\"salign\" value=\"\" />"
				+ "<param name=\"allowScriptAccess\" value=\"sameDomain\" />"
				+ "<param name=\"FlashVars\" value=\"serv=" + servHost + "\" />"
				+ "<!--<![endif]-->"
				+ "<a href=\"http://www.adobe.com/go/getflash\">"
				+ "<img src=\"http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif\" alt=\"取得 Adobe Flash 播放程式\" />"
				+ "</a>"
				+ "<!--[if !IE]>-->"
				+ "</object>"
				+ "<!--<![endif]-->"
				+ "</object>"
				+ "</div>"
				+ "</body>"
				+ "</html>"
				;
		
		
		byte[] contentBytes = content.getBytes("UTF-8");
		
		
		String header = "HTTP/1.1 200 OK\r\n" +
		"Content-Type: text/html\r\n" +
		String.format("Content-Length: %d\r\n", contentBytes.length) +
		"\r\n";
		
		outputStream.write(header.getBytes());
		outputStream.write(contentBytes);
		outputStream.flush();
		
	}
	

}
