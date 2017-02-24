package darkjserv.storages;

public class CharShortcutItem implements ICharShortcutItem
{
	
	public int idx;
	public byte type;
	public int skillId;
	public int itemId;
	
	public CharShortcutItem(int idx, byte type, int skillId, int itemId)
	{
		this.idx = idx;
		this.type = type;
		this.skillId = skillId;
		this.itemId = itemId;
	}

	public byte getType()
	{		
		return type;
	}
	

	public int getItemId() 
	{
		
		return itemId;
	}

	public int getSkillId() {
		// TODO Auto-generated method stub
		return skillId;
	}
	
	public String toString()
	{
		return String.format("<CharShortcutItem type=%d skill=%d >", type, skillId);
	}

	public int getIdx() {
		// TODO Auto-generated method stub
		return idx;
	}

}
