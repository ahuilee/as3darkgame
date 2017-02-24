package darkjserv.monsters;

import java.awt.Point;
import java.awt.Rectangle;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;



import darkjserv.AttackDamageValue;
import darkjserv.Factory;
import darkjserv.GameAnimationEnums;
import darkjserv.IGameCharacter;
import darkjserv.IGameMonster;
import darkjserv.IInteractiveDelegate;
import darkjserv.Utils;
import darkjserv.items.CItemGameObjWrap;
import darkjserv.items.ICItem;
import darkjserv.magics.IMagicBuff;
import darkjserv.net.GamePlayer;
import darkjserv.net.commands.RemoveObjCommand;
import darkjserv.syncs.*;


public class LazyMonsterDelegate implements IInteractiveDelegate, IMonsterDelegate
{
	
	public static final byte STATE_WALK = 0;
	public static final byte STATE_ATTACK = 1;
	public static final byte STATE_HURT = 2;
	public static final byte STATE_DEAD = 3;
	
	public Factory factory = null;	
	public IGameMonster monster = null;
	

	
	public byte state = 0;
	
	
	int updateWidth = 2048;
	int updateHeight = 2048;
	
	public boolean attackBack = true;
	public boolean autoFindAttackObj = false;
	
	public Rectangle moveBound = new Rectangle(0, 0, 0, 0);
	
	public LazyMonsterDelegate(IGameMonster monster, Factory factory)
	{
		this.monster = monster;
		
		this.factory = factory;
		
		attackObjs = new HashMap<Long, AttackSet> ();
		
		state = STATE_WALK;
	}
	
	
	
	public void addMagicBuff(IMagicBuff buff) throws Exception
	{
		
	}
	
	
	private void _run()
	{
		try
		{
			
			Thread.sleep(500);
			
			while(true)
			{
				
				
				if(monster.getIsDead())
				{					
					break;
				}
				
				switch(state)
				{
					case STATE_WALK:
						runWalk();
						break;
					case STATE_HURT:
						waitEvent(500);
					case STATE_ATTACK:
						runAttack();
						break;
					
				}

				
			}
			
			//System.out.println(String.format("%s ai loop over isDead=%s", monster, monster.getIsDead()));
			
			Thread.sleep(10000);
			
			released();
			
			
			
		} catch(Exception ex)
		{
			StringWriter sw = new StringWriter();
			
			ex.printStackTrace(new PrintWriter(sw));
			System.out.println(String.format("%s ai %s", monster, sw.toString()));
		}
		
	}
	
	
	
	public HashMap<Long, AttackSet> attackObjs = null;
	
	public class AttackSet	
	{
		
		public IGameCharacter iobj = null;
		public int totalDamage = 0;
	}
	
	
	
	
	public void syncPosition(Rectangle bound)
	{
		
		Rectangle rect1 = new Rectangle(monster.getX() -updateWidth/2, monster.getY()-updateHeight/2, updateWidth, updateHeight);
		Rectangle rect2 = rect1.union(bound);
		
		SyncCharPosition syncNode = new SyncCharPosition(monster);
		
		List<GamePlayer> players = factory.hitPlayerViewsByRect(monster.getMapId(), rect2);
		
		for(GamePlayer p : players)
		{
			p.conn.syncQueue.put(monster, syncNode);
		}
		
	}
	
	
	
	
	public Rectangle calcWalkToViewRect(int x1, int y1, int x2, int y2)
	{
		
		int _x1 = x1 - updateWidth ;
		int _x2 = x1 + updateWidth;
		int _x3 = (int)(x1 + (x2 - x1));
		
		int _y1 = y1 - updateHeight;
		int _y2 = y1 + updateHeight;
		int _y3 = y1 + (y2 - y1);
		
		
		
		int minX = Math.min(_x1, Math.min(_x2, _x3));
		int maxX = Math.max(_x1, Math.max(_x2, _x3));
		
		int minY = Math.min(_y1, Math.min(_y2, _y3));
		int maxY = Math.max(_y1, Math.max(_y2, _y3));
		
		int w = maxX - minX;
		int h = maxY - minY;
		
		Rectangle rect = new Rectangle(minX, minY, w, h);
		
		rect = new Rectangle(x1-1024, y1-1024, 2048, 2048);
		
		return rect;
	}
	
	public class WalkToState
	{		
		public int duration = 0;
		public List<GamePlayer> players = null;
	}
	
	public WalkToState updateWalkToPlayers(int x1, int y1, int x2, int y2, int debugType, boolean showLog)
	{
		
		
		double dist = Math.sqrt(Math.pow(x1-x2, 2) + Math.pow(y1-y2, 2));
		int duration = (int)(dist * 100.0 / monster.getMoveSpeed());
		
		double rot2 = Utils.calcPoint2Rot(x1, y1, x2, y2);
		
		byte direction2 = Utils.calcGameObjDirectionByRot(rot2);
		
		monster.setDirection(direction2);
		
		Rectangle viewBound = calcWalkToViewRect(x1, y1, x2, y2);		
		
		List<GamePlayer> players = factory.hitPlayerViewsByRect(monster.getMapId(), viewBound);
		if(showLog)
		{
			if(players.size() == 0)
				
			{
				System.out.println(String.format("Walk To %s %s NOPlayer=%d", monster, viewBound, players.size()));
				
			}
			//System.out.println(String.format("%s %s updateToPlayers=%d", monster, viewBound, players.size()));
		}
		//IAnimationSyncSet animationSet = new IAnimationSyncSet();
		
		long startTime = System.currentTimeMillis();
		long startServTick = (int)(startTime- factory.gameStartTime);
		AnimationSyncSetWalkTo syncState = new AnimationSyncSetWalkTo(monster, x1, y1, x2, y2, startTime, startServTick, duration, startTime+duration);
		
		monster.setCurrentAnimationSyncSet(syncState);
		
		SyncObjWalkTo syncNode = new SyncObjWalkTo(x1, y1, direction2, x2, y2, startTime, startServTick, duration, debugType);	
		

		for(GamePlayer p : players)
		{
			try
			{
				p.conn.syncQueue.put(monster, syncNode);
				
				if(showLog)
				{
					System.out.println(String.format("%d PutSyncQueue %s %s", monster.getObjId(), p, syncNode));
				}
			} catch(Exception ex)
			{				
			}			
				
		}
		
		WalkToState state =  new WalkToState();
		state.duration = duration;
		state.players = players;
		return state;
		
	}
	
	
	
	private Object _syncObj = new Object();
	
	public void setEvent()
	{
		synchronized(_syncObj)
		{
			_syncObj.notifyAll();
		}
	}
	
	
	
	public void waitEvent(int timeout)
	{
		try
		{
			synchronized(_syncObj)
			{
				_syncObj.wait(timeout);
			}
		} catch(Exception ex)
		{			
		}
	}
	
	private List<WalkItem> randMoveToPoints()
	{
		
		ArrayList<WalkItem> pts = new ArrayList<WalkItem>();	
		
		int x1 = monster.getX();
		int y1 = monster.getY();
		int moveSpeed = monster.getMoveSpeed();
		
		//rightward
		pts.add(new WalkItem(x1 + moveSpeed * 2*10, y1 - moveSpeed*10, (byte)0x02));
		
		//leftward
		pts.add(new WalkItem(x1 - moveSpeed * 2*10, y1 + moveSpeed*10, (byte)0x06));
		
		//backward
		pts.add(new WalkItem(x1 + moveSpeed * 2*10, y1 + moveSpeed*10, (byte)0x04));
		
		//forward
		pts.add(new WalkItem(x1 - moveSpeed * 2*10, y1 - moveSpeed*10, (byte)0x00));
		
		return pts;
	}
	
	class WalkItem
	{
		public Point pt = null;
		public byte direction = 0;
		
		public WalkItem(int x1, int y1, byte direction)
		{
			this.pt = new Point(x1, y1);
			this.direction = direction;
		}
		
		public String toString()
		{
			return String.format("<WalkItem %s %s>", pt, direction);
		}
	}
	
	private WalkItem makeNextWalkTo()
	{
		List<WalkItem> items = randMoveToPoints();
		
		Collections.shuffle(items, Utils.rand);
		
		for(WalkItem item : items)
		{
			
			//System.out.println(String.format("moveBound=%s %s %s", setting.moveBound, item.pt, setting.moveBound.contains(item.pt)));
			
			if(moveBound.contains(item.pt))
			{
				return item;
			}
		}
		
		
		return null;
	}
	
	long lastFindAttackTime = 0;
	
	public void doWalkStep() 
	{
		if(autoFindAttackObj)
		{
			long now = System.currentTimeMillis() ;
			long delta = now - lastFindAttackTime;
			
		
			if(delta > 1000) {
				findAttack();
				lastFindAttackTime = now;
			}
		}
	}
	
	
	
	
	private void doWalk(WalkItem item)
	{
		int x1 = monster.getX();
		int y1 = monster.getY();
		//System.out.println(String.format("Walk x2=%d, y2=%d", x2, y2));		
		//System.out.println(String.format("makeNextPoint=%s duration=%d", item, duration));
		
		
		
		WalkToState walkState = updateWalkToPlayers(x1, y1,  item.pt.x, item.pt.y, 0, false);
		
		long t1 = System.currentTimeMillis();
		
		int changeX = item.pt.x - x1;
		int changeY = item.pt.y - y1;
		
		boolean isDone = false;
		
		for(int i=0; i<1024; i++)
		{		
			
			long time = System.currentTimeMillis() - t1;
			
			if(time > walkState.duration)
			{
				time = walkState.duration;
				isDone = true;
			}
			
			int x2 = (int)(changeX * time / walkState.duration + x1);
			int y2 = (int)(changeY * time / walkState.duration + y1);			

			monster.setX(x2);
			monster.setY(y2);	
			
			if(isDone)
			{
				break;
			}
			
			waitEvent(1000 / 8);
			
			doWalkStep();
			
			
			
			if(state != STATE_WALK) break;
			
		}
		
	}
	
	public void released()
	{
		factory.removeGameObj(monster);
		
		monster.setIsReleased(true);
		
		//System.out.println(String.format("ai released=%s", monster));
		
		Rectangle rect = new Rectangle(monster.getX()-1024, monster.getY()-1024, 2048, 2048);
		
		List<GamePlayer> inViewPlayers1 = factory.hitPlayerViewsByRect(monster.getMapId(), rect);
		
		if(inViewPlayers1.size() > 0)
		{
			
			List<Long> removePks = new ArrayList<Long>();
			removePks.add(monster.getObjId());
			
			
			for(GamePlayer p : inViewPlayers1)
			{
				try {
		
					RemoveObjCommand syncCmd = new RemoveObjCommand(removePks);
			
					p.conn.writeCommand(syncCmd);
				} catch(Exception ex)
				{
					
				}
			}
		}
	}
	
	public void updateSyncHurt()
	{
		
		if(monster.getIsDead()) return;
		
		int duration = 500;
		long startTime = System.currentTimeMillis();
		long startServTick = startTime - factory.gameStartTime;
		AnimationSyncSetAnimation syncSet = new AnimationSyncSetAnimation(monster, GameAnimationEnums.HURT1, startTime, startServTick, duration, startTime+duration, 1);
		
		monster.setCurrentAnimationSyncSet(syncSet);
		
		List<GamePlayer> players = factory.hitPlayerViews(monster.getMapId(), monster.getX(), monster.getY());
		
		SyncAnimation syncStand = new SyncAnimation(monster, GameAnimationEnums.HURT1, startTime, startServTick, duration, 1);
		
		for(GamePlayer p : players)
		{
			try {
	
				
		
				//System.out.println(String.format("updateStateStand %s", p));
				
				p.conn.syncQueue.put(monster, syncStand);
			} catch(Exception ex)
			{
				
			}
		}
	}
	
	public void updateSyncStand()
	{
		
		if(monster.getIsDead()) return;
		
		long startTime = System.currentTimeMillis();
		
		AnimationSyncSetStand syncSet = new AnimationSyncSetStand(monster, startTime, 0);
		
		monster.setCurrentAnimationSyncSet(syncSet);
		
		List<GamePlayer> inViewPlayers1 = factory.hitPlayerViews(monster.getMapId(), monster.getX(), monster.getY());
		
		SyncObjStand syncStand = new SyncObjStand(monster, startTime, 0);
		
		for(GamePlayer p : inViewPlayers1)
		{
			try {
	
				
		
				//System.out.println(String.format("updateStateStand %s", p));
				
				p.conn.syncQueue.put(monster, syncStand);
			} catch(Exception ex)
			{
				
			}
		}
	}
	
	
	public void runWalk() throws Exception
	{
		updateSyncStand();
		
		waitEvent(Utils.rand.nextInt(10) * 500 + 2000);
		
		if(state != STATE_WALK) return;
		
		WalkItem walk = makeNextWalkTo();				
		//System.out.println(String.format("walk=%s", walk));
		
		if(walk != null)
		{
			doWalk(walk);			
			
		}
	}
	
	
	
	Thread _thread = null;
	
	
	public void startAI()
	{
		if(_thread == null)
		{
			_thread = new Thread(new Runnable()
			{
	
				public void run() {
					_run();
					
				}
			});
			
			_thread.start();
		
		}
	}


	
	
	class DefaultDropItemDelegate implements IMonsterDropItemDelegate
	{

		public List<ICItem> makeDropItems()
		{
			DropItemFactory dropFactory = new DropItemFactory();
			
			ArrayList<ICItem> items = new ArrayList<ICItem> ();
			
			items.add(dropFactory.randCoin(100, 500));
			
			/*
			if(Utils.rand.nextInt(1000) > 500)
			{
				items.add(dropFactory.randWeapon1());
			
			}*/
			
			return items;
		}
		
	}
	
	private IMonsterDropItemDelegate _dropItemDelegate = null;
	public void setDropItemDelegate(IMonsterDropItemDelegate delegate)
	{
		_dropItemDelegate = delegate;
	}
	
	public IMonsterDropItemDelegate getDropItemDelegate()
	{
		if(_dropItemDelegate != null)
		{
			return _dropItemDelegate;
		}
		
		
		return new DefaultDropItemDelegate();
	}
	

	public void onMonsterDeadAndDropItems(List<GamePlayer> viewPlayers)
	{
		
		
		
		
		//System.out.println(String.format("createMonster hitPlayers=%s", hitPlayers.size()));
		IMonsterDropItemDelegate dropDelegate = getDropItemDelegate();
		
		int x1 =  monster.getX();
		int y1 = monster.getY();
		
	
		
		DropPointFactory dropPoints = new DropPointFactory(x1, y1);
		
		List<ICItem> dropItems = dropDelegate.makeDropItems();
		
		long expiryTime = System.currentTimeMillis() + 60000 * 5;
		
		for(ICItem item : dropItems)
		{
			
			CItemGameObjWrap itemObj = new CItemGameObjWrap(factory.makeObjId(), item, expiryTime);
			
			itemObj.setMapId(monster.getMapId());
			
			
			byte randDir = (byte)Utils.rand.nextInt(8);
			itemObj.setDirection(randDir);
			
			Point pt2 = dropPoints.next();
			
			
			itemObj.setX(pt2.x);
			itemObj.setY(pt2.y);

			
			factory.addGameObj(itemObj);
			
			System.out.println(String.format("down item = %s", itemObj));
			
			SyncCharPosition syncNode = new SyncCharPosition(itemObj);
			
			
			for(GamePlayer p : viewPlayers)
			{
				try
				{
					p.conn.syncQueue.put(itemObj, syncNode);
				} catch(Exception ex)
				{
					
				}
				
			}
		}
		
	}



	public void appendExp(int value) throws Exception {
		// TODO Auto-generated method stub
		
	}



	public int viewBoundSize = 4096;
	private LazyMonsterDelegateAttackWork attackWork = null;
	
	public void runAttack() throws Exception
	{
		int x1 = monster.getX();
		int y1 = monster.getY();
		
		Rectangle viewBound = new Rectangle(x1 -viewBoundSize/2, y1-viewBoundSize/2, viewBoundSize, viewBoundSize);
		
		if(attackWork == null || attackWork.isCanceled())
		{
			
			if(attackWork != null)
			{
				System.out.println(String.format("Monster AttackObj attackWork.isCanceled()=%s", attackWork.isCanceled()));

			}			
			
			attackWork = null;
			state = STATE_WALK;		
			
			
			for(AttackSet atk : attackObjs.values())
			{
				if(atk.iobj != null && !atk.iobj.getIsDead())
				{
					if( !atk.iobj.getIsReleased() && monster.getMapId() == atk.iobj.getMapId() && viewBound.contains(atk.iobj.getX(), atk.iobj.getY()))
					{
						attackWork = new LazyMonsterDelegateAttackWork(this, atk.iobj);
						state = STATE_ATTACK;
						break;
					}
				}
			}			
			
		}
		
		if(attackWork == null)
		{	
			state = STATE_WALK;
			
			updateSyncStand();		
			
			return;
		}	
		
					
		attackWork.run();
			
		
	}
	
	
	public void findAttack() 
	{
		
		//主動攻擊 尋找目標
		synchronized(attackObjs)
		{
			int x1 = monster.getX();
			int y1 = monster.getY();
			Rectangle rect = new Rectangle(x1-512, y1-512, 1024, 1024);
			
			List<GamePlayer> players = factory.hitPlayerViewsByRect(monster.getMapId(), rect);
			
			for(GamePlayer p : players)
			{
				AttackSet atkSet = new AttackSet();
				atkSet.iobj = p;
				atkSet.totalDamage = 0;
				attackObjs.put(p.getObjId(), atkSet);	
				
				state = STATE_ATTACK;
			}	
			
		
		}
	}
	
	public void onAttackTarget(IGameCharacter targetObj) throws Exception
	{
		
		MonsterAttackWork atkWork = new MonsterAttackWork(monster, targetObj, factory);
		
		
		//long waitAtkT1 = System.currentTimeMillis();
		factory.attackQueue.put(atkWork);
		atkWork.waitWorkDone();
		//long deltaAtkwork = System.currentTimeMillis() - waitAtkT1;
		
		
		long t1 = System.currentTimeMillis();
		
		waitEvent(1000);
		
		long delta = System.currentTimeMillis() - t1;
		
		
		System.out.println(String.format("onAttackTarget targetObj=%s waitEvent delta=%d", targetObj, delta));
		
		if(delta < 1000)
		{
			System.out.println(String.format("STATE_HURT delta=%d", delta));
			if(state == LazyMonsterDelegate.STATE_HURT)
			{
				
				Thread.sleep(1500 - delta + 500);
			}
		}
		
	}

	public void setMoveBound(int x, int y, int width, int height)
	{
		moveBound.x = x;
		moveBound.y = y;
		moveBound.width = width;
		moveBound.height = height;
	}

	public IGameMonster getMonster() {
		// TODO Auto-generated method stub
		return monster;
	}


	

	public int reduceHp(int damage) throws Exception
	{
		
		synchronized(attackObjs)
		{
			int hp = monster.getHp();
			
			int lastDamage = damage;
			
			if(lastDamage > hp)
			{
				lastDamage = hp;
			}
			
			hp -= lastDamage;
			
			monster.setHp(hp);
	
			if(hp < 1)
			{
				
				
				System.out.println(String.format("setMonsterDead %s", monster));
				
				//IMonsterDelegate delegate = getMonsterDelegate(iobj);
				
				int x1 = monster.getX();
				int y1 = monster.getY();
				
				Rectangle viewRect = new Rectangle(x1-64, y1-64, 128, 128);
				
				List<GamePlayer> viewPlayers = factory.hitPlayerViewsByRect(monster.getMapId(), viewRect);
				
				long animationStartTime = System.currentTimeMillis();
				
				AnimationSyncSetDead syncSet = new AnimationSyncSetDead(monster, animationStartTime);
				
				SyncObjDead syncDead = new SyncObjDead(monster, animationStartTime);
				
				monster.setDead();		
				//delegate.setEvent();		
				monster.setCurrentAnimationSyncSet(syncSet);
				
				for(GamePlayer p : viewPlayers)
				{			
					try
					{			
						p.conn.syncQueue.put(monster, syncDead);
					} catch(Exception ex)
					{
						
					}
				}	
				
				List<AttackSet> lastAtkSets = new ArrayList<AttackSet>();
				
				Rectangle rect = new Rectangle(x1-1024, y1-1024, 2048, 2018);
				
				int allPlayerDamage = 0;
				
				for(AttackSet atkSet : attackObjs.values())
				{
					IGameCharacter iobj = atkSet.iobj;
					
					if(rect.contains(iobj.getX(), iobj.getY()))
					{
						lastAtkSets.add(atkSet);
						
						allPlayerDamage += atkSet.totalDamage;
					}
				
				}
				
				int allExp = monster.getAppendExpValue();
				
				for(AttackSet atkSet : lastAtkSets)
				{
					IGameCharacter fromObj = atkSet.iobj;
					
					int appendExp = allExp * atkSet.totalDamage / allPlayerDamage;
					
					System.out.println(String.format("Shared exp %s = %d", fromObj, appendExp));
					
					fromObj.getInteractiveDelegate().appendExp(appendExp);
				}
				
				onMonsterDeadAndDropItems(viewPlayers);
			}
		
			
			return lastDamage;
		}

	}
	
	private void setAttackSet(IGameCharacter fromObj, int damage)
	{
		long objId = fromObj.getObjId();
		AttackSet atkSet = null;
		if(attackObjs.containsKey(objId))
		{
			atkSet = attackObjs.get(objId);
		}
		
		if(atkSet == null)
		{
			atkSet = new AttackSet();
			atkSet.iobj = fromObj;
			atkSet.totalDamage = 0;
			attackObjs.put(objId, atkSet);
		}
		
		int hp = monster.getHp();
		if(damage > hp)
		{
			damage = hp;
		}
		
		atkSet.totalDamage += damage;
	}
	
	

	public void doMagicAttack(IGameCharacter fromObj, int damage) throws Exception {
		synchronized(attackObjs)
		{
			
			if(monster.getIsDead()) return;
			
			
			int lastDamage = damage;
			
			
			System.out.println(String.format("doMagicAttack %s lastDamage=%d", fromObj, lastDamage));
			
			
			setAttackSet(fromObj, lastDamage);	
			reduceHp(lastDamage);
			state = STATE_HURT;

			updateSyncHurt();
		
			setEvent();
		}	
		
	}




	public void doAttack(IGameCharacter fromObj, AttackDamageValue damageValue)
			throws Exception {
		// TODO Auto-generated method stub

		synchronized(attackObjs)
		{
			
			if(monster.getIsDead()) return;
			
			
			int lastDamage = damageValue.damage;
			lastDamage += damageValue.magicDamage;
			lastDamage += damageValue.coldDamage;
			lastDamage += damageValue.fireDamage;
			lastDamage += damageValue.lightningDamage;
			lastDamage += damageValue.poisonDamage;
		
			
			
			System.out.println(String.format("doAttack %s lastDamage=%d", fromObj, lastDamage));
			
			
			state = STATE_HURT;
			int damage = reduceHp(lastDamage);
			
			setAttackSet(fromObj, damage);
			
			updateSyncHurt();
		
			setEvent();
		}	
		
	}


}
