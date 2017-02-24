package darkjserv.items;

import darkjserv.CItemFactory;



public class SimpleItem implements ICItem
{
	
	public int itemId = 0;
	public int itemBaseId = 0;
	

	
	public long itemCount = 0;
	
	public SimpleItem(int itemBaseId, int itemId)
	{
		this.itemBaseId = itemBaseId;
		
		this.itemId = itemId;
		

	
		attrList = new CItemAttrList(this);
		
	}

	public int getItemId() 
	{
		// TODO Auto-generated method stub
		return itemId;
	}

	


	
	public String toString()
	{
		return String.format("<SimpleItem id=%d baseId=%d>", itemId, itemBaseId);
	}



	public long getItemCount() {
		// TODO Auto-generated method stub
		return itemCount;
	}

	public void setItemCount(long value) {
		itemCount = value;
		
	}
	
	
	
	public short nameColorId = 0;

	public short getNameColorId() {
		// TODO Auto-generated method stub
		return nameColorId;
	}
	
	
	public CItemAttrList attrList = null;



	private boolean _isUse = false;

	public boolean getEquipmentIsUse() 
	{
		// TODO Auto-generated method stub
		return _isUse;
	}
	
	public void setEquipmentIsUse(boolean value) {
		_isUse = value;
		
	}
	
	


	public CItemAttrList getAttrList() {
		// TODO Auto-generated method stub
		return attrList;
	}

	
	
	public boolean getCanStack() {
		// TODO Auto-generated method stub
		return CItemFactory.getInstance().getItemStackableByBaseId(itemBaseId);
	}

	

	public int getItemBaseId() {
		// TODO Auto-generated method stub
		return itemBaseId;
	}
	
	


}
