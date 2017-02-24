package dark 
{
	/**
	 * ...
	 * @author 
	 */
	public class GameObjInteractiveData 
	{
	
		public var walkTo:Boolean = false;
		public var talk:Boolean = false;
		public var shop:Boolean = false;			
		
		public var warehouse:Boolean = false;
		public var attack:Boolean = false;
		public var take:Boolean = false;
		
		public function toString():String		
		{
			return "<GameObjInteractiveData take=" + take + " attack=" +  attack +">";
		}
		
	}

}