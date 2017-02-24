package darkjserv.monsters;

import java.awt.Rectangle;
import java.util.List;

import darkjserv.AttackDamageValue;
import darkjserv.Factory;
import darkjserv.GameAnimationEnums;
import darkjserv.GameLogic;
import darkjserv.IGameCharacter;
import darkjserv.IGameMonster;
import darkjserv.IGameObj;
import darkjserv.IInteractiveDelegate;
import darkjserv.ISyncDataNode;
import darkjserv.IWork;
import darkjserv.net.GamePlayer;
import darkjserv.net.commands.PlayerDeadCommand;
import darkjserv.net.commands.PlayerHealthUpdateCommand;
import darkjserv.syncs.AnimationSyncSetAnimation;
import darkjserv.syncs.SyncAnimation;
import darkjserv.syncs.SyncObjDead;

public class MonsterAttackWork implements IWork
{
	
	public IGameMonster monster = null;
	public IGameCharacter targetObj = null;
	public Factory factory = null;
	
	public MonsterAttackWork(IGameMonster monster, IGameCharacter targetObj, Factory factory)
	{
		this.monster = monster;
		this.targetObj = targetObj;
		this.factory = factory;
		
	}

	private Object _syncObj = new Object();
	private boolean _isDone = false;
	
	public void waitWorkDone() throws Exception
	{
		synchronized(_syncObj)
		{
			while(!_isDone)
			{
				_syncObj.wait();
			}		
			
		}		
	}
	
	private void setDone() throws Exception
	{
		synchronized(_syncObj)
		{
			_isDone = true;
			_syncObj.notifyAll();			
		}	
	}
	
	public void run() throws Exception
	{
		
		
		
		if(targetObj.getIsDead()) return;
		
		int x1 = monster.getX();
		int y1 = monster.getY();
		int attackBoundSize = monster.getAttackBoundSize() + 128;
		
		Rectangle attackBound = new Rectangle(x1 - attackBoundSize/2, y1-attackBoundSize/2, attackBoundSize, attackBoundSize);
		
		int x2 = targetObj.getX();
		int y2 = targetObj.getY();
		
		
		
		boolean inAttackBound = attackBound.contains(x2, y2);
		
		System.out.println(String.format("MonsterAttackWork run attackBound=%s hit=%s", attackBound, inAttackBound));
		
		if(inAttackBound)
		{

			Rectangle viewBound = new Rectangle(x1 -1024, y1-1024, 2048, 2048);	
	
			List<GamePlayer> players = factory.hitPlayerViewsByRect(monster.getMapId(), viewBound);	
					
			long startTime = System.currentTimeMillis();
			int duration = GameLogic.calcAttackDuration(monster.getDex());
			
		
			long startServTicks = startTime - factory.gameStartTime;
			SyncAnimation syncNode = new SyncAnimation(monster, GameAnimationEnums.ATTACK1, startTime,  startServTicks, duration, 0);
				
			long expiryTime = startTime + duration;
			
			AnimationSyncSetAnimation syncSet = new AnimationSyncSetAnimation(monster, GameAnimationEnums.ATTACK1, startTime,  startServTicks, duration, expiryTime, 0);
			
			monster.setCurrentAnimationSyncSet(syncSet);
			
			System.out.println(String.format("ATTACK startServTicks=%d duration=%d", startServTicks, duration));
			
			for(GamePlayer p : players)
			{
				try
				{
					p.conn.syncQueue.put(monster, syncNode);
				} catch(Exception ex)
				{
				}
					
			}
			
			System.out.println(String.format("Attack! %s", targetObj));
			
			
			if(targetObj instanceof GamePlayer)
			{
				GamePlayer player = (GamePlayer)targetObj;
				
				IInteractiveDelegate delegate = player.getInteractiveDelegate();
				
		
				int damage = GameLogic.calcPhysicalAttack(monster.getNPCStr());
				
				AttackDamageValue damageValue = new AttackDamageValue();
				damageValue.damage = damage;
				delegate.doAttack(monster, damageValue);
				
			
			
			}
		}
		
		setDone();
	}

	public void except(Exception ex) 
	{
		
	}
	
	

}
