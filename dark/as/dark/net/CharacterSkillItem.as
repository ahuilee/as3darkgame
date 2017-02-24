package dark.net 
{
	/**
	 * ...
	 * @author 
	 */
	public class CharacterSkillItem
	{
		
		public var skillId:int = 0;
		public var targetType:int = 0;
		public var templateId:int = 0;
		public var name:String = "";
		
		
		
		public function toString():String
		{
			
			return "<CharacterSkillItem skillId=" + skillId + " name=" + name + ">";
		}
		
	}

}