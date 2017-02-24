package dark.netcallbacks 
{
	import dark.net.UserCharacterData;
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
	public class GameLoginCallback  implements ICommandCallback
	{
		
		public var game:Game = null;
		
		public function GameLoginCallback(game:Game) 
		{
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			
			var charCount:int = rd.readByte();
			
			var chars:Array = [];
			
			for (var i:int = 0; i < charCount; i++)
			{
				var cData:UserCharacterData = new UserCharacterData();
				
				cData.charId = rd.readInt();
				cData.charName = rd.readBStr();
				
				chars.push(cData);				
		
			}
			
			game.connDelegate.onUserLoginSuccess(chars);
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}