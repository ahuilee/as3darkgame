package darkjserv;

import java.awt.Point;
import java.awt.Rectangle;
import java.util.Random;

public class Utils {

	
	public static Random rand = new Random();
	
	
	public static final int TILE_WIDTH = 64;
	public static final int TILE_HEIGHT = 64;
	
	public static Rectangle TILE_ROT_SIZE;
	public static double TILE_WIDTH_RATIO;
	public static double TILE_HEIGHT_RATIO;
	
	static 
	{
		TILE_ROT_SIZE = calcRotationSize(64, 64);
		TILE_WIDTH_RATIO = TILE_ROT_SIZE.width / (double)TILE_WIDTH;
		TILE_HEIGHT_RATIO = TILE_ROT_SIZE.height / 2.0 / (double)TILE_HEIGHT;
		
		System.out.println(String.format("TILE_ROT_SIZE %s", TILE_ROT_SIZE));
		System.out.println(String.format("TILE_WIDTH_RATIO %.2f TILE_HEIGHT_RATIO %.2f", TILE_WIDTH_RATIO, TILE_HEIGHT_RATIO));
	}
			
			
	
	public static Rectangle calcRotationSize(int width, int height)
	{
		double angle = 45 * Math.PI / 180.0;
		double sin = Math.sin(angle);
		double cos = Math.cos(angle);
		
		
		
		double x1 = cos * TILE_WIDTH;
		double y1 = sin * TILE_WIDTH;
		
		double x2 = -sin*TILE_HEIGHT;
		double y2 = cos * TILE_HEIGHT;
		
		double x3 = cos * TILE_WIDTH - sin* TILE_HEIGHT;
		double y3 = sin * TILE_WIDTH - cos * TILE_HEIGHT;
		
		double minX = Math.min(0, Math.min(x1, Math.min(x2, x3)));
		double maxX = Math.max(0, Math.max(x2, Math.max(x2, x3)));
		
		double minY = Math.min(0, Math.min(y1, Math.min(y2, y3)));
		double maxY = Math.max(0, Math.max(y2, Math.max(y2, y3)));
		
		int rw = (int)(maxX - minX);
		int rh = (int)(maxY - minY);
		
		return new Rectangle(0, 0, rw, rh);
		
	}
			
			
	public static Point calcGamePtToFlashPt(int x1, int y1)
	{
		double x2 = (x1 - y1) *  TILE_WIDTH_RATIO / 2.0;
		double y2 = (y1 + x1) *  TILE_HEIGHT_RATIO / 2.0;
		
		return new Point((int)x2, (int)y2);
	}
	
	public static double calcPoint2Rot(int x1, int y1, int x2, int y2)
	{
		
		Point pt1 = calcGamePtToFlashPt(x1, y1);
		Point pt2 = calcGamePtToFlashPt(x2, y2);
		
		double rot = Math.atan2(pt2.x - pt1.x , pt2.y - pt1.y) / Math.PI * 180.0;
		
		//System.out.println(String.format("calcPoint2Rot %.2f", rot));
		
		return rot;
	}
	
	public static byte calcGameObjDirectionByRot(double rot)
	{
		if(rot <= -165 || rot >= 165)
		{
			return 0;
		}
		
		if(rot >= 110)
		{
			return 1;
		}
		
		if(rot >= 75) 
		{
			return 2;
		}
		
		if(rot >= 35)
		{
			return 3;
		}
		
		if(rot >=0 || rot>=-35)
		{
			return 4;
		}
		
		if(rot >= -75)
		{
			return 5;
		}
		
		if(rot >= -115)
		{
			return 6;
		}
			
			
		
		return 7;
	}
	
}
