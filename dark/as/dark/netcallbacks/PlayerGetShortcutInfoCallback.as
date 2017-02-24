package dark.netcallbacks 
{
	
	

	import dark.Game;
	import dark.net.DataByteArray;
	import dark.ui.CSkillShortcutDelegate;
	import dark.ui.IShortcutItemSource;
	import flash.utils.Dictionary;
	
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import dark.net.CharacterSkillItem;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerGetShortcutInfoCallback  implements ICommandCallback
	{
		
		public var game:Game = null;
		
		public function PlayerGetShortcutInfoCallback(game:Game) 
		{
			this.game = game;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			
			var items:Array = [];
			var i:int = 0;
			
			var count:int = rd.readUnsignedByte();
			
			var getIdxCodeByItem:Dictionary = new Dictionary();
			
			
			
			for (i = 0; i < count; i++)
			{
				
				
				var idxCode:int = rd.readUnsignedByte();
				var type:int = rd.readUnsignedByte();
				
				trace("idxCode", idxCode, "type", type);
				
				//game item
				if (type == 0x01)
				{
					
				} else if (type == 0x02)
				{
					//skill
					var skillItem:CharacterSkillItem = new CharacterSkillItem();
					
					skillItem.skillId = rd.readInt24();
					skillItem.targetType = rd.readByte();
					skillItem.templateId = rd.readInt24();
					skillItem.name = rd.readBStr();
					
					var delegate:CSkillShortcutDelegate = new CSkillShortcutDelegate(skillItem, game);
					
					getIdxCodeByItem[delegate] = idxCode;
					items.push(delegate);
					
				}
				

			
			}
			
			
			for (i = 0; i < items.length; i++)
			{
				var iSource:IShortcutItemSource = items[i];
				
				var idxCode2:int = getIdxCodeByItem[iSource];
				
				trace("idxCode2", idxCode2);
				
				game.shortcutsItemListView.setItemSourceByIdxCode(iSource, idxCode2);
			}
			
			
			
			//game.characterSkillListView.initItems(items);
		}
		
		public function errback(reason:String):void
		{
			
		}
		
	}

}