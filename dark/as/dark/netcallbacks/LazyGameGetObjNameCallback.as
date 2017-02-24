package dark.netcallbacks 
{
	import dark.GameObjInteractiveData;
	import dark.GameObjNameData;
	import dark.Game;
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyGameGetObjNameCallback implements ICommandCallback
	{
		
		public var game:Game = null;
		public var delegate:IGameGetObjNameCallbackDelegate = null;
		
		public function LazyGameGetObjNameCallback(game:Game, delegate:IGameGetObjNameCallbackDelegate) 
		{
			this.game = game;
			this.delegate = delegate;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			
			var rd:DataByteArray  = packet.body;		
			var data:GetNameCallbackData = new GetNameCallbackData();			
			
			var interactiveData:GameObjInteractiveData = new GameObjInteractiveData();
			
			
			
			
			
			var interactiveCount:int = rd.readByte();
					
			for (var j:int = 0; j < interactiveCount; j++)
			{
				var interactiveCode:int = rd.readByte();
						
				switch (interactiveCode) 
				{
					case 1:
						interactiveData.walkTo = true;
						break;
					case 2:
						interactiveData.talk = true;
						break;
								
					case 3:
						interactiveData.shop = true;
						break;
					case 4:
						interactiveData.warehouse = true;
						break;
					case 5:
						interactiveData.attack = true;
						break;
					case 6:
						interactiveData.take = true;
						break;
						default:
				}
						
			}	
			
			
			data.interactiveData = interactiveData;
			
			data.name = rd.readBStr();
			
			//trace("LazyGameGetObjNameCallback", name);
			delegate.getObjNameCallback(data);
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}