package darkjserv.monsters;



import darkjserv.CSkillEnums;
import darkjserv.Factory;
import darkjserv.ICSkillSet;
import darkjserv.IGameCharacter;
import darkjserv.IGameMonster;
import darkjserv.SkillFactory;
import darkjserv.SkillUseWork;
import darkjserv.Utils;

public class LazyDragonDelegate extends LazyMonsterDelegate
{

	public LazyDragonDelegate(IGameMonster monster, Factory factory) 
	{
		super(monster, factory);
		this.autoFindAttackObj = true;
		// TODO Auto-generated constructor stub
	}
	
	
	public long lastFireTime = 0;
	
	
	public void onAttackTarget(IGameCharacter targetObj) throws Exception
	{
		//System.out.println(String.format("%s ATTACKBACK %s", monster, targetObj));
		
		MonsterAttackWork atkWork = new MonsterAttackWork(monster, targetObj, factory);
		
		factory.attackQueue.put(atkWork);
		atkWork.waitWorkDone();
		
		long fireDelta = System.currentTimeMillis() - lastFireTime;
		
		
		//©ñ¤õ
		if(fireDelta > 10000)
		{
			System.out.println(String.format("Dragon Fire!!"));
			
			ICSkillSet skillSet = SkillFactory.getInstance().getSkillSetById(CSkillEnums.SKILL_DRAGON_FIRE);
			
			
			int dist = 64*4;
			int sx = targetObj.getX() - dist;
			int sy = targetObj.getY() - dist;
			
			for(int ix=0; ix<3; ix++)
			{
				for(int iy=0; iy<3; iy++)
				{
					int dx = Utils.rand.nextInt(256);
					int dy = Utils.rand.nextInt(256);
					
					if(Utils.rand.nextInt(10) < 5)
					{
						dx *= -1;
					}
					
					if(Utils.rand.nextInt(10) < 5)
					{
						dy *= -1;
					}
					
					int sx2 = sx + ix * dist + dx;
					int sy2 = sy + iy * dist + dy;
					
					System.out.println(String.format("sx2=%d sy2=%d", sx2, sy2));
					SkillUseWork skillWork = new SkillUseWork(monster, skillSet, sx2, sy2, factory);
					
					skillWork.run();
					
					Thread.sleep(100);
				}
			
			}
			
			lastFireTime = System.currentTimeMillis();
		}
		

		
		long t1 =  System.currentTimeMillis();
		
		waitEvent(1500);
		
		long delta = System.currentTimeMillis() - t1;
		System.out.println(String.format("STATE_HURT delta=%d", delta));
		if(delta < 1500)
		{
		
			if(state == STATE_HURT)
			{
				
				Thread.sleep(1500 - delta + 500);
			}
		}
	}
	
	
	

}
