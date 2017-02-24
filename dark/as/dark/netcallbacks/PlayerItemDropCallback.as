package dark.netcallbacks 
{
	
	import dark.IGame;
	import dark.net.DataByteArray;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import dark.ui.ItemListView;
	import dark.ui.ItemSprite;
	import flash.utils.ByteArray;
	
	public class PlayerItemDropCallback implements ICommandCallback
	{
		
	
	
		public var delegate:IPlayerItemDropCallbackDelegate = null;
		
		
		public function PlayerItemDropCallback(delegate:IPlayerItemDropCallbackDelegate) 
		{
			this.delegate = delegate;
			
		}
		
		public function success(ask:int, packet:Packet):void
		{
			
			var rd:DataByteArray = packet.body;
			
			trace("PlayerItemDropCallback success", ask);
			
			var state:int = rd.readByte();
			
			delegate.onPlayerItemDropCallback(state);
			
		
			
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}