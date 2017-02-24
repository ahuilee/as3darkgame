package darkjserv.monsters;

import java.util.ArrayList;
import java.util.List;

import darkjserv.GameEnums;
import darkjserv.IAnimationSyncSet;
import darkjserv.IGameMonster;
import darkjserv.IInteractiveDelegate;
import darkjserv.InteractiveCodes;


public class SimpleMonster implements IGameMonster
{
	public long objId = 0;
	
	public int x = 0;
	public int y = 0;
	public byte direction = 0;	
	public int hp = 0;
	public int mp = 0;
	public int npcStr = 8;
	public int npcInt = 32;
	
	public String name = "";
	public int templateId = 0;
	
	public int appendExpValue = 100;
	
	public SimpleMonster(long objId, int templateId, String name)
	{
		this.objId = objId;
		this.templateId = templateId;
		this.name = name;
	}

	public long getObjId() 
	{
		return objId;
	}

	public int getX() 
	{
		return x;
	}

	public int getY() 
	{
		return y;
	}

	public int getTemplateId() 
	{
		return templateId;
	}

	public byte getDirection() {
		// TODO Auto-generated method stub
		return direction;
	}
	
	public String toString()
	{
		return String.format("<SimpleWolf pt=%d, %d id=%d >", x, y, objId);
	}

	public String getName() {
		// TODO Auto-generated method stub
		return name;
	}

	public void setX(int value) 
	{
		x = value;		
	}

	public void setY(int value) 
	{
		y = value;		
	}


	public void setDirection(byte value) 
	{
		// TODO Auto-generated method stub
		direction = value;
	}

	
	public short dex = 16;

	public int getDex() 
	{
		// TODO Auto-generated method stub
		return dex;
	}

	public int getMoveSpeed()
	{
		// TODO Auto-generated method stub
		return (short)dex;
	}

	public int getHp() 
	{
		// TODO Auto-generated method stub
		return hp;
	}
	
	public void setHp(int value) 
	{
		hp = value;
		
		if(hp > maxHp)
		{
			mp = maxHp;
		}
	}
	
	public int maxHp = 0;
	public void setMaxHp(int value)
	{
		maxHp = value;
	}
	
	public int getMaxHp()
	{
		return maxHp;
	}
	
	
	public int getMp() 
	{
		// TODO Auto-generated method stub
		return mp;
	}

	public void setMp(int value) 
	{
		mp = value;
		if(mp > maxMp)
		{
			mp = maxMp;
		}
	}
	
	
	public int maxMp = 0;
	public void setMaxMp(int value)
	{
		maxMp = value;
	}
	
	public int getMaxMp()
	{
		return maxMp;
	}
	
	
	public boolean isDead = false;

	public void setDead() 
	{
		isDead = true;
	}

	public boolean getIsDead()
	{
		
		return isDead;
	}

	public List<Byte> getInteractiveCodes()
	{
		
		List<Byte> codes = new ArrayList<Byte>();
		
		if(!isDead)
		{
			codes.add(InteractiveCodes.ATTACK);
		}
		
		
		return codes;
	}
	
	
	private IAnimationSyncSet _animationSyncSet = null;
	
	public void setCurrentAnimationSyncSet(IAnimationSyncSet set)
	{
		_animationSyncSet = set;
	}

	public IAnimationSyncSet getCurrentAnimationSyncSet()
	{
		// TODO Auto-generated method stub
		return _animationSyncSet;
	}
	
	private boolean _isReleased = false;
	
	public void setIsReleased(boolean value)
	{
		_isReleased = value;	
	}
	
	public int attackBoundSize = 256;

	public int getAttackBoundSize() {
		// TODO Auto-generated method stub
		return attackBoundSize;
	}

	public boolean getIsReleased() {
		// TODO Auto-generated method stub
		return _isReleased;
	}

	public int getNPCStr() {
		// TODO Auto-generated method stub
		return npcStr;
	}

	public void appendExp(int value)  throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	public int calcCharMagicDamage() 
	{
		// TODO Auto-generated method stub
		return npcInt;
	}
	
	private IInteractiveDelegate _interactiveDelegate = null;
	
	public void setInteractiveDelegate(IInteractiveDelegate delegate)
	{
		_interactiveDelegate = delegate;
	}

	public IInteractiveDelegate getInteractiveDelegate() 
	{
		// TODO Auto-generated method stub
		return _interactiveDelegate;
	}

	public int getAppendExpValue() {
		// TODO Auto-generated method stub
		return appendExpValue;
	}
	
	public int mapId = 0;

	
	public void setMapId(int value)
	{
		mapId = value;
	}

	public int getMapId() {
		// TODO Auto-generated method stub
		return mapId;
	}

	public byte getObjType() {
		// TODO Auto-generated method stub
		return GameEnums.OBJTYPE_CHAR;
	}
	
	

}
