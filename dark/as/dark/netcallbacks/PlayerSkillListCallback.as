package dark.netcallbacks 
{
	
	

	import dark.Game;
	import dark.net.DataByteArray;
	
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import dark.net.CharacterSkillItem;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerSkillListCallback  implements ICommandCallback
	{
		
		public var game:Game = null;
		
		public function PlayerSkillListCallback(game:Game) 
		{
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			
			var items:Array = [];
			
			var count:int = rd.readShort();
			
			
			
			for (var i:int = 0; i < count; i++)
			{
				var item:CharacterSkillItem = new CharacterSkillItem();			
			
				
				
				item.skillId = rd.readInt24();
				item.targetType = rd.readByte();
				item.templateId = rd.readInt24();
				item.name = rd.readBStr();		
			
				items.push(item);
				
				trace("PlayerSkillListCallback", item);
			}
			
			
			
			game.characterSkillListView.initItems(items);
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}