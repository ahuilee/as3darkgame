package darkjserv;

import java.util.List;

public interface IGameObj 
{
	
	long getObjId();
	
	byte getObjType();
	
	int getMapId();
	void setMapId(int value);
	
	int getX();
	int getY();
	
	void setX(int value);
	void setY(int value);
	
	int getTemplateId();
	byte getDirection();
	String getName();
	
	List<Byte> getInteractiveCodes();
	
	IAnimationSyncSet getCurrentAnimationSyncSet();
	void setCurrentAnimationSyncSet(IAnimationSyncSet syncSet);
	
	boolean getIsReleased();
	
	
}
