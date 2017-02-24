package dark.ui 
{
	import dark.Game;
	import dark.models.CItemInfo;
	import dark.net.CharacterSkillItem;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author ahui
	 */
	public class CSkillShortcutDelegate implements IShortcutItemSource, IShortcutItemUseDelegate
	{
		
		public var item:CharacterSkillItem = null;
		public var game:Game = null;
		
		public function CSkillShortcutDelegate(item:CharacterSkillItem, game:Game) 
		{
			this.item = item;
			this.game = game;
		}
		
		public function getStorageType():int
		{
			return 0x01;
		}
		
		public function getStorageId():int
		{
			return item.skillId;
		}
		
		public function getShortcutItemUseDelegate():IShortcutItemUseDelegate
		{
			return this;
		}
		
		public	function onShortcutItemUse():void
		{
			//trace("onShortcutUse", this);
			
			game.playerUseSkill(item.skillId, item.targetType);
		}
		
		
		
		public function displayShortcutItemInfo(infoSprite:DisplayItemInfoSprite):void
		{
			//trace("displayShortcutItemInfo", this, infoSprite);
			infoSprite.setItemText(item.name);
			
		}
		
		public function getShortcutItemBitmapData():BitmapData
		{

			return getBitmapDataByTemplateId(item.templateId);
		}
		
		public function getBitmapDataByTemplateId(templateId:int):BitmapData
		{
			var key:String = game.app.makeTIKeyByTemplateId(item.templateId);			
			
			return game.app.getIconBdByKey(key);
		}
		
	}

}