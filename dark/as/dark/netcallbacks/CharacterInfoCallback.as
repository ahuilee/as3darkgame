package dark.netcallbacks 
{
	import flash.utils.ByteArray;
	
	import dark.models.GameItem;
	import dark.Game;
	import dark.net.DataByteArray;	
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	
	
	/**
	 * ...
	 * @author ahui
	 */
	public class CharacterInfoCallback  implements ICommandCallback
	{
		
		public var game:Game = null;
		
		public function CharacterInfoCallback(game:Game) 
		{
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			
			var data:CharacterInfoData = new CharacterInfoData();
			
			data.maxHp = rd.readUInt24();
			data.maxMp = rd.readUInt24();
			data.hp = rd.readUInt24();
			data.mp = rd.readUInt24();
			
			data.charStr = rd.readUInt24();
			data.charDex = rd.readUInt24();
			data.charInt = rd.readUInt24();
			data.charCon = rd.readUInt24();
			data.charSpi = rd.readUInt24();
			data.defense = rd.readUInt24();
			data.moveSpeed = rd.readUInt24();
			
			
			game.onLoadCharacterInfo(data);
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}