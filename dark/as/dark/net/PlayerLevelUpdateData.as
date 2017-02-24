package dark.net 
{
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerLevelUpdateData 
	{
		
		public var charLevel:int = 0;
		public var charExpPercent:Number = 0;
	
		public var maxHp:int = 0;
		public var maxMp:int = 0;
		
		public function toString():String
		{
			return "<PlayerLevelUpdateData level=" + charLevel + " charExpPercent=" + charExpPercent +  ">";
		}
		
	}

}