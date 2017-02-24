package darkjserv.net;

import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import darkjserv.AttackDamageValue;
import darkjserv.CSkillEnums;
import darkjserv.GameEnums;
import darkjserv.IAnimationSyncSet;
import darkjserv.ICSkillSet;
import darkjserv.IGameCharacter;
import darkjserv.IInteractiveDelegate;
import darkjserv.IShortcutItem;
import darkjserv.InteractiveCodes;
import darkjserv.PlayerSkillList;
import darkjserv.SkillFactory;
import darkjserv.items.PlayerCItemList;
import darkjserv.magics.MagicBuffList;
import darkjserv.storages.ICharShortcutItem;
import darkjserv.storages.StorageFactory;

public class GamePlayer implements IGameCharacter
{
	
	public static final int STATE_NONE = 0;
	public static final int STATE_DEAD = 1;
	
	public Connection conn = null;
	
	public int charId = 0;
	public int mapId = 0;
	
	public long objId = 0;
	private int _x = 0;
	private int _y = 0;
	
	public byte direction = 0;
	
	public String name = "";
	
	public Rectangle viewRect = new Rectangle(0, 0, 1792, 1408);
	
	//public HashSet<IGameObj> viewObjs = new HashSet<IGameObj>();
	
	public int templateId = 0;
	
	private boolean _isDead = false;
	
	public GamePlayerInteractiveDelegate interactiveDelegate = null;
	
	public PlayerCItemList itemList = null;	
	public MagicBuffList magicBuffList = null;
	
	public int state = 0;
	
	public GamePlayer(int charId, long objId, String name, int mapId, Connection conn)
	{
		this.charId = charId;
		this.objId = objId;
		this.mapId = mapId;
		this.conn = conn;
		this.name = name;
		

		magicBuffList = new MagicBuffList();
		
		interactiveDelegate =  new GamePlayerInteractiveDelegate(this, conn.server.factory);
		
		itemList = new PlayerCItemList(this);
		
	}
	
	//防禦
	public int charDef = 10;
	//力量
	public int charStr = 10;
	//智力
	public int charInt = 10;	
	
	//敏捷
	public int charDex = 32;
	//精神
	public int charSpi = 10;
	//體質
	public int charCon = 10;
	
	public int hp = 10;
	public int mp = 10;
	public int maxHp = 10;
	public int maxMp = 10;
	
	public long curExp = 0;
	

	class ShortcutList
	{
		public HashMap<Integer, IShortcutItem> items = new HashMap<Integer, IShortcutItem>();
		
		
		public void clear()		
		{
			items.clear();
		}
		
		public void add(int idx, ICSkillSet skill)
		{
			if(skill != null)
			{
				items.put(idx, skill.makeShortcutItem(idx));
			}
		}
		
	}
	
	ShortcutList shortcutList = new ShortcutList();
	
	public void loadShortcutItems() throws Exception
	{
		shortcutList.clear();
		
		List<ICharShortcutItem> shortcuts = StorageFactory.getInstance().getCharShortcutItems(charId);
		

		for(ICharShortcutItem item : shortcuts)
		{
			
			System.out.println(String.format("loadShortcutItems %s", item));
			
			if(item.getType() == 0x01)
			{
				shortcutList.add(item.getIdx(), skillList.getSkillById(item.getSkillId()));
				
			}
		
		}
		
	}
	
	public void setShortcutItem(byte idx, byte type, int id) throws Exception
	{		
		
		if(type == 0x01)
		{
			shortcutList.add(idx, skillList.getSkillById(id));			
		}
		
		StorageFactory.getInstance().setCharShortcutItem(charId, idx, type, id);
	}
	
	public List<IShortcutItem> getShortcutItems()
	{
		ArrayList<IShortcutItem> rs = new ArrayList<IShortcutItem>();
		
		for(int i=0; i<4; i++)
		{
			IShortcutItem item = shortcutList.items.getOrDefault(i, null);
			if(item != null)
			{
				rs.add(item);
			}
		}

		return rs;
	}
	
	public PlayerSkillList skillList = new PlayerSkillList();	
	
	
	private void _addSkill(ICSkillSet skill)
	{
		if(skill != null)
		{
			skillList.add(skill);		
		}
	}
	
	public void loadSkills()
	{
		skillList.clear();
		
		SkillFactory skillFactory = SkillFactory.getInstance();
		
		for(int i=CSkillEnums.SKILL_001; i<CSkillEnums.SKILL_001+100; i++)
		{
			_addSkill(skillFactory.getSkillSetById(i));
		}
		
	}
	
	public void setMapId(int mapId)
	{
		this.mapId = mapId;
	}
	
	public int getMapId()
	{
		return mapId;
	}
	
	
	public long getCurExp()
	{
		return curExp;
	}
	
	public void setCurExp(long value)
	{
		curExp = value;
	}
	/*
	public void setCurExp(long value)
	{
		this.curExp = value;
	}*/
	

	
	
	public void setHp(int value)
	{
		hp = value;
	}
	
	public int getHp()
	{
		return hp;
	}
	
	public void setMp(int value)
	{
		mp = value;
	}
	
	public int getMp()
	{
		return mp;
	}
	

	public int getMaxHp()
	{
		return maxHp;
	}
	
	public void setMaxHp(int value)
	{
		maxHp = value;
		_statusInfo = null;
	}
	
	public int getMaxMp()
	{
		return maxMp;
	}
	
	public void setMaxMp(int value)
	{
		maxMp = value;
		_statusInfo = null;
	}
	
	public int getDef()
	{
		return charDef;
	}
	
	
	public void setCharStr(int value)
	{
		charStr = value;
		_statusInfo = null;
	}
	

	
	public int getDex() 
	{
		// TODO Auto-generated method stub
		return charDex;
	}
	
	public void setDex(int value) 
	{
		// TODO Auto-generated method stub
		charDex = value;
		_statusInfo = null;
	}
	
	public void setPosition(int x, int y)
	{
		_x = x;
		_y = y;
		viewRect.x = _x - viewRect.width / 2;
		viewRect.y = _y - viewRect.height / 2;
	}

	public int getX() {
		
		return _x;
	}

	public int getY() {
		
		return _y;
	}
	
	public void setX(int value)
	{
		_x = value;
		viewRect.x = _x - viewRect.width / 2;
	}
	
	public void setY(int value)
	{
		_y = value;
		viewRect.y = _y - viewRect.height / 2;
	}
	
	public void setViewBoundSize(int w, int h)
	{
		viewRect.width = w;
		viewRect.height = h;
		viewRect.x = _x - viewRect.width / 2;
		viewRect.y = _y - viewRect.height / 2;
	}

	public long getObjId() {
		
		return objId;
	}

	public byte getDirection() {
		// TODO Auto-generated method stub
		return direction;
	}
	
	public String toString()
	{
		return String.format("<GamePlayer objId=%d>", objId);
	}

	public int getTemplateId() {
		// TODO Auto-generated method stub
		
		//return GameTemplateEnums.TC_NPC003;
		//return GameTemplateEnums.TC_NPC002;
		//return GameTemplateEnums.TC_DRAGON01;
		
		return templateId;
	}

	public String getName() {
		// TODO Auto-generated method stub
		return name;
	}

	
	
	public int getMoveSpeed()
	{
		return getStatusInfo().moveSpeed;
	}

	public List<Byte> getInteractiveCodes()
	{
		
		List<Byte> codes = new ArrayList<Byte>();
		codes.add(InteractiveCodes.WALK_TO);
		
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


	public void setDirection(byte value) {
		// TODO Auto-generated method stub
		direction = value;
	}




	public IInteractiveDelegate getInteractiveDelegate() {
		// TODO Auto-generated method stub
		return interactiveDelegate;
	}
	
	public void setIsDead(boolean value)
	{
		_isDead = value;
		
		if(_isDead)
		{
			state = STATE_DEAD;
		}
	}

	public boolean getIsDead() {
		// TODO Auto-generated method stub
		return _isDead;
	}
	
	
	private PlayerStatusInfo _statusInfo = null;
	
	public PlayerStatusInfo getStatusInfo()
	{
		if(_statusInfo == null)
		{
			_statusInfo = calcStatusInfo();
		}
		
		return _statusInfo;
	}
	
	public void clearStatusInfoCache()
	{
		_statusInfo = null;
	}
	
	public PlayerStatusInfo calcStatusInfo()
	{
		PlayerStatusInfo info = new PlayerStatusInfo(this);
		
		AddAttrResult itemAddAttrRs = itemList.calcAddAttrResult();
		AddAttrResult magicBuff = magicBuffList.calcAddAttrResult();
		
		
		info.maxHp = maxHp + itemAddAttrRs.maxHp;
		info.maxMp = maxMp + itemAddAttrRs.maxMp;
		
		int lastStr = charStr + itemAddAttrRs.charStr + magicBuff.charStr;
		int lastInt = charInt + itemAddAttrRs.charInt + magicBuff.charInt;
		int lastCon = charCon + itemAddAttrRs.charCon + magicBuff.charCon;
		int lastDex = charDex + itemAddAttrRs.charDex + magicBuff.charDex;
		int lastSpi = charSpi + itemAddAttrRs.charSpi + magicBuff.charSpi;
		
		info.charStr = lastStr;
		info.charInt = lastInt;
		info.charDex = lastDex;		
		info.charCon = lastCon;		
		info.charSpi = lastSpi;
		

		info.magicAttackDamage = lastInt + itemAddAttrRs.magicAttackDamage + magicBuff.magicAttackDamage;

		info.attackSpeed = lastDex / 8 + itemAddAttrRs.attackSpeed + magicBuff.attackSpeed;
		info.moveSpeed = lastDex / 8 + itemAddAttrRs.moveSpeed + magicBuff.moveSpeed;
		
		if(info.moveSpeed < 32)
		{
			info.moveSpeed = 32;
		}
		
		AttackDamageValue attackDamageValue = new AttackDamageValue();
		
		attackDamageValue.damage = lastStr + itemAddAttrRs.attackDamage + magicBuff.attackDamage;
		attackDamageValue.magicDamage =  itemAddAttrRs.magicDamage + magicBuff.magicDamage;
		attackDamageValue.coldDamage =  itemAddAttrRs.coldDamage + magicBuff.coldDamage;
		attackDamageValue.fireDamage =  itemAddAttrRs.fireDamage + magicBuff.fireDamage;
		attackDamageValue.lightningDamage =  itemAddAttrRs.lightningDamage + magicBuff.lightningDamage;
		attackDamageValue.poisonDamage =  itemAddAttrRs.poisonDamage + magicBuff.poisonDamage;
		
		info.attackDamageValue = attackDamageValue;
		
		
		info.defense = lastCon / 8 + itemAddAttrRs.defense + magicBuff.defense;
		info.magicDefense = lastInt * 2 + itemAddAttrRs.magicDefense + magicBuff.magicDefense;
		
		return info;
	}


	public int calcCharMagicDamage() {
		// TODO Auto-generated method stub
		return getStatusInfo().magicAttackDamage;
	}

	public byte getObjType() {
		// TODO Auto-generated method stub
		return GameEnums.OBJTYPE_CHAR;
	}
	
	
	
}
