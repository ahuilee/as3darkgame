package darkjserv;

import java.awt.Rectangle;
import java.io.ByteArrayOutputStream;

import darkjserv.net.DataWriter;



public class SkillFactory 
{
	
	
	private static SkillFactory _instance = null;
	
	public static SkillFactory getInstance()
	{
		if(_instance == null)
		{
			_instance = new SkillFactory();
		}
		
		return _instance;
	}
	
	class CSkillShortcutItem implements IShortcutItem
	{
		
		public int idx;
		public CSkillSet skillSet;
		
		public CSkillShortcutItem(int idx, CSkillSet skillSet)
		{
			this.idx = idx;
			this.skillSet = skillSet;
		}

		public byte[] makeShortcutItemBytes() throws Exception
		{
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			@SuppressWarnings("resource")
			DataWriter w = new DataWriter(outputStream);
			
			w.writeByte(0x02);
			
			w.writeUInt24(skillSet.skillId);	
			//skill targetType
			w.writeByte(skillSet.targetType);			
			w.writeUInt24(skillSet.templateId);		
			w.writeBStrUTF(skillSet.skillName);
			
			w.flush();
			
			return outputStream.toByteArray();
		}

		public int getIdx() {
			// TODO Auto-generated method stub
			return idx;
		}
		
	}
	
	
	class CSkillSet implements ICSkillSet
	{
		
		public int skillId = 0;	
		public int magicPower = 0;	
		public int mpCost = 0;	
		
		public byte targetType = 0;
		public String skillName = "";
		
		public int effectId = 0;
		
		public int templateId = 0;
		
		public Rectangle bounds = null;
		
		public CSkillSet(int skillId, int magicPower, int mpCost, byte targetType, String skillName, int effectId, int templateId,  Rectangle bounds)
		{
			this.skillId = skillId;
			this.magicPower = magicPower;
			this.mpCost = mpCost;
			this.targetType = targetType;
			
			this.skillName = skillName;
			this.effectId = effectId;
			this.templateId = templateId;
			this.bounds = bounds;
		}

		public int getEffectId() {
			// TODO Auto-generated method stub
			return effectId;
		}

		public byte getTargetType() {
			// TODO Auto-generated method stub
			return targetType;
		}

		public Rectangle getBounds() {
			// TODO Auto-generated method stub
			return bounds;
		}

		public int getSkillId() {
			// TODO Auto-generated method stub
			return skillId;
		}

		public String getSkillName() {
			// TODO Auto-generated method stub
			return skillName;
		}

		public int getTemplateId()
		{
			// TODO Auto-generated method stub
			return templateId;
		}

	

		
		public int getMpCost() {
			// TODO Auto-generated method stub
			return mpCost;
		}

		public int getMagicPower() {
			// TODO Auto-generated method stub
			return magicPower;
		}

		public IShortcutItem makeShortcutItem(int idx) {
			// TODO Auto-generated method stub
			return new CSkillShortcutItem(idx, this);
		}

		
	}
	
	
	public ICSkillSet getSkillSetById(int skillId)
	{

		switch(skillId)
		{
			case CSkillEnums.SKILL_001:
				
				return new CSkillSet(
						skillId, 
						50,
						10,
						CSkillEnums.TARGET_SELF, 
						"«OÅ@¸n", 
						GameEffectEnums.SE_IDXSTART + 15, 
						GameTemplateEnums.TI_INDEX_SKILL_START+2,
						new Rectangle(0, 0, 0, 0)
						);

				
			case CSkillEnums.SKILL_002:
				return new CSkillSet(
						skillId, 
						50, 10,
						CSkillEnums.TARGET_SELF, 
						"ªZ¾¹±j¤Æ", 
						GameEffectEnums.SE_IDXSTART + 14, 
						GameTemplateEnums.TI_INDEX_SKILL_START+1,
						new Rectangle(0, 0, 0, 0)
						);
				
				
			case CSkillEnums.SKILL_031:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_SINGLE, 
						"¦BÀ@", 
						GameEffectEnums.SE_IDXSTART + 13,
						GameTemplateEnums.TI_INDEX_SKILL_START+20,
						new Rectangle(-32, -32, 64, 64)
						);	
				
			case CSkillEnums.SKILL_032:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¦Bµõ³N", 
						GameEffectEnums.SE_IDXSTART + 12,
						GameTemplateEnums.TI_INDEX_SKILL_START+17,
						new Rectangle(-256, -256, 512, 512)
						);	
				
			case CSkillEnums.SKILL_033:
				return new CSkillSet(
						skillId, 
						200, 100,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¦B³·¼É", 
						GameEffectEnums.SE_IDXSTART + 3, 
						GameTemplateEnums.TI_INDEX_SKILL_START+4,
						new Rectangle(-384, -384, 768, 768)
						);
			
				
			case CSkillEnums.SKILL_006:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¯PµK³N", 
						GameEffectEnums.SE_IDXSTART + 5, 
						GameTemplateEnums.TI_INDEX_SKILL_START+7,
						new Rectangle(-128, -128, 256, 256)
						);
			case CSkillEnums.SKILL_007:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¤õ²y³N", 
						GameEffectEnums.SE_IDXSTART + 0, 
						GameTemplateEnums.TI_INDEX_SKILL_START+6,
						new Rectangle(-128, -128, 256, 256)
						);	
				
			case CSkillEnums.SKILL_008:
				return new CSkillSet(
						skillId, 
						200, 100,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¹k¥Û³N", 
						GameEffectEnums.SE_IDXSTART + 2, 
						GameTemplateEnums.TI_INDEX_SKILL_START+5,
						new Rectangle(-256, -256, 512, 512)
						);
				
			case CSkillEnums.SKILL_009:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"´c¬r¤§½b", 
						GameEffectEnums.SE_IDXSTART + 4, 
						GameTemplateEnums.TI_INDEX_SKILL_START+15,
						new Rectangle(-128, -128, 256, 256)
						);
				
			case CSkillEnums.SKILL_010:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"´c¬r­·¼É", 
						GameEffectEnums.SE_IDXSTART + 1,
						GameTemplateEnums.TI_INDEX_SKILL_START+16,
						new Rectangle(-256, -256, 512, 512)
						);	
				
				
			case CSkillEnums.SKILL_051:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¸¨¹p³N", 
						GameEffectEnums.SE_IDXSTART + 8,
						GameTemplateEnums.TI_INDEX_SKILL_START+18,
						new Rectangle(-256, -256, 512, 512)
						);	
	
			case CSkillEnums.SKILL_052:
				return new CSkillSet(
						skillId, 
						100, 50,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¹p¯«¤§«ã", 
						GameEffectEnums.SE_IDXSTART + 9,
						GameTemplateEnums.TI_INDEX_SKILL_START+19,
						new Rectangle(-384, -384, 768, 768)
						);	
				
			case CSkillEnums.SKILL_DRAGON_FIRE:

				return new CSkillSet(
						skillId, 
						30, 30,
						CSkillEnums.TARGET_SELECT_POINT, 
						"¤õÀs¼Q¤õ", 
						GameEffectEnums.SE_IDXSTART + 2, 
						GameTemplateEnums.TI_INDEX_SKILL_START+9,
						new Rectangle(-256, -256, 512, 512)
						);
				
		}
		
		return null;
	}
}
