package darkjserv;

import darkjserv.magics.IMagicBuff;

public interface IInteractiveDelegate 
{

	void appendExp(int value) throws Exception;
	
	void doAttack(IGameCharacter fromObj, AttackDamageValue damageValue) throws Exception;
	void doMagicAttack(IGameCharacter fromObj, int damage) throws Exception;
	
	void addMagicBuff(IMagicBuff buff) throws Exception;
	
}
