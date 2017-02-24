package dark.netcallbacks
{
	
	
	import dark.GameInitSet;
	import dark.models.GameInitDoneData;
	import dark.LazyGameConnDelegate;
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import dark.net.ICommandCallback;
	import dark.net.Packet;

	import flash.utils.ByteArray;
	
	public class GameInitDoneCallback implements ICommandCallback
	{
		
		public var initSet:GameInitSet = null;
		
		public function GameInitDoneCallback(initSet:GameInitSet) 
		{
			this.initSet = initSet;
		}
		
		
		public function success(ask:int, packet:Packet):void
		{

			var rd:DataByteArray = packet.body;
			
			var data:GameInitDoneData = new GameInitDoneData();
			
			
			var key1:int = rd.readInt();
			var key2:int = rd.readInt();
			data.objKey = new GameObjectKey(key1, key2);	
			data.templateId = rd.readInt24();
			data.charX = rd.readInt();
			data.charY = rd.readInt();
			data.direction = rd.readByte();
		
			
			data.charLevel = rd.readShort();
			data.charExpPercent = rd.readByte()  / 255.0;
		
			
			trace("charExpPercent", data.charExpPercent);
			
			data.charMaxHp = rd.readInt24();
			data.charMaxMp = rd.readInt24();
			data.charHp = rd.readInt24();
			data.charMp = rd.readInt24();
			data.charDef = rd.readInt24();
			
			data.charWeighted = rd.readUnsignedByte() / 255.0;
			data.moveSpeed = rd.readShort();				
			
			
			initSet.onGameInitDoneCallback(data);
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}