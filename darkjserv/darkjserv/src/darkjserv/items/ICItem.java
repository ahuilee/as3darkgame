package darkjserv.items;



public interface ICItem 
{
	
	int getItemId();
	
	int getItemBaseId();

	

	

	short getNameColorId();
	
	long getItemCount();
	void setItemCount(long value);
	
	
	boolean getCanStack();
	
	boolean getEquipmentIsUse();
	void setEquipmentIsUse(boolean value);
	

	
	
	CItemAttrList getAttrList();
	
	

}
