package darkjserv.commandhandlers;

import java.io.DataInputStream;
import java.util.List;

import darkjserv.Factory;
import darkjserv.GameAnimationEnums;
import darkjserv.GameLogic;
import darkjserv.IGameMonster;
import darkjserv.IGameObj;
import darkjserv.IInteractiveDelegate;
import darkjserv.InteractiveCodes;
import darkjserv.net.*;
import darkjserv.net.commands.PlayerLevelUpdateCommand;
import darkjserv.syncs.AnimationSyncSetAnimation;
import darkjserv.syncs.SyncAnimation;


public class PlayerAttackHandler 
{
	
	public Connection conn = null;
	
	public PlayerAttackHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	
	
	public void handle(int ask, DataInputStream rd) throws Exception
	{
		
		Factory factory = conn.server.factory;
		GamePlayer player = conn.player;
		
		long atkObjId = rd.readLong();
		
		IGameObj atkObj = factory.getGameObj(atkObjId);	
		
	
		
	
		if(atkObj != null && atkObj.getInteractiveCodes().contains(InteractiveCodes.ATTACK))
		{
			if(atkObj instanceof IGameMonster)
			{
				IGameMonster iMonster = (IGameMonster)atkObj;
				
				IInteractiveDelegate  monsterDelegate = iMonster.getInteractiveDelegate();
				
				
				PlayerStatusInfo statusInfo = player.getStatusInfo();
				
				
				
				System.out.println(String.format("attackDamage=%s", statusInfo.attackDamageValue));
				
				monsterDelegate.doAttack(conn.player, statusInfo.attackDamageValue);
				
				
			
				List<GamePlayer> viewPlayers = factory.hitPlayerViews(player.getMapId(), player.getX(), player.getY());	
				
				long startTime = System.currentTimeMillis();
				long startServTick = startTime - factory.gameStartTime;
				
				
				int attackDuration = GameLogic.calcAttackDuration(player.getDex());
				
				
				if(attackDuration < 300)
				{
					attackDuration = 300;
				}
				
				System.out.println(String.format("attack attackDuration=%d", attackDuration));
				// 
				
				AnimationSyncSetAnimation syncSet = new AnimationSyncSetAnimation(player, GameAnimationEnums.ATTACK1, startTime, startServTick, attackDuration, startTime+attackDuration, 0);
				
				SyncAnimation syncNode = new SyncAnimation(player, GameAnimationEnums.ATTACK1, startTime, startServTick, attackDuration, 0);
				
				//
				
				for(GamePlayer p : viewPlayers)
				{
					if(p == player) continue;
					
					p.conn.syncQueue.put(player, syncNode);			
				}
				
				conn.player.setCurrentAnimationSyncSet(syncSet);
				
				
				
				AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
				//writeAnswer(answer);
				conn.putWork(new WriteAnswerWork(answer, conn));
			
			}
		}
		
	}
}
