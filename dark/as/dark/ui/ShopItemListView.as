package dark.ui 
{
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import dark.Game;
	import dark.netcallbacks.ShopItemData;
	/**
	 * ...
	 * @author 
	 */
	public class ShopItemListView extends LazyBoxSprite implements ICloseButtonDelegate
	{
		
		public var game:Game = null;
		private var _scrollable:VScrollableContainer = null;
		private var listSprite:Sprite = null;
		
		public var closeButton:CloseButton = null;
		
		public function ShopItemListView(viewWidth:int, viewHeight:int, game:Game) 
		{
			this.game = game;
			
			super(viewWidth, viewHeight, game.app);
			
			_scrollable = new VScrollableContainer(viewWidth-64, viewHeight-96);
			
			_scrollable.y = 48;
			_scrollable.x = 32;			
			
			addChild(_scrollable);
			
			listSprite = new Sprite();
			
			_scrollable.container.addChild(listSprite);
			
			closeButton = new CloseButton(this);
			
			addChild(closeButton);
			
			closeButton.y = 8;
			closeButton.x = viewWidth - 48;
			
		}
		
		
		public function onCloseButtonPress():void
		{
			this.visible = false;
		
		}
		
		public function loadItems(items:Array):void
		{
			
			trace("loadItems", items);
			var i:int = 0;
			var lNumChildren:int = listSprite.numChildren;
			
			for (i = 0; i < lNumChildren; i++)
			{
				listSprite.removeChildAt(0);
			}
			
			for (i = 0; i < items.length; i++)
			{
				var item:ShopItemData = items[i];
				var sprite:ShopItemSprite = new ShopItemSprite(game.app);
				
				listSprite.addChild(sprite);
				
				sprite.x = 0;
				sprite.y = i * 64;
				sprite.txtField.text = item.name;
			}
			
			_scrollable.draw();
			
		}
		
		
	
		
		public function draw():void 
		{

			drawBgStyle1();		
			
			
		}
		
	}

}