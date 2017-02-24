package darkjserv.magics;

import darkjserv.GameTemplateEnums;

public class ProtectCoverMagicBuff implements IMagicBuff
{
	
	public long expireTime = 0;
	public int value = 0;
	
	public ProtectCoverMagicBuff(int value, long expireTime)
	{
		this.value = value;
		this.expireTime = expireTime;
		
	}

	public int getTypeId()
	{
		// TODO Auto-generated method stub
		return MagicBuffEnums.PROTECT_COVER;
	}

	public long getExpireTime() {
		// TODO Auto-generated method stub
		return expireTime;
	}

	public int getValue() {
		// TODO Auto-generated method stub
		return value;
	}
	
	public String toString()
	{
		return String.format("<ProtectCoverMagicBuff value=%d>", value);
	}

	public int getTemplateId() {
		// TODO Auto-generated method stub
		return GameTemplateEnums.TI_INDEX_SKILL_START+2;
	}

}
