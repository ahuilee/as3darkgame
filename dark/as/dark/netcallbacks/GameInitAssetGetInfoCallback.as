package dark.netcallbacks
{
	
	
	import dark.GameInitSet;
	import dark.loaders.AssetNPCLoadItem;
	import dark.models.GameInitData;
	import dark.LazyGameConnDelegate;
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import flash.display.InteractiveObject;

	import flash.utils.ByteArray;
	
	public class GameInitAssetGetInfoCallback implements ICommandCallback
	{
		
		public var initSet:GameInitSet = null;
		
		public function GameInitAssetGetInfoCallback(initSet:GameInitSet) 
		{
			this.initSet = initSet;
		}
		
		
		public static function getKeyPrefixByAssetId(assetId:int):String
		{
			
			switch (assetId) 
			{
				case 0x101:
					return "NPC001";
				case 0x102:
					return "NPC002";
				case 0x103:
					return "NPC003";
					
				case 0x131:
					return "NPC031";
					
				case 0x151:
					return "NPC051";					
				case 0x152:
					return "NPC052";	
				case 0x153:
					return "NPC053";
				case 0x154:
					return "NPC054";
					
				default:
			}
			
			return "NPC001";
		}
		
		public function success(ask:int, packet:Packet):void
		{

			var rd:DataByteArray = packet.body;
			

			var assetItemCount:int = rd.readUnsignedShort();
			
			var assetItems:Array = [];
			
			for (var i:int = 0; i < assetItemCount; i++)
			{
				var assetId:int = rd.readUnsignedShort();
				var assetType:int = rd.readUnsignedByte();
				var url:String = rd.readBStr();
				
				switch (assetType) 
				{
					case 1:
						
						//trace("asset", url);
						
						assetItems.push(new AssetNPCLoadItem(assetId, getKeyPrefixByAssetId(assetId), url, initSet.connDelegate.game));
						
						break;
					default:
				}
				
				
			}			
			
			
			initSet.onGameInitAssetGetInfoCallback(assetItems);
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}