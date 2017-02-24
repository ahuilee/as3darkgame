package darkjserv.items;

import java.util.ArrayList;
import java.util.List;

import darkjserv.CItemFactory;
import darkjserv.GameEnums;
import darkjserv.IAnimationSyncSet;
import darkjserv.IGameObj;
import darkjserv.InteractiveCodes;

public class CItemGameObjWrap implements IGameObj
{
	
	public long objId;
	public ICItem item = null;
	
	public int x;
	public int y;
	public long expiryTime;
	
	public CItemGameObjWrap(long objId, ICItem item, long expiryTime)
	{
		this.objId = objId;
		this.item = item;
		
		this.expiryTime = expiryTime;
	}
	
	public void setDirection(byte dir)
	{
		_direction = dir;	
	}
	private byte _direction = 0;
	
	public long getObjId() {
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

	public int getTemplateId() 
	{
		// TODO Auto-generated method stub
		return CItemFactory.getInstance().getSceneTemplateIdByBaseId(item.getItemBaseId());
	}

	public byte getDirection() 
	{
		// TODO Auto-generated method stub
		return _direction;
	}

	public String getName() {
		// TODO Auto-generated method stub
		
		String text = CItemFactory.getInstance().getItemNameByBaseId(item.getItemBaseId());
		
		long count = item.getItemCount();
		
		if(count > 1)
		{
			text = String.format("%s(%d)", text, count);
		}
		
		return text;
	}

	public List<Byte> getInteractiveCodes() 
	{
		List<Byte> codes = new ArrayList<Byte>();
		
		codes.add(InteractiveCodes.TAKE);		
		
		return codes;
	}

	public IAnimationSyncSet getCurrentAnimationSyncSet() 
	{
		// TODO Auto-generated method stub
		return null;
	}

	public void setCurrentAnimationSyncSet(IAnimationSyncSet syncSet) 
	{
		// TODO Auto-generated method stub
		
	}

	public boolean getIsReleased() {
		// TODO Auto-generated method stub
		return false;
	}

	public void setX(int value) {
		x = value;
		
	}

	public void setY(int value) {
		y = value;
		
	}
	
	public String toString()
	{
		return String.format("<GameItem %s>", item);
	}
	
	public int mapId = 0;
	
	public void setMapId(int value) {
		// TODO Auto-generated method stub
		mapId = value;
	}


	public int getMapId() {
		// TODO Auto-generated method stub
		return mapId;
	}

	public byte getObjType() {
		// TODO Auto-generated method stub
		return GameEnums.OBJTYPE_ITEM;
	}

}
