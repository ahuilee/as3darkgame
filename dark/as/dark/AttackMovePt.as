package dark 
{
	/**
	 * ...
	 * @author 
	 */
	public class AttackMovePt 
	{
		
		public var x1:Number = 0;
		public var y1:Number = 0;
		public var dist:Number = 0;
		
		public function AttackMovePt(x1:Number, y1:Number, x2:Number, y2:Number) 
		{
			this.x1 = x1;
			this.y1 = y1;
			
			this.dist = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
		}
		
	}

}