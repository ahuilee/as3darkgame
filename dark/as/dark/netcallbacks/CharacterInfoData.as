package dark.netcallbacks 
{
	/**
	 * ...
	 * @author ahui
	 */
	public class CharacterInfoData 
	{
		
		public var maxHp:int = 0;		
		public var maxMp:int = 0;		
				
		public var hp:int = 0;
		public var mp:int = 0;
		
		public var charStr:int = 0;
		public var charDex:int = 0;
		public var charInt:int = 0;
		public var charCon:int = 0;
		public var charSpi:int = 0;
		
		public var defense:int = 0;
		public var moveSpeed:int = 0;
		
		
		public function toString():String
		{
			return "<CharInfoData moveSpeed=" + moveSpeed + ">";
		}
	}

}