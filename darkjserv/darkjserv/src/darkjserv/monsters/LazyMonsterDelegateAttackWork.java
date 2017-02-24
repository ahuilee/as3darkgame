package darkjserv.monsters;

import java.awt.Point;
import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import darkjserv.IGameCharacter;
import darkjserv.IGameMonster;
import darkjserv.Utils;
import darkjserv.monsters.LazyMonsterDelegate.WalkToState;
import darkjserv.net.GamePlayer;


public class LazyMonsterDelegateAttackWork 
{

	
	public IGameCharacter targetObj = null;	
	public LazyMonsterDelegate delegate = null;
	public boolean targetInViewBound = true;
	int updateWidth = 2048;
	int updateHeight = 2048;
	
	public LazyMonsterDelegateAttackWork(LazyMonsterDelegate delegate, IGameCharacter targetObj)
	{
		this.delegate = delegate;
		this.targetObj = targetObj;
	}
	
	public void run() throws Exception
	{
		

		delegate.state = LazyMonsterDelegate.STATE_ATTACK;
		//int x1 = monster.getX();
		//int y1 = monster.getY();
		
		//Rectangle viewBound = new Rectangle(x1 -updateWidth/2, y1-updateHeight/2, updateWidth, updateHeight);
		
		System.out.println(String.format(">> runAttack %s", targetObj));
		
		boolean isMoveTo = moveToObj();

		if(isMoveTo)
		{
			
			
			delegate.onAttackTarget(targetObj);			
			
		}
		
	}
	

	
	private boolean _moveToObj( )
	{
		IGameMonster monster = delegate.monster;		
	
		int beginX = monster.getX();
		int beginY = monster.getY();	
		
		Point move2Pt = getMovePt();
		

		if(beginX == move2Pt.x && beginY == move2Pt.y) return true;
		
		int targetX = targetObj.getX();
		int targetY = targetObj.getY();	
		
		

		WalkToState walkState = delegate.updateWalkToPlayers(beginX, beginY, move2Pt.x, move2Pt.y, 0,  false);
		
		System.out.println(String.format("Attack MoveTo %s duration=%d players=%d", move2Pt, walkState.duration, walkState.players.size()));
		
		long t1 = System.currentTimeMillis();
		
		int changeX = move2Pt.x - beginX;
		int changeY = move2Pt.y - beginY;
		
		int attackBoundSize = monster.getAttackBoundSize();
		
		boolean isDone = false;
		
		int waitEventTime = 1000 / 5;	
		
		
		int duration = walkState.duration;
		int viewBoundSize = delegate.viewBoundSize;
		
		if(duration < 1)
		{			
			delegate.updateSyncStand();
				
			return true;
		}
		
		for(int i=0; i<512; i++)
		{		

			
			long time = System.currentTimeMillis() - t1;
			
			if(time > duration)
			{
				time = duration;
				isDone = true;
			}
			
			int x2 = (int)(changeX * time / duration + beginX);
			int y2 = (int)(changeY * time / duration + beginY);	
			
			monster.setX(x2);
			monster.setY(y2);	
			
			//System.out.println(String.format("Attack MoveTo x2=%d, y2=%d", x2, y2)); 
			
			if(isDone)
			{
				delegate.updateSyncStand();
				return true;
			}
			
			//int x3 = monster.getX();
			//int y3 = monster.getY();
			
			int curTargetX = targetObj.getX();
			int curTargetY = targetObj.getY();
			
			
			Rectangle viewBound = new Rectangle(x2 -viewBoundSize/2, y2-viewBoundSize/2, viewBoundSize, viewBoundSize);
			
			if(!viewBound.contains(curTargetX, curTargetY))
			{
				delegate.updateSyncStand();
				return false;
			}
			
			if(targetObj.getMapId() != monster.getMapId())
			{
				return false;
			}
			
			Rectangle attackBound = new Rectangle(x2-attackBoundSize/2, x2-attackBoundSize/2, attackBoundSize, attackBoundSize);
			
			if(attackBound.contains(curTargetX, curTargetY))
			{
				delegate.updateSyncStand();
				return true;
			}			
			/*
			List<GamePlayer> players = delegate.factory.hitPlayerViewsByRect(viewBound);
			for(GamePlayer p : players)
			{
				if(!walkState.players.contains(p))
				{
					System.out.println(String.format("FindPlayer!!!! %s", p));
				}
			}			
			*/
			delegate.waitEvent(waitEventTime);		
			if(delegate.monster.getIsDead())
			{
				breakOuterLoop = true;
				return false;
			}
			
			if(delegate.state != LazyMonsterDelegate.STATE_ATTACK)
			{
				breakOuterLoop = true;
				return false;
			}
			
			if(curTargetX != targetX || curTargetY != targetY)
			{
				int delta = Math.abs(curTargetX - targetX) + Math.abs(curTargetY - targetY) ;
				//return false;
				
				if(delta > 512)
				{
					delegate.updateSyncStand();
					System.out.println(String.format("Attack Player pt changed %d, %d", curTargetX, curTargetY));
					return false;
					//
					
				}
			}
				
				
		}
		
		System.out.println(String.format("%s _moveToObj loop over", monster ));
		
		delegate.updateSyncStand();
		
		return false;
	}
	
	public Point getMovePt()
	{
		IGameMonster monster = delegate.monster;
		
		int x1 = monster.getX();
		int y1 = monster.getY();
		
		int targetX = targetObj.getX();
		int targetY = targetObj.getY();
		
		ArrayList<OrderPt> pts = new ArrayList<OrderPt>();
		
		int sizeHalf = monster.getAttackBoundSize() / 2;
		
		pts.add(new OrderPt(targetX-sizeHalf, targetY-sizeHalf, x1, y1));
		pts.add(new OrderPt(targetX-sizeHalf, targetY+sizeHalf, x1, y1));
		
		pts.add(new OrderPt(targetX+sizeHalf, targetY-sizeHalf, x1, y1));
		pts.add(new OrderPt(targetX+sizeHalf, targetY+sizeHalf, x1, y1));
		
		Collections.sort(pts);
		/*
		for(OrderPt pt : pts)
		{
			System.out.println(String.format("order pt=%d, %d dist=%d", pt.x, pt.y, pt.dist));
		}
		*/
		OrderPt first = pts.get(0);
		
		return new Point(first.x, first.y);
	}
	
	static int calcPtDist(int x1, int y1, int x2, int y2)
	{
		return (int)(Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2)));
	}
	
	class OrderPt implements Comparable<OrderPt>
	{
		public int x = 0;
		public int y = 0;
		public int dist = 0;
		
		public OrderPt(int x, int y, int x1, int y1)
		{
			this.x = x;
			this.y = y;				
			
			this.dist = calcPtDist(x, y, x1, y1);
			
		}

		public int compareTo(OrderPt arg0) {
			//System.out.println(String.format("OrderPt compareTo=%d", dist, arg0.dist));
			
			if(dist > arg0.dist) return 1;
			if(dist < arg0.dist) return -1;
			
			return 0;
		}
	}
	
	private boolean breakOuterLoop = false;
	
	
	public boolean moveToObj()
	{
		
		IGameMonster monster = delegate.monster;
		
		int viewBoundSize = delegate.viewBoundSize;
		int attackBoundSize = monster.getAttackBoundSize();
		
		breakOuterLoop = false;
		
		for(int i=0; i<4096; i++)
		{
			if(breakOuterLoop)
			{
				return false;
			}			
			
			System.out.println(String.format("moveToObj outer loop %d", i));
			
			if(targetObj.getMapId() != monster.getMapId())
			{
				return false;
			}
			
			int x1 = monster.getX();
			int y1 = monster.getY();
			
			int targetX = targetObj.getX();
			int targetY = targetObj.getY();			
			
			Rectangle viewBound = new Rectangle(x1 -viewBoundSize/2, y1-viewBoundSize/2, viewBoundSize, viewBoundSize);		
			Rectangle attackBound = new Rectangle(x1-attackBoundSize/2, y1-attackBoundSize/2, attackBoundSize, attackBoundSize);
			
			
			if(!viewBound.contains(targetX, targetY))
			{
				targetInViewBound = false;
				System.out.println(String.format("Attack moveToObj not in viewbound %s monster=%d, %d target=%d, %d", viewBound, x1, y1, targetX, targetY));
				
				delegate.updateSyncStand();
				return false;
			}
			
			System.out.println(String.format("Attack moveToObj attackBound hit %s, %s", attackBound, attackBound.contains(targetX, targetY)));
		
			if(attackBound.contains(targetX, targetY))
			{
				System.out.println("Attack moveToObj attackBound hit");
				return true;
			}			
			
			//System.out.println(String.format("updateWalkToPlayers %s %d,%d direction2=%d rot2=%.2f", monster, x1, y1, direction2, rot2));
			
			boolean moveTo = _moveToObj();
			
			if(moveTo)
			{
				return true;
			}			
			
		}
		
		return false;			
	}

	public boolean isCanceled()
	{		
		if(targetObj == null) return true;
		if(!targetInViewBound) return true;
		if(targetObj.getIsDead()) return true;
		if(targetObj.getIsReleased()) return true;
		if(targetObj.getMapId() != delegate.monster.getMapId()) return true;
		
		return false;
	}
}
