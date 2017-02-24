package dark.ui 
{

	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import dark.models.GameItem;
	import dark.Game;
	import dark.GameEnums;
	import dark.IGameDragEnterDelegate;
	import dark.models.CItemInfo;
	
	import dark.net.ICommandCallback;
	import dark.net.commands.PlayerItemUseCommand;
	import dark.netcallbacks.PlayerItemUseCallback;
	import dark.logics.IGameObjMoveToLogicDelegate;
	import dark.net.commands.MapChunkLoadCommand;
	import dark.netcallbacks.IPlayerItemUseCallbackDelegate;
	

	/**
	 * ...
	 * @author ahui
	 */
	public class ItemListView extends SimpleScrollView 
	{
		
		public static const CELL_NUM_X:int = 4;
		

		public var game:Game = null;
		
		private var _scrollable:VScrollableContainer = null;
		private var listSprite:Sprite = null;
		
		public var boxMargin:int = 1;
		
		private var _hitRect:Rectangle = null;
		
		public var isActive:Boolean = true;
		
		public function ItemListView(viewWidth:int, viewHeight:int, game:Game) 
		{
			
			this.game = game;
			
			super(viewWidth, viewHeight, game.app);
			
			_scrollable = new VScrollableContainer(viewWidth-64, viewHeight-64);
			
			_scrollable.y = 32;
			_scrollable.x = 32;		
			
			_hitRect =  new Rectangle(0, 0, viewWidth, viewHeight);
			
			addChild(_scrollable);
			
			listSprite = new Sprite();
			
			_scrollable.container.addChild(listSprite);
			
			displayInfoSprite = new DisplayItemInfoSprite();
			
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
			
		}
		

		public var displayInfoSprite:DisplayItemInfoSprite = null;		
		
		
		
		
		
		public function displayItemInfo(gameItem:GameItem, useDict:Boolean=true):void
		{
			game.cItemInfoFactory.displayItemInfoBySprite(displayInfoSprite, gameItem, useDict);
			
			
			game.container5.addChild(displayInfoSprite);
			
			displayInfoSprite.visible = true;
			
			displayInfoSprite.x = game.container5.mouseX;
			displayInfoSprite.y = game.container5.mouseY;
			
			if (stage != null)
			{
				var maxX2:Number = stage.stageWidth - 160;
				if (displayInfoSprite.x > maxX2)
				{
					displayInfoSprite.x = maxX2;
				}
			}
		}
		
		
		private function _onAddedToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, _onStageMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
		}
		
		private function _onRemoveFromStage(e:Event):void
		{
			displayInfoSprite.visible = false;
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, _onStageMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
		}
	
		
		
		
		private function _onStageMouseDown(e:MouseEvent):void
		{
			_isPress = true;
			var itemSprite:ItemSprite = _findMouseHitItemSprite();
			
			if (itemSprite != null)
			{
				_pressItemSprite = itemSprite;				
				trace("_pressItemSprite", itemSprite);
			}
			
		}
		
		private var _pressArray:Array = [];
		
		private var _lastPressTime:Number = 0;
		
		
		private function _checkClickSprite():Boolean
		{
			_pressArray.push(_pressItemSprite);
				
			var _pressArrayCount:int = _pressArray.length;
			
			for (var i:int = 2; i < _pressArrayCount; i++)
			{
				_pressArray.shift();
			}
				
				
			_selectSprite(_pressItemSprite);
				
			var now:Number = new Date().getTime();
				
			var pressDelta:Number = now - _lastPressTime;
				
			if (pressDelta < 500 && _pressArray.length == 2)
			{
				if (_pressArray[0] == _pressArray[1])
				{
					trace("Double Click", _pressArray);
					
					game.cItemInfoFactory.itemUse(_pressItemSprite.gameItem.id, new ItemListViewItemUseCallbackDelegate(_pressItemSprite, this));

					_pressArray.length = 0;
					
					_lastPressTime = now;
					_pressItemSprite = null;
					_itemDragSprte =  null;
					game.mouseHandler.setMouseDragItemNull();
					
					return true;
				}				
					
			}
				
			_lastPressTime = now;
				
			return false;
		}
		
		private function _onStageMouseUp(e:MouseEvent):void
		{
			trace("_onStageMouseUp");
			_isPress = false;
			if (_pressItemSprite != null)
			{
				
				if (_checkClickSprite()) {
					
					return;
				}
				
				if (!_hitRect.contains(mouseX, mouseY))
				{
					var dragEnterDelegate:IGameDragEnterDelegate = game.hitTestDragEnterDelegate();
				
					if (dragEnterDelegate != null)
					{
						
						
						var shortcutItem:CItemShortcutDelegate = new CItemShortcutDelegate(_pressItemSprite.gameItem, game);
						dragEnterDelegate.setDragEnterObj(shortcutItem);
					}
				}
				
				
				
				game.mouseHandler.setMouseDragItemNull();
			}
			
			_pressItemSprite = null;
			_itemDragSprte =  null;
		}
		
		private var _itemDragSprte:Sprite = null;
		
		
		private var _inRect:Boolean = false;
		private var _itemSpriteRect:Rectangle = new Rectangle(0, 0, 64, 64);
		
		private var _isPress:Boolean = false;
		
		private function _findMouseHitItemSprite():ItemSprite
		{
			for (var i:int = 0; i <listSprite.numChildren; i++)
			{
				var sprite:ItemSprite = listSprite.getChildAt(i) as ItemSprite;
				//trace("_findMouseHitItemSprite", sprite.mouseX, sprite.mouseY);
				if (_itemSpriteRect.contains(sprite.mouseX, sprite.mouseY))
				{
					return sprite;
				}
			}
			
			return null;
		}
		
		
		//private var _onMoveItemSprite:ItemSprite = null;
		
		private function _onStageMouseMove(e:MouseEvent):void
		{
			_inRect = _hitRect.contains(mouseX, mouseY);
			
			if (_inRect && isActive)
			{				
				var itemSprite:ItemSprite = _findMouseHitItemSprite();
					
				if (itemSprite != null)
				{
					displayItemInfo(itemSprite.gameItem);
				} else {
					displayInfoSprite.visible  = false;
				}
				
			} else 
			{
				
				displayInfoSprite.visible  = false;				
			}
			
			if (_isPress && _pressItemSprite != null)
			{
				if (_itemDragSprte == null)
				{
					_itemDragSprte = new Sprite();
					
					var g:Graphics = _itemDragSprte.graphics;
					g.clear();
					
					var bd:BitmapData = new BitmapData(64, 64, true, 0x00);
					bd.draw(_pressItemSprite);
					
					var bmp:Bitmap = new Bitmap(bd);					
					
					_itemDragSprte.addChild(bmp);
					
					bmp.x = -32;
					bmp.y = -32;
					
					game.mouseHandler.setMouseDragItem(_itemDragSprte);
				}
			}		
			
		}
		
		
		private var _pressItemSprite:ItemSprite = null;
		/*
		private function _onSpriteMouseDown(e:MouseEvent):void
		{
			_pressItemSprite = e.currentTarget as ItemSprite;
			
			trace("_onSpriteMouseDown", _pressItemSprite);
		}*/
		
		public function removeItem(itemId:int):void
		{
			var num:int = listSprite.numChildren;
			var i:int;
			var list:Array = [];
			var itemSprite:ItemSprite;
			
			for ( i = 0; i < num; i++)
			{
				itemSprite = listSprite.getChildAt(i) as ItemSprite;
				
				if (itemSprite.gameItem.id == itemId)
				{
					list.push(itemSprite);
				}
				
			}
			
			for ( i = 0; i < list.length; i++)			
			{
				itemSprite = list[i];
				removeItemSprite(itemSprite);
			}
			
		}
		
		public function removeItemSprite(itemSprite:ItemSprite):void
		{
			//itemSprite.removeEventListener(MouseEvent.MOUSE_DOWN, _onSpriteMouseDown);
			//itemSprite.removeEventListener(MouseEvent.CLICK, _onItemClick);
			//trace("removeItemSprite", itemSprite);
			if (itemSprite.parent != null)
			{
				itemSprite.parent.removeChild(itemSprite);
			}
			
			
			sortItemSprites();
		}
		
		public function sortItemSprites():void
		{
			var i:int = 0;
			var ix:int = 0;
			var iy:int = 0;
			
			for (i = 0; i < listSprite.numChildren; i++)
			{
				ix = i % CELL_NUM_X;
				iy = i / CELL_NUM_X;
				var sprite:ItemSprite = listSprite.getChildAt(i) as ItemSprite;
				sprite.x = ix * GameEnums.ITEMLIST_BOX_SIZE + ix * boxMargin;
				sprite.y = iy * GameEnums.ITEMLIST_BOX_SIZE + iy * boxMargin;
			}
			
			_scrollable.draw();
			_drawGrid();
		}
		
	
		public function clear():void
		{
			game.cItemInfoFactory.clearGetInfoDict();
			
			
			var numChildren:int =  listSprite.numChildren;
			for (var i:int = 0; i <numChildren; i++)
			{
				var sprite:ItemSprite = listSprite.getChildAt(0) as ItemSprite;
				if (sprite != null)
				{
					//sprite.removeEventListener(MouseEvent.MOUSE_DOWN, _onSpriteMouseDown);
					//sprite.removeEventListener(MouseEvent.CLICK, _onItemClick);
					
				}
				
				listSprite.removeChildAt(0);
			}
		}
		
		public function appendItem(item:GameItem):void
		{
			
			var idx:int = listSprite.numChildren;
			
			var sprite2:ItemSprite = new ItemSprite(item, this);
			sprite2.setTemplateId(item.templateId, game.app);			
				
				
			listSprite.addChild(sprite2);	
			
			var ix:int = idx % CELL_NUM_X;
			var	iy:int = idx / CELL_NUM_X;
			
			sprite2.x = ix * GameEnums.ITEMLIST_BOX_SIZE + ix * boxMargin;
			sprite2.y = iy * GameEnums.ITEMLIST_BOX_SIZE + iy * boxMargin;

			//trace(sprite2, sprite2.x, sprite2.y);
		}
		
		public function loadItemList(items:Array):void
		{

			clear();
			
			//trace("loadItemList", items.length, listSprite.numChildren);
			var i:int = 0;
			
			for (i = 0; i < items.length; i++)
			{
				var item:GameItem = items[i];
				
				
				
				var sprite2:ItemSprite = new ItemSprite(item, this);
				sprite2.setTemplateId(item.templateId, game.app);
				
				//sprite2.addEventListener(MouseEvent.MOUSE_DOWN, _onSpriteMouseDown);
				//sprite2.addEventListener(MouseEvent.CLICK, _onItemClick);
				
				listSprite.addChild(sprite2);	
			}
			
			sortItemSprites();
			
			
		}
		
		
		private function _selectSprite(sprite:ItemSprite):void
		{
			var iSprite:ItemSprite = null;
			for (var i:int = 0; i < listSprite.numChildren; i++)
			{
				iSprite = listSprite.getChildAt(i) as ItemSprite;
				iSprite.isSelected = false;
				iSprite.draw();
			}
			
			//sprite = e.currentTarget as ItemSprite;
			sprite.isSelected = true;
			sprite.draw();
		}
		
		
	
		private function _drawGrid():void
		{
			if (listSprite == null) return;
			
			var g:Graphics = listSprite.graphics;
			
			
			g.clear();
			
			var BDKlass:Class = game.app.getUIBDKlass(5);
			
			trace("BDKlass", BDKlass);
			
			var bd:BitmapData = new BDKlass();				

			
			var bdBox:BitmapData = new BitmapData(58,  58, true, 0x00);
	
			
			//bdBox.draw(bd, boxMatrix);
			bdBox.copyPixels(bd, new Rectangle(211, 918, 58, 58), new Point(0, 0), null, null, true);
		
			
			var box2:BitmapData = new BitmapData(GameEnums.ITEMLIST_BOX_SIZE+boxMargin, GameEnums.ITEMLIST_BOX_SIZE+boxMargin);
			
			var scaleX:Number = GameEnums.ITEMLIST_BOX_SIZE / 58;
			
			var matrix1:Matrix = new Matrix();
			matrix1.scale(scaleX, scaleX);
			
			box2.draw(bdBox, matrix1);
			
			
			var numRows:int = listSprite.numChildren / CELL_NUM_X + 1;		
			
			if (numRows < 6)
			{
				numRows = 6;
			}
			
			g.beginBitmapFill(box2, null, true, false);
			g.drawRect(0, 0, GameEnums.ITEMLIST_BOX_SIZE * 4 + boxMargin * 4,  GameEnums.ITEMLIST_BOX_SIZE * numRows + boxMargin * numRows);
			g.endFill();
			
			
		}
		
		
		override public function draw():void 
		{
			super.draw();
			
			drawBgStyle1();		
			_drawGrid();
			
		}
		
		public function checkMouseInUI():Boolean
		{
			if (isActive)
			{
				var hit:Boolean = _hitRect.contains(mouseX, mouseY);
				if (hit) return true;
			}
			
			return false;
		}
		
	}

}