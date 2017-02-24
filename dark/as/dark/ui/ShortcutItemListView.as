package dark.ui 
{
	
	import dark.models.CItemInfo;
	import dark.net.commands.PlayerShortcutSetItemCommand;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import dark.IGameDragEnterDelegate;
	import dark.Game;
	
	
	public class ShortcutItemListView extends LazyBoxSprite implements IGameDragEnterDelegate
	{
		
		public var game:Game = null;
		
		private  var _hitTestDragEnterRect:Rectangle = null;
		
		private var container:Sprite = null;
		public var displayInfoSprite:DisplayItemInfoSprite = null;	
		private var _hitRect:Rectangle = null;
		
		public function ShortcutItemListView(viewWidth:int, viewHeight:int, game:Game) 
		{
			
			this.game = game;
			
			super(viewWidth, viewHeight, game.app);
			
			container = new Sprite();
			
			addChild(container);
			
			container.x = 16;
			container.y = 16;
			
			_hitTestDragEnterRect = new Rectangle(0, 0, viewWidth, viewHeight);
			
			_hitRect = new Rectangle(0, 0, viewWidth, viewHeight);
			
			initBoxes();
			
			displayInfoSprite = new DisplayItemInfoSprite();
			
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeFromStage);
		}
		
		public function initBoxes():void
		{
			var keys:Array = [Keyboard.Q, Keyboard.W, Keyboard.E, Keyboard.R];
			
			var ix:int = 0;
			var iy:int = 0;
			
			for (var i:int = 0; i <	keys.length; i++)
			{
				ix = i % 4;
				iy = i / 4;
				var sprite:ShortcutItemSprite = makeSprite(keys[i], ix * 64, iy * 64)
				
				container.addChild(sprite);
			}

			
		}
		
		private function makeSprite(keyCode:uint, x2:Number, y2:Number):ShortcutItemSprite
		{
			var sprite:ShortcutItemSprite = new ShortcutItemSprite(keyCode, this);
			sprite.x = x2;
			sprite.y = y2;
			
			return sprite;
		}
		
		
		private function _onAddedToStage(e:Event):void
		{
			//stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, _onStageMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onStageKeyPress);
		}
		
		private function _removeFromStage(e:Event):void
		{
			
			displayInfoSprite.visible = false;
			//stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, _onStageMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, _onStageKeyPress);
		}
		
	
		
		public function displayItemInfo(itemSprite:ShortcutItemSprite, useDict:Boolean=true):void
		{
	

			if (itemSprite.itemSource != null)
			{
		
				
				
				itemSprite.itemSource.displayShortcutItemInfo(displayInfoSprite);
				
			}
			
		
			game.container5.addChild(displayInfoSprite);
			
			displayInfoSprite.visible = true;
			
			displayInfoSprite.x = game.container5.mouseX;
			displayInfoSprite.y = game.container5.mouseY;

		}

		
		private function _onStageMouseDown(e:MouseEvent):void
		{
		
		}
		
		private var _pressObjs:Array = [];
		private var _lastPressTime:Number = 0;
		
		private function _onStageMouseUp(e:MouseEvent):void
		{
			var sprite:ShortcutItemSprite = hitTestMouseShortcutSprite();
			
			if (sprite != null)
			{
				_pressObjs.push(sprite);
				
				var _pressObjsLen:int = _pressObjs.length;
				for (var i:int = 2; i < _pressObjsLen; i++)
				{
					_pressObjs.shift();
				}
				
				var now:Number = new Date().getTime();
				
				var delta:Number = now - _lastPressTime;
				if (delta < 500 && _pressObjs.length == 2)
				{
					if (_pressObjs[0] == _pressObjs[1])
					{
						
						
						var delegate:IShortcutItemUseDelegate = _getDelegateByKey[sprite.keyCode];
						
						if (delegate != null)
						{
							
							delegate.onShortcutItemUse();
						}
						
						
						_pressObjs.length = 0;
						_lastPressTime = now;
						
						
						return;
					}
				}
				
				_lastPressTime = now;
			}
		
		}
		
		
		
		private function _onStageMouseMove(e:MouseEvent):void
		{
			var _inRect:Boolean = _hitRect.contains(mouseX, mouseY);
			
			if (_inRect)
			{				
				var itemSprite:ShortcutItemSprite = hitTestMouseShortcutSprite();
				
			
					
				if (itemSprite != null)
				{					
					displayItemInfo(itemSprite);
				} else {
					displayInfoSprite.visible  = false;
				}
				
			} else 
			{
				
				displayInfoSprite.visible  = false;				
			}
			
			/*
			if (_pressItemSprite != null)
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
			}	*/	
			
		}
		
		private function _onStageKeyPress(e:KeyboardEvent):void
		{
			
			var delegate:IShortcutItemUseDelegate = _getDelegateByKey[e.keyCode];
			
			if (delegate != null)
			{
				delegate.onShortcutItemUse();
			}
			
			
		}
		
		private var _getDelegateByKey:Dictionary = new Dictionary();
		
		private var _itemRect:Rectangle = new Rectangle(0, 0, 64, 64);
		
		public function hitTestMouseShortcutSprite():ShortcutItemSprite
		{		
			
			for (var i:int = 0; i < container.numChildren; i++)
			{
				var sprite:ShortcutItemSprite = container.getChildAt(i) as ShortcutItemSprite;
				
				if (_itemRect.contains(sprite.mouseX, sprite.mouseY))
				{
					return sprite;
				}
				
			}			
			
			return null;
		}

		
		public function hitTestDragEnterShortcutSprite():ShortcutItemSprite
		{		
			var sprite:ShortcutItemSprite = null;
			
			for (var i:int = 0; i < container.numChildren; i++)
			{
				sprite = container.getChildAt(i) as ShortcutItemSprite;
				
				if (sprite.dragHitTest())
				{
					return sprite;
				}
				
			}			
			
			return null;
		}
		
		public function setItemSourceByIdxCode(itemSource:IShortcutItemSource, idxCode:int):void		
		{
			trace("setItemSourceByIdxCode", idxCode);
			var index:int = 0;
			switch (idxCode) 
			{
				case 0:
					index = 0;
					break;
				case 1:
					index = 1;
					break;
				case 2:
					index = 2;
					break;
				case 3:
					index = 3;
					break;
			}
			setItemSourceByIndex(itemSource, index);
		}
		
		public function setItemSourceByIndex(itemSource:IShortcutItemSource, index:int):void		
		{
			trace("setItemSourceByIndex", index);
			var sprite:ShortcutItemSprite = container.getChildAt(index) as ShortcutItemSprite;
			
			if (sprite != null)
			{
				sprite.itemSource = itemSource;
				var delegate:IShortcutItemUseDelegate =  itemSource.getShortcutItemUseDelegate(); 
					
				//trace("setItemSourceByIndex", itemSource, index);
						
				sprite.setICONBitmapData(itemSource.getShortcutItemBitmapData());
						
				_getDelegateByKey[sprite.keyCode] = delegate;
			}
		}
		
		public static function getShortcutItemIdx(sprite:ShortcutItemSprite):int
		{
			
			switch (sprite.keyCode) 
			{
				case Keyboard.Q:
					return 0;
				case Keyboard.W:
					return 1;
				case Keyboard.E:
					return 2;
				case Keyboard.R:
					return 3;
				default:
			}
			
			
			return 0;
		}
		
		public function setDragEnterObj(obj:*):void
		{
			var sprite:ShortcutItemSprite = hitTestDragEnterShortcutSprite();
			
			if (sprite != null)
			{
			
				if (obj is IShortcutItemSource)
				{
					var iSource:IShortcutItemSource = obj as IShortcutItemSource;
					var delegate:IShortcutItemUseDelegate =  iSource.getShortcutItemUseDelegate(); 
					
					//trace("setDragEnterObj", obj);
					sprite.itemSource = iSource;
					sprite.setICONBitmapData(iSource.getShortcutItemBitmapData());
					
					_getDelegateByKey[sprite.keyCode] = delegate;
					
					var idx:int = getShortcutItemIdx(sprite);
					
					var setItem:PlayerShortcutSetItemCommand = new PlayerShortcutSetItemCommand(idx, iSource.getStorageType(), iSource.getStorageId());
					game.writeCommand(setItem);
					
				}
			}
		}
		
		public function hitTestDragEnter(stage:Stage):Boolean
		{
			//trace("hitTestDragEnter", _hitTestDragEnterRect.contains(mouseX, mouseY));
			if (this.visible)
			{
				if (this._hitTestDragEnterRect.contains(mouseX, mouseY))
				{
					return true;
				}
				
			}
			
			
			return false;
		}
		
		public function draw():void
		{
			var g:Graphics = this.graphics;
			
			g.clear();
			
			drawBgStyle1();
			/*
			
			
			
			var BDKlass:Class = game.app.getUIBDKlass(7);
			
			trace("BDKlass", BDKlass);
			
			var bd:BitmapData = new BDKlass();
			
			var matrix:Matrix = new Matrix();
			
			matrix.tx = 0;
			matrix.ty = -640;
			
			g.beginBitmapFill(bd, matrix);		
		
			g.drawRect(0, 0, viewWidth, viewHeight);			

			g.endFill();
			
			g.lineStyle(1, 0xff0000);
			
			g.drawRect(0, 0, viewWidth, viewHeight);
			*/
		}
		
		
		public function checkMouseInUI():Boolean
		{
			if (visible)
			{
				if (_hitRect.contains(mouseX, mouseY))
				{
					return true;
				}
			}
			
			return false;
		}
		
	}

}