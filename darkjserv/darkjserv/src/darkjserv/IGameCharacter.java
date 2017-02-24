package darkjserv;

public interface IGameCharacter extends IGameObj
{
	
	//byte getDirection();
	boolean getIsDead();
	
	void setX(int value);
	void setY(int value);
	void setDirection(byte value);
	
	int getHp();
	void setHp(int value);
	int getMp();
	void setMp(int value);
	
	int getDex();
	int getMoveSpeed();
	
	int calcCharMagicDamage();
	
	IInteractiveDelegate getInteractiveDelegate();
	
	
	

}
