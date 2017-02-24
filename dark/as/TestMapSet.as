package  
{
	import dark.IMapSet;
	/**
	 * ...
	 * @author 
	 */
	public class TestMapSet implements IMapSet
	{
		
		
		
		private var _x:int = 0;
		public function get x():int {
		
			return _x;
		}
		
		public function set x(value:int):void
		{		
			_x = value;
		}
		
		private var _y:int = 0;
		public function get y():int {
		
			return _y;
		}
		
		public function set y(value:int):void 
		{		
			_y = value;
		}
		
		private var _tails:Array = [];
		public function get tails():Array
		{
			return _tails;
		}
		
		public function set tails(value:Array):void
		{
			_tails = value;
		}
		
	}

}