package darkjserv;

import java.awt.Rectangle;

public interface ICSkillSet 
{
	
	int getSkillId();
	String getSkillName();
	
	byte getTargetType();
	
	int getMagicPower();
	
	int getEffectId();
	int getTemplateId();
	
	int getMpCost();
	
	
	Rectangle getBounds();
	IShortcutItem makeShortcutItem(int idx);
	
	
}
