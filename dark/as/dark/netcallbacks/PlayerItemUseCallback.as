package dark.netcallbacks 
{
	
	import dark.net.DataByteArray;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import dark.ui.ItemListView;
	import dark.ui.ItemSprite;
	import flash.utils.ByteArray;
	
	public class PlayerItemUseCallback implements ICommandCallback
	{
		
	
	
		public var delegate:IPlayerItemUseCallbackDelegate = null;
		
		
		public function PlayerItemUseCallback(delegate:IPlayerItemUseCallbackDelegate) 
		{
			this.delegate = delegate;
			
		}
		
		public function success(ask:int, packet:Packet):void
		{
			
			var rd:DataByteArray = packet.body;
			
			var rsCount:int = rd.readUnsignedByte();
			
			for (var i:int = 0; i < rsCount; i++)
			{
			
				var opCode:int =  rd.readUnsignedByte();
				//trace("PlayerItemUseCallback success", ask, opCode);
				delegate.onPlayerItemUseCallback(opCode);
				
			}
			
			
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}