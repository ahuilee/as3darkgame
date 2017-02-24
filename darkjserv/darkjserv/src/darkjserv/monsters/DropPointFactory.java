package darkjserv.monsters;

import java.awt.Point;
import java.awt.geom.AffineTransform;

public class DropPointFactory 
{
	
	
	
	PtSet _ptSet1 = null;
	PtSet _ptSet2 = null;
	PtSet _ptSet3 = null;
	
	public DropPointFactory(int x1, int y1)
	{
			
		
		Point center = new Point(x1, y1);

		_ptSet1 = new PtSet(center, x1 + 32, y1, 60);
		_ptSet2 = new PtSet(center, x1 + 64, y1 + 64, 45);
		_ptSet3 = new PtSet(center, x1 - 192, y1 - 192, 30);
		
		
	}
	

	
	private int _index = 0;
	
	public Point next()
	{
		Point pt = null;
		
		if(_index < 2)
		{
			pt = _ptSet1.next();
		} else {
			
			switch(_index % 2)
			{
				case 0:
					pt = _ptSet2.next();
					break;
				case 1:
					pt = _ptSet3.next();
					break;
			}
		
			
		}
		
		_index++;
		
		return pt;
	}

	
	class PtSet
	{
		double[] pt;
		AffineTransform transform1 = null;
		
		public PtSet(Point center, int x, int y, int rotate)
		{
			pt = new double[] {x, y};
			
			transform1 = AffineTransform.getRotateInstance(Math.toRadians(rotate), center.x, center.y );
		}
		
		public Point next()
		{
			transform1.transform(pt, 0, pt, 0, 1);
			int x2 = (int)pt[0];
			int y2 = (int)pt[1];
			
			return new Point(x2, y2);
		}
		
	}
	
	
}
