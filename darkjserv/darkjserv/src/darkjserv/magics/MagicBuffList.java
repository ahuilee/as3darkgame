package darkjserv.magics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import darkjserv.net.AddAttrResult;

public class MagicBuffList 
{
	
	private HashMap<Integer, IMagicBuff> _items = new HashMap<Integer, IMagicBuff>();
	
	public void add(IMagicBuff item)
	{
		_items.put(item.getTypeId(), item);
	}
	
	
	public AddAttrResult calcAddAttrResult()
	{
		AddAttrResult rs = new AddAttrResult();
	
		for(Entry<Integer, IMagicBuff> entry : _items.entrySet())
		{			
			IMagicBuff buff = entry.getValue();
			
			switch(buff.getTypeId())
			{
				case MagicBuffEnums.WEAPON_FOCUS:
					rs.attackDamage += buff.getValue();
					break;
					
				case MagicBuffEnums.PROTECT_COVER:
					rs.defense += buff.getValue();
					break;
			}
		}
		
		return rs;
	}
	
	
	
	public List<IMagicBuff> getExpireItems(long now)
	{
		ArrayList<IMagicBuff> results = new ArrayList<IMagicBuff>();
		
		ArrayList<Integer> rms = new ArrayList<Integer>();
		
		for(Entry<Integer, IMagicBuff> entry : _items.entrySet())
		{
			
			IMagicBuff buff = entry.getValue();
			
			if(now > buff.getExpireTime())
			{
				results.add(buff);
				rms.add(entry.getKey());
			}			
			
		}
		
		for(Integer key : rms)
		{
			_items.remove(key);
		}
		
		
		return results;		
	}
	

}
