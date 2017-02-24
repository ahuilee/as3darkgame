package darkjserv.monsters;

import darkjserv.IGameMonster;

public interface IMonsterDelegate 
{
	
	IGameMonster getMonster();
	
	void setMoveBound(int x, int y, int width, int height);
	
	void startAI();

}
