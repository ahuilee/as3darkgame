package darkjserv;

import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.List;

import darkjserv.magics.ProtectCoverMagicBuff;
import darkjserv.magics.WeaponFocusMagicBuff;
import darkjserv.net.GamePlayer;
import darkjserv.net.ICommand;
import darkjserv.net.commands.SkillEffectPlayCommand;
import darkjserv.net.commands.SkillEffectPlayFollowCommand;
import darkjserv.syncs.AnimationSyncSetAnimation;
import darkjserv.syncs.SyncAnimation;

public class SkillUseWork 
{
	public IGameCharacter iGameChar = null;
	public ICSkillSet skillSet = null; 
	public Factory factory = null;
	public int targetX = 0;
	public int targetY = 0;
	
	public SkillUseWork(IGameCharacter iGameChar, ICSkillSet skillSet, int targetX, int targetY, Factory factory)
	{
		this.iGameChar = iGameChar;
		this.skillSet = skillSet;
		this.factory = factory;
		
		this.targetX = targetX;
		this.targetY = targetY;
	}
	
	
	
	private List<IGameCharacter> _calcAttackTargets(Rectangle bounds)
	{
		ArrayList<IGameCharacter> output = new ArrayList<IGameCharacter> ();
		
		byte teamNum = 0;
		
		if(iGameChar instanceof IGameMonster)
		{
			teamNum = 1;
		}
		
		List<IGameObj> toObjs = factory.hitGameObjs( iGameChar.getMapId(), bounds);
		
		for(IGameObj iobj : toObjs)
		{
			if(iobj instanceof IGameCharacter)
			{
				IGameCharacter iiobj = (IGameCharacter)iobj;
				
				if(iiobj.getIsDead()) continue;
				
				if(iobj instanceof IGameMonster)
				{
					if(teamNum == 0)
					{
						output.add(iiobj);
					}
				} else
				{
					if(teamNum == 1)
					{
						output.add(iiobj);
					}
				}
				
			}	
		}
		
		
		return output;
	}
	
	
	
	private void _attackMagic() throws Exception
	{
		
		int magicValue = skillSet.getMagicPower();
		
		
		
		int magicDamage = magicValue + magicValue * iGameChar.calcCharMagicDamage() / 8;
		
		Rectangle bounds = skillSet.getBounds();
		
		Rectangle rect = new Rectangle(targetX+bounds.x, targetY+bounds.y, bounds.width, bounds.height);
		
		
		List<IGameCharacter> toObjs = _calcAttackTargets(rect);
		
		for(IGameCharacter targetChar : toObjs)
		{
			
			IInteractiveDelegate delegate = targetChar.getInteractiveDelegate();
				
			//IMonsterDelegate monsterDelegate = factory.getMonsterDelegate(iMonster);
				
			//System.out.println(String.format("skill=>%s magicDamage=%d", targetChar, magicDamage));
				
			delegate.doMagicAttack(iGameChar, magicDamage);
			
		}
	}
	
	private void protectCover() throws Exception
	{
		int magicValue =  skillSet.getMagicPower();		
		int magicDamage = magicValue + magicValue * iGameChar.calcCharMagicDamage() / 8;
		
		long expire = System.currentTimeMillis() + 60000;
		
		ProtectCoverMagicBuff buff = new ProtectCoverMagicBuff(magicDamage, expire);
		
		
		iGameChar.getInteractiveDelegate().addMagicBuff(buff);
		
		System.out.println(String.format("%s", buff));
		
		
		
		
	}
	
	private void weaponFocus() throws Exception
	{
		int magicValue =  skillSet.getMagicPower();		
		int magicDamage = magicValue + magicValue * iGameChar.calcCharMagicDamage() / 8;
		
		long expire = System.currentTimeMillis() + 60000;
		
		WeaponFocusMagicBuff buff = new WeaponFocusMagicBuff(magicDamage, expire);
		
		
		iGameChar.getInteractiveDelegate().addMagicBuff(buff);
		
		System.out.println(String.format("%s", buff));
	}
	
	public boolean run() throws Exception
	{
		
		
		
		int curMp = iGameChar.getMp();		
		int mpCost = skillSet.getMpCost();
		
		
		if(curMp > mpCost)
		{
			
			curMp -= mpCost;
			
			iGameChar.setMp(curMp);
			
			int skillId = skillSet.getSkillId();
			int effectId = skillSet.getEffectId();
			
			//byte targetType = skillSet.getTargetType();
			

			//range magic
			switch(skillId)
			{
				case CSkillEnums.SKILL_001:
					protectCover();
					break;
				case CSkillEnums.SKILL_002:
					weaponFocus();
					break;
			
				
				
				case CSkillEnums.SKILL_006:
				case CSkillEnums.SKILL_007:	
				case CSkillEnums.SKILL_008:	
				case CSkillEnums.SKILL_009:	
				case CSkillEnums.SKILL_010:	
				case CSkillEnums.SKILL_031:
				case CSkillEnums.SKILL_032:
				case CSkillEnums.SKILL_033:
				case CSkillEnums.SKILL_051:
				case CSkillEnums.SKILL_052:
				case CSkillEnums.SKILL_DRAGON_FIRE:
					
					_attackMagic();
					
					
					break;
		
					
			}
	
			
			//int x2 = iGameChar.getX();
			//int y2 = iGameChar.getY();
			
			
			long startTime = System.currentTimeMillis();
			long startServTick = startTime - factory.gameStartTime;
			int attack2Duration = 1000;
			
			AnimationSyncSetAnimation syncSet = new AnimationSyncSetAnimation(iGameChar, GameAnimationEnums.ATTACK2, startTime, startServTick, attack2Duration, startTime+attack2Duration, 0);
			
			SyncAnimation syncNode = new SyncAnimation(iGameChar, GameAnimationEnums.ATTACK2, startTime, startServTick, attack2Duration, 1);
			
			iGameChar.setCurrentAnimationSyncSet(syncSet);
			
			Rectangle viewRect = new Rectangle(targetX-128, targetY-128, 256, 256);
			
			List<GamePlayer> viewPlayers = factory.hitPlayerViewsByRect(iGameChar.getMapId(), viewRect);
			
			
			ICommand effectCmd = null;
			switch(skillSet.getTargetType())
			{
				case CSkillEnums.TARGET_SELF:
				case CSkillEnums.TARGET_SELECT_SINGLE:
					effectCmd = new SkillEffectPlayFollowCommand(effectId, iGameChar.getObjId());
					break;
					
				case CSkillEnums.TARGET_SELECT_POINT:
					effectCmd = new SkillEffectPlayCommand(effectId, targetX, targetY);
					break;
			}
	
			for(GamePlayer p : viewPlayers)
			{
				try 
				{
					
					if(effectCmd != null)
					{
						p.conn.writeCommand(effectCmd);
					}
					
					//if(p)
					
					p.conn.syncQueue.put(iGameChar, syncNode);
					
				} catch(Exception ex)
				{
					
				}
			}
			
			return true;
			
		}
		
		return false;
	}

}
