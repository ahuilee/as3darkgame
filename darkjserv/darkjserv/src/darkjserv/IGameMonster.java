package darkjserv;



public interface IGameMonster extends IGameCharacter
{


	int getNPCStr();
	
	int getAppendExpValue();
	
	void setDead();
	
	
	int getAttackBoundSize();	

	void setIsReleased(boolean value);
}
