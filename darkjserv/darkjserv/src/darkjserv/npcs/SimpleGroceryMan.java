package darkjserv.npcs;

import java.util.ArrayList;
import java.util.List;

import darkjserv.GameEnums;
import darkjserv.IAnimationSyncSet;
import darkjserv.GameTemplateEnums;
import darkjserv.IGameObj;
import darkjserv.InteractiveCodes;

public class SimpleGroceryMan implements IGameObj
{
	
	public long objId = 0;
	public int mapId = 0;
	public int x = 0;
	public int y = 0;
	public byte direction = 0;
	
	public String name = "";
	
	public SimpleGroceryMan(long objId,  String name)
	{
		this.objId = objId;
		
		this.name = name;
		
	}

	public long getObjId()
	{
		// TODO Auto-generated method stub
		return objId;
	}

	public int getX() {
		// TODO Auto-generated method stub
		return x;
	}

	public int getY() {
		// TODO Auto-generated method stub
		return y;
	}

	public int getTemplateId() {
		// TODO Auto-generated method stub
		return GameTemplateEnums.TC_OLDMAN01;
	}

	public byte getDirection() {
		// TODO Auto-generated method stub
		return direction;
	}

	public String getName() {
		// TODO Auto-generated method stub
		return name;
	}
	
	public List<Byte> getInteractiveCodes()
	{
		
		List<Byte> codes = new ArrayList<Byte>();
		codes.add(InteractiveCodes.SHOP);
		
		// TODO Auto-generated method stub
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
	
	public boolean isReleased = false;

	public boolean getIsReleased() {
		// TODO Auto-generated method stub
		return isReleased;
	}

	public void appendExp(int value) {
		// TODO Auto-generated method stub
		
	}

	public void setX(int value) {
		x = value;
		
	}

	public void setY(int value) {
		y = value;
		
	}
	
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
