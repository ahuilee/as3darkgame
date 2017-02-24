package dark.ui 
{
	

	import flash.display.BitmapData;
	import flash.events.Event;	
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import dark.GameTemplateEnums;
	import dark.AppDelegate;
	import dark.GameEnums;
	import dark.models.GameItem;
	import dark.Game;
	
	public class ItemSprite extends Sprite 
	{
		
		
		public var container:Sprite = null;
		public var bitmap:Bitmap = null;
		public var gameItem:GameItem = null;
		
		public var isSelected:Boolean = false;
		
		private var front:Sprite = null;
		
		public var listView:ItemListView = null;
		
		public function ItemSprite(gameItem:GameItem, listView:ItemListView) 
		{
			this.gameItem = gameItem;
			this.listView = listView;
			
			container = new Sprite();
			
			container.graphics.beginFill(0x000000, 1);
			container.graphics.drawRect(0, 0, 64, 64);
			container.graphics.endFill();
		
			bitmap = new Bitmap();
			
			container.addChild(bitmap);
			
			front = new Sprite();	
			
			addChild(container);
			addChild(front);
			
			draw();
			
			this.mouseChildren = false;
		

		}
		
		
		
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			g.clear();
			g.lineStyle(1, 0x000000);
			
			g.beginFill(0xfffff, 0);
			g.drawRect(0, 0, GameEnums.ITEMLIST_BOX_SIZE, GameEnums.ITEMLIST_BOX_SIZE);
			g.endFill();
			
			var fg:Graphics = front.graphics;
			fg.clear();
			if (isSelected)
			{
				fg.lineStyle(2, 0xff9900);
				fg.drawRect(0, 0, GameEnums.ITEMLIST_BOX_SIZE, GameEnums.ITEMLIST_BOX_SIZE);
			}
		}
		
		public function setTemplateId(templateId:int, app:AppDelegate):void
		{			
			var key:String = listView.game.app.makeTIKeyByTemplateId(gameItem.templateId);
			
			
			//trace("ItemSprite setTemplateId", key);
			
			var bd:BitmapData = listView.game.app.getIconBdByKey(key);
			
			if (bd != null)
			{
				bitmap.bitmapData = bd;
			}			
			
			container.x = GameEnums.ITEMLIST_BOX_SIZE / 2 - bitmap.width * .5;
			container.y = GameEnums.ITEMLIST_BOX_SIZE / 2 - bitmap.height * .5;
			
		}
		
		
	}

}