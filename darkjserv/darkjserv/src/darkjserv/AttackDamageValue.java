package darkjserv;

public class AttackDamageValue 
{
	
	public int damage = 0;
	public int magicDamage = 0;	
	public int coldDamage = 0;
	public int fireDamage = 0;
	public int lightningDamage = 0;
	public int poisonDamage = 0;
	
	public String toString()
	{
		return String.format("<ATKDamage damage=%d magic=%d cold=%d fire=%d lightning=%d poison=%d>", damage, magicDamage, coldDamage, fireDamage, lightningDamage, poisonDamage);
	}

}
