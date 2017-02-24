package dark.ui 
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextDisplayMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import dark.IGameDragEnterDelegate;
	import dark.Game;
	import dark.net.CharacterSkillItem;	
	/**
	 * ...
	 * @author 
	 */
	public class CharacterSkillListView extends LazyBoxSprite
	{
		
		public var game:Game = null;
		
		private var _scrollableContainer:VScrollableContainer = null;
		public var container:Sprite = null;		
		
		public var txtSprite:BaseDisplayNameSprite = null;
		
		public var isActive:Boolean = true;

	
		
		public function CharacterSkillListView(viewWidth:int, viewHeight:int, game:Game) 
		{
			this.game = game;
			
			super(viewWidth, viewHeight, game.app);
			
			_scrollableContainer = new VScrollableContainer(viewWidth-64, viewHeight-64);
			
			container = new Sprite();
			_scrollableContainer.container.addChild(container);
			
			addChild(_scrollableContainer);
			
			_scrollableContainer.x = 32;
			_scrollableContainer.y = 32;
			
			_gameMouseRect = new Rectangle(0, 0, viewWidth, viewHeight);
			
			txtSprite = new BaseDisplayNameSprite();
		
			txtSprite.visible = false;
			
			game.container5.addChild(txtSprite);
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
		}		
		
		private var _gameMouseRect:Rectangle = null;
		
		public function checkMouseInUI():Boolean
		{
			if (isActive)
			{
				if (_gameMouseRect.contains(this.mouseX, this.mouseY))
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function hitGameMouseInRect():Boolean
		{
			if (_gameMouseRect.contains(this.mouseX, this.mouseY))
			{
				return true;
			}
			
			return false;
		}
		
		
			
		private function _onRemoveFromStage(e:Event):void
		{
		
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_OVER, _onStageMouseOver);
			
			txtSprite.visible = false;
			
			
		}
		
		private function _onAddedToStage(e:Event):void
		{
		
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_OVER, _onStageMouseOver);
		}
		
		private function _onStageMouseOver(e:MouseEvent):void
		{
			//trace("_onStageMouseOver", e);
		}
		
		private function _onMouseUp(e:MouseEvent):void
		{
			
			if (_pressItemSprite != null)
			{
				trace("_DragItemSprite", _pressItemSprite);
				
				var dragEnterDelegate:IGameDragEnterDelegate = game.hitTestDragEnterDelegate();
				
				if (dragEnterDelegate != null)
				{
					dragEnterDelegate.setDragEnterObj(_pressItemSprite.shortcutDelegate);
				}
				
				game.mouseHandler.setMouseDragItemNull();
			}
			
			_pressItemSprite = null;
			_itemDragSprte =  null;
		}
		
		private var _itemRect:Rectangle = new Rectangle(0, 0, 64, 64);
		
		public function hitMouseItemSprite():CSkillListItemSprite
		{
			
			for (var i:int = 0; i < container.numChildren; i++)
			{
				var sprite:CSkillListItemSprite = container.getChildAt(i) as CSkillListItemSprite;
				if (_itemRect.contains(sprite.mouseX, sprite.mouseY))
				{
					return sprite;
				}
			}
			
			return null;
		}
		
		private var _itemDragSprte:Sprite = null;
		
		private function _onStageMouseMove(e:MouseEvent):void
		{
			
			var inRect:Boolean = _gameMouseRect.contains(this.mouseX, this.mouseY);
			
			if (inRect && isActive)
			{
				
				var itemSprite:CSkillListItemSprite = hitMouseItemSprite();
				if (itemSprite != null)
				{
					displayItemName(itemSprite.item);
				} else
				{
					txtSprite.visible = false;
				}
				
				
			} else 
			{
				txtSprite.visible = false;
			}
			
			
			
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
					
					trace("setMouseDragItem SKILL", _pressItemSprite);
					game.mouseHandler.setMouseDragItem(_itemDragSprte);
				}
			}		
			
		}
		
		private var _pressItemSprite:CSkillListItemSprite = null;
		
		private function _onSpriteMouseDown(e:MouseEvent):void
		{
			_pressItemSprite = e.currentTarget as CSkillListItemSprite;
		}

		
		public function displayItemName(item:CharacterSkillItem):void
		{
			if (_pressItemSprite != null)
			{
				return;
			}			
			
			//trace("showItemName", item);
			
			txtSprite.visible = true;
			txtSprite.x = game.container5.mouseX;
			txtSprite.y = game.container5.mouseY;
			
			txtSprite.setText(item.name);
		}
		
		public function initItems(items:Array):void
		{
			var i:int = 0;
			var ix:int = 0;
			var iy:int = 0;
			
			var sprite:CSkillListItemSprite = null;
			
			var cNumChildren:int = container.numChildren;
			
			for (i = 0; i < cNumChildren; i++)
			{
				sprite = container.getChildAt(0) as CSkillListItemSprite;
				if (sprite != null)
				{
					sprite.removeEventListener(MouseEvent.MOUSE_DOWN, _onSpriteMouseDown);
					sprite.removeEventListener(MouseEvent.CLICK, _onItemClick);
				}
				container.removeChildAt(0);
			}
			
			for (i = 0; i < items.length; i++)
			{
				ix = i % 4;
				iy = i / 4;
				
				var item:CharacterSkillItem = items[i];
				
				sprite = new CSkillListItemSprite(item, this, game);
				
				sprite.addEventListener(MouseEvent.MOUSE_DOWN, _onSpriteMouseDown);
				sprite.addEventListener(MouseEvent.CLICK, _onItemClick);
				
				container.addChild(sprite);			
				
				
				sprite.x = ix * 64;
				sprite.y = iy * 64;
				
				trace("initItems", item);
			}
		}
		
		
		
		private var _lastPressTime:Number = 0;
		private var _lastPressObj:CSkillListItemSprite = null;
		
		private function _onItemClick(e:MouseEvent):void
		{
			var now:Number = new Date().getTime();
			trace("_onItemPress", now);
			
			var pressDelta:Number = now - _lastPressTime;		
			
			
			var sprite:CSkillListItemSprite = null;
			
			
			for (var i:int = 0; i < container.numChildren; i++)
			{
				sprite = container.getChildAt(i) as CSkillListItemSprite;
				//sprite.isSelected = false;
				sprite.draw();
			}
			
			sprite = e.currentTarget as CSkillListItemSprite;
			//sprite.isSelected = true;
			sprite.draw();
			
			if (pressDelta < 500 && sprite == _lastPressObj)
			{
				trace("_onItemDoubleClick", sprite);
				game.playerUseSkill(sprite.item.skillId, sprite.item.targetType);			
				
				
			}
			
			_lastPressObj = sprite;
			_lastPressTime = now;
		}
		
		public function draw():void
		{
			drawBgStyle1();
			
			var g:Graphics = container.graphics;
			
			g.clear();
			
			var BDClass:Class = app.getUIBDKlass(4);
			var bd:BitmapData = new BDClass();
			
			var box:BitmapData = new BitmapData(83, 83, true, 0x00);
			
			box.copyPixels(bd, new Rectangle(289, 915, box.width, box.height), new Point(), null, null, false);
			
			
			var matrix:Matrix = new Matrix();
			
			matrix.scale(64 / box.width, 64 / box.height);
			
			g.beginBitmapFill(box, matrix, true, false);
			
			g.drawRect(0, 0, 64*4, 64*8);
			g.endFill();
			
		}
		
	}

}