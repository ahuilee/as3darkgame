package dark.ui 
{
	import dark.GameTemplateEnums;
	import dark.Game;
	import dark.net.CharacterSkillItem;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ahui
	 */
	public class CSkillListItemSprite extends Sprite 
	{
		
		public var item:CharacterSkillItem = null;
		public var bitmap:Bitmap = null;
		
		public var game:Game = null;
		public var listView:CharacterSkillListView = null;
		
		public function CSkillListItemSprite(item:CharacterSkillItem, listView:CharacterSkillListView, game:Game) 
		{
			this.item = item;
			this.listView = listView;
			this.game = game;
			
			bitmap = new Bitmap();
			
			addChild(bitmap);
			
			this.mouseChildren = false;
			
			shortcutDelegate = new CSkillShortcutDelegate(item, game);
			
			setTemplateId(item.templateId);
			
		
		}
		
		
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			g.clear();
			
			g.beginFill(0x000000, 0.5);
			g.drawRect(0, 0, 64, 64);
			g.endFill();
		}
		
		public var shortcutDelegate:CSkillShortcutDelegate = null;
		
		public function setTemplateId(templateId:int):void
		{
			
			bitmap.bitmapData = shortcutDelegate.getBitmapDataByTemplateId(templateId);
			bitmap.width = 64;
			bitmap.height = 64;
		}
		
	}

}