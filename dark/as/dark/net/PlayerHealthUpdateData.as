package dark.net 
{
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerHealthUpdateData 
	{
		
		public var charHp:int = 0;
		public var charMp:int = 0;
		
		public function toString():String		
		{
			return "<HealthUpdate hp=" + charHp + " mp=" +charMp  + ">";
		}
		
	}

}