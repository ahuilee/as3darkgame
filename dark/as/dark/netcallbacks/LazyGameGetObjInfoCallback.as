package dark.netcallbacks 
{
	import dark.GameObjInteractiveData;
	import dark.Game;
	import flash.utils.ByteArray;
	import dark.net.Connection;
	import dark.net.DataByteArray;
	import dark.net.GameObjectKey;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyGameGetObjInfoCallback implements ICommandCallback
	{
		
		public var game:Game = null;
		public var syncRequestAsk:int = 0;
		
		public function LazyGameGetObjInfoCallback(syncRequestAsk:int, game:Game) 
		{
			this.syncRequestAsk = syncRequestAsk;
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			//trace("LazyGameGetObjInfoCallback success=", ask);

			var rd:DataByteArray  = packet.body;			
			
			var count:int = rd.readUnsignedShort();
			
			for (var i:int = 0; i < count; i++)
			{
				var flag:int = rd.readUnsignedByte();
				
				if (flag == 0x01)
				{
					var objKey1:int = rd.readInt();
					var objKey2:int = rd.readInt();
					var objType:int = rd.readByte();
					var templateId:int = rd.readInt24();
					var objX:int = rd.readInt();
					var objY:int = rd.readInt();
					var dir:int = rd.readByte();
					
					
					game.syncLogic.onGameGetObjInfoCallback(new GameObjectKey(objKey1, objKey2), objType, templateId, objX, objY, dir);
					
				}
			}	
			
			//trace("LazyGameGetObjInfoCallback writeAnswerSuccess=", syncRequestAsk);
			game.conn.writeAnswerSuccess(syncRequestAsk, null);
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}