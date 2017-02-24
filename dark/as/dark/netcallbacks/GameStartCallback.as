package dark.netcallbacks
{
	
	
	import dark.GameInitSet;
	import dark.models.GameStartData;
	import dark.LazyGameConnDelegate;
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import flash.utils.ByteArray;
	
	public class GameStartCallback implements ICommandCallback
	{
		
		public var initSet:GameInitSet = null;
		
		public function GameStartCallback(initSet:GameInitSet) 
		{
			this.initSet = initSet;
		}
		
		
		public function success(ask:int, packet:Packet):void
		{

			var rd:DataByteArray = packet.body;
			
			var data:GameStartData = new GameStartData();
			
			data.servTicks = rd.readUInt48();
			
			initSet.onGameStarted(data);
			
			//delegate.onGameStarted(data);
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}