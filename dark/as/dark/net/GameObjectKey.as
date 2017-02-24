package dark.net 
{
	/**
	 * ...
	 * @author ahui
	 */
	public class GameObjectKey 
	{
		
		public var key1:int = 0;
		public var key2:int = 0;
		
		public function GameObjectKey(key1:int, key2:int)
		{
			this.key1 = key1;
			this.key2 = key2;
		}
		
		public function equals(objKey2:GameObjectKey):Boolean
		{
		
			
			return key1 == objKey2.key1 && key2 == objKey2.key2;
		}
		
		public function toString():String
		{
			return "<GameObjectKey " + key1 + "_" +  key2 +">";
		}
		
	}

}