package dark.models 
{
	import dark.net.GameObjectKey;	
	
	public class GameInitDoneData 
	{

		
		public var objKey:GameObjectKey = null;
		public var templateId:int = 0;
		public var charX:int = 0;
		public var charY:int = 0;
		public var direction:int = 0;
		public var moveSpeed:int = 0;
		
		
		public var charLevel:int = 0;
		
		public var charExpPercent:Number = 0;

		
		public var charMaxHp:int = 0;
		public var charMaxMp:int = 0;
		public var charHp:int = 0;
		public var charMp:int = 0;
		public var charDef:int = 0;
		public var charWeighted:Number = 0;
	}

}