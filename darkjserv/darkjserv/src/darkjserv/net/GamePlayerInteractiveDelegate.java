package darkjserv.net;


import java.awt.Rectangle;
import java.util.List;

import darkjserv.AttackDamageValue;
import darkjserv.Factory;
import darkjserv.GameAnimationEnums;
import darkjserv.GameEffectEnums;
import darkjserv.IGameCharacter;
import darkjserv.IInteractiveDelegate;
import darkjserv.ISyncDataNode;
import darkjserv.Utils;
import darkjserv.magics.IMagicBuff;
import darkjserv.net.commands.*;
import darkjserv.storages.StorageFactory;
import darkjserv.syncs.SyncAnimation;
import darkjserv.syncs.SyncObjDead;

public class GamePlayerInteractiveDelegate implements IInteractiveDelegate
{
	
	public GamePlayer player = null;
	public Factory factory = null;
	
	public GamePlayerInteractiveDelegate(GamePlayer player, Factory factory)
	{
		this.player = player;
		this.factory = factory;
	
	}
	
	
	public void addMagicBuff(IMagicBuff buff) throws Exception
	{
		this.player.magicBuffList.add(buff);
		
		
		long expireServTicks = buff.getExpireTime() - factory.gameStartTime;
		
		PlayerMagicBuffAddCommand cmd = new PlayerMagicBuffAddCommand(buff.getTypeId(), buff.getTemplateId(), expireServTicks);
		
		player.conn.putWork(new WriteCommandWork(cmd, player.conn));
		
		
		player.clearStatusInfoCache();
	}
	
	
	public void appendExp(int value) throws Exception
	{
		synchronized(_syncObj)
		{
			if(player.getIsDead()) return;
			
			int prevLevel = factory.characterLevelTable.calcCharLevel(player.curExp);
			
			player.curExp += value;
			
			//System.out.println(String.format("appendExp =%d curExp=%d", value, player.curExp));
			
			int curLevel = factory.characterLevelTable.calcCharLevel(player.curExp);
			
			

			if(curLevel > prevLevel)
			{
				int minUpHp = player.charCon;
				int maxUpHp = (int)( player.charCon * 10);
				
				int minUpMp = player.charInt;
				int maxUpMp = (int)( player.charInt * 5);
				
				for(int i=prevLevel; i<curLevel; i++)
				{
					int upHp = Utils.rand.nextInt(maxUpHp - minUpHp) + minUpHp;
					int upMp = Utils.rand.nextInt(maxUpMp - minUpMp) + minUpMp;
					
					player.maxHp += upHp;
					player.maxMp += upMp;
				}				
				
				player.hp = player.maxHp;
				player.mp = player.maxMp;
			}
			
			
			
			int expPercent = factory.characterLevelTable.calcExpPercent(player.curExp);
			
			PlayerLevelUpdateCommand levelUpdateCmd = new PlayerLevelUpdateCommand(curLevel, expPercent, player.getMaxHp(), player.getMaxMp());
			
			player.conn.writeCommand(levelUpdateCmd);
			
			if(curLevel > prevLevel)
			{
				PlayerHealthUpdateCommand heahthUpdateCmd = new PlayerHealthUpdateCommand(player.getHp(), player.getMp());
				player.conn.writeCommand(heahthUpdateCmd);
				
				int targetX = player.getX();
				int targetY = player.getY();
				
				List<GamePlayer> viewPlayers = factory.hitPlayerViews(player.getMapId(), targetX, targetY);
				

				for(GamePlayer p : viewPlayers)
				{
					try 
					{
						SkillEffectPlayFollowCommand cmd = new SkillEffectPlayFollowCommand(GameEffectEnums.SE_007, player.getObjId());
					
						p.conn.writeCommand(cmd);
						
					} catch(Exception ex)
					{
						
					}
				}
				
			}
			
			StorageFactory.getInstance().savePlayer(player);
		
			
		}
		
	}
	
	private Object _syncObj = new Object();
	
	
	
	private void reduceHp(int damage) throws Exception
	{
		synchronized(_syncObj)
		{
			PlayerStatusInfo statusInfo = player.getStatusInfo();
			
			int hp = statusInfo.getHp();	
			
			hp -= damage;
			
	
			boolean isDead = false;
			
			if(hp < 0)
			{
				hp = 0;
				isDead = true;
			}
		
			player.setHp(hp);
			int mp = player.getMp();
		
			PlayerHealthUpdateCommand cmd = new PlayerHealthUpdateCommand(hp, mp);
			
			player.conn.writeCommand(cmd);
		
	
			
			//System.out.println(String.format("%s hp=%d syncHURTNode", this, hp));
			
			ISyncDataNode upSyncNode = null;
			long startTime = System.currentTimeMillis();
			long startServTicks = startTime - factory.gameStartTime;
	
			if(!isDead)
			{
				
				upSyncNode = new SyncAnimation(player, GameAnimationEnums.HURT1, startTime, startServTicks, 300, 0);
				
			} else
			{
				upSyncNode = new SyncObjDead(player, startTime);
				
				PlayerDeadCommand deadCmd = new PlayerDeadCommand();
				player.conn.writeCommand(deadCmd);
				
			
				player.setIsDead(true);
			}		
			
			
			int x1 = player.getX();
			int y1 = player.getY();
			
			Rectangle viewBound = new Rectangle(x1 -1024, y1-1024, 2048, 2048);	
					
			List<GamePlayer> players = factory.hitPlayerViewsByRect(player.getMapId(), viewBound);	
			
		
			if(upSyncNode != null)
			{
				for(GamePlayer p : players)
				{
					try
					{
						p.conn.syncQueue.put(player, upSyncNode);
					} catch(Exception ex)
					{
					}
						
				}
			}
			
			/*
			if(isDead)
			{
				IMapData mapData = factory.getMapDataById(player.mapId);
				
				List<Point> safePts = mapData.getSafePoints();
				Point pt2 = safePts.get(Utils.rand.nextInt(safePts.size()));
				
				player.setX(pt2.x);
				player.setY(pt2.y);
			}*/
			
			
			StorageFactory.getInstance().savePlayer(player);
		
		}
	}
	
	private void attackReduceHp(int damage) throws Exception
	{
		reduceHp(damage);
		
		PlayerHurtSetCommand hurtSet = new PlayerHurtSetCommand();
		
		player.conn.putWork(new WriteCommandWork(hurtSet, player.conn));
		
	}
	
	public void doMagicAttack(IGameCharacter fromObj, int damage)
			throws Exception 
	{
		synchronized(_syncObj)
		{
		
			if(player.getIsDead()) return;
			
			PlayerStatusInfo statusInfo = player.getStatusInfo();
			
		
			int magicDefense = statusInfo.magicDefense;
			
			
			int lastDamage = damage - magicDefense;
			
			if(lastDamage < 1) {
				return;
			}
			
			attackReduceHp(lastDamage);
			
		}
	}

	

	public void doAttack(IGameCharacter fromObj, AttackDamageValue damageValue)
			throws Exception {
		// TODO Auto-generated method stub
		
		synchronized(_syncObj)
		{
		
			if(player.getIsDead()) return;
			
			
			
			PlayerStatusInfo statusInfo = player.getStatusInfo();
			
		
			
			int defense = statusInfo.defense;				
			
			
			//System.out.println(String.format("damage=%d defense=%d defenseBuff=%d", damage, defense, defenseBuff));
			
			int lastDamage = damageValue.damage;
			
			lastDamage += damageValue.magicDamage;
			lastDamage += damageValue.coldDamage;
			lastDamage += damageValue.fireDamage;
			lastDamage += damageValue.lightningDamage;
			lastDamage += damageValue.poisonDamage;
			
			lastDamage = lastDamage - defense;
			
			if(lastDamage < 1) {
				return;
			}
			
			attackReduceHp(lastDamage);
	
		}
		
	}
	

}
