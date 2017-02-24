package darkjserv;

public class GameLogic
{
	
	public static int calcPhysicalAttack(int strength)
	{
		int value = strength / 2;
		
		
		return value;		
	}
	
	public static int calcPhysicalDefense(int con)
	{
		int value = con / 8;
		
		
		return value;		
	}
	
	public static int calcAttackDamage(int physicalAttack, int physicalDefense)
	{
		
		int value = physicalAttack - physicalDefense / 2;
		
		
		if(value < 1)
		{
			value = 1;
		}
		
		return value;
	}
	
	public static int calcAttackDuration(int dex)
	{
		int duration = 1000 - (int)(1000 * dex / 8 / 1000.0);		
		
		if(duration < 200)
		{
			duration = 200;
		}		
		
		return duration;
	}
	

}
