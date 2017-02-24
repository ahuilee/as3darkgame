package dark.net 
{
	
	public class SyncAnimationData 
	{
		public var direction2:int = 0;
		public var animationId:int = 0;
		
		
		public var startServTicks:Number = 0;
		public var duration:int = 0;
		public var debugType:int = 0;
		
		
		public function toString():String
		{
			return "<SyncAnimationData animationId=" + animationId + " startServTicks=" + startServTicks + " duration=" + duration +  " dir2=" + direction2 +" debugType=" + debugType + ">";
		}
		
	}

}