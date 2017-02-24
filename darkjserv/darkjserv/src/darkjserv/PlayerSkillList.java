package darkjserv;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



public class PlayerSkillList 
{
	
	private ArrayList<ICSkillSet> _skills = new ArrayList<ICSkillSet>();
	private HashMap<Integer, ICSkillSet> _getSkillById = new HashMap<Integer, ICSkillSet>();
	
	public PlayerSkillList()
	{
		
	}
	
	public void clear()
	{
		_skills.clear();
		_getSkillById.clear();
	}
	
	public List<ICSkillSet> getAllSkills()
	{
		return _skills;
	}
	
	public ICSkillSet getSkillById(int id)
	{
		return _getSkillById.get(id);
	}
	
	public void add(ICSkillSet skill)
	{
		if(skill != null)
		{
			_skills.add(skill);
			_getSkillById.put(skill.getSkillId(), skill);
		}
	}

}
