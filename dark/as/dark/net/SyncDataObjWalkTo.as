package dark.net 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ahui
	 */
	public class SyncDataObjWalkTo 
	{
		
		public var x1:int = 0;
		public var y1:int = 0;
		public var direction1:int = 0;
		
		public var x2:int = 0;
		public var y2:int = 0;
		
		public var startServTicks:Number = 0;
		public var duration:int = 0;
		public var debugType:int = 0;
		
		public function toString():String
		{
			return "<SyncDataObjWalkTo x1=" + x1 + " y1=" + y1   +" x2=" + x2 + " y2=" + y2 + " startServTicks=" + startServTicks + " duration=" + duration + " debugType=" + debugType +">";
		}
		
	}

}