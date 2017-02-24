package dark 
{
	
	import flash.display.DisplayObject;
	import flash.geom.Point;	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	import dark.display.SceneCItemDisplayDataList;

	import dark.display.SceneCItemDisplayData;
	import dark.logics.AnimationLogic;
	import dark.logics.StandAnimationLogic;
	import dark.ui.DisplayGameObjNameSprite;
	import dark.display.BitmapAnimation;
	import dark.net.commands.GetObjNameCommand;
	import dark.net.GameObjectKey;
	import dark.netcallbacks.GetNameCallbackData;
	import dark.sprites.*;
	
	public class LazyGameObjectSpriteBase extends Sprite implements IGameObject, IGameMouseHitTest
	{
		
		public var displayDelegate:IGameLazyDisplayDelegate = null;
		private var _released:Boolean = false;
		
		private var _objContainer:Sprite = null;		
	

		public var canAttack:Boolean = false;		
		
		public var pressWalkTo:Boolean = true;
		
		public var mouseDelegate:IGameLazyObjMouseDelegate = null;
		
	
		
		public function LazyGameObjectSpriteBase() 
		{					
			_objContainer = new Sprite();
			this.addChild(_objContainer);
			
			//_objContainer.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			
			//this.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			//this.addEventListener(MouseEvent.MOUSE_DOWN, _onMousePress);
			//this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			//drawRect();
		}	
		
		
		public function gameHitTestMouse(mx:Number, my:Number):Boolean
		{
			if (displayDelegate != null)
			{
				
				return displayDelegate.gameHitTestMouse(mx, my);
			}		
			
			return false;
		}
		
		public function setMouseDelegate(mouseDelegate:IGameLazyObjMouseDelegate)
		{
			this.mouseDelegate = mouseDelegate;
		}
		
		public function getMouseDelegate():IGameLazyObjMouseDelegate
		{
			return this.mouseDelegate;
		}
		
	
		
		public function getObjType():int
		{
			return 0;
		}
		
		public function getObjKey():GameObjectKey
		{
			return null;
		}
		
		public function get game():Game
		{
			return null;
		}
		
		public function get gamePt():Point
		{
			return null;
		}
		
		public function getInteractiveDelegate():IGameInteractiveDelegate
		{
			return null;
		}
		
		
		public function calcDisplayNameSpritePt(pt:Point):void
		{
			pt.x = flashX
			pt.y = flashY;
			
			if (displayDelegate != null)
			{
				pt.y += displayDelegate.getNameBoxY();
				
			} else 
			{			
				pt.y += (_objContainer.height + 20);
			}
			
		}
		

		
		
		private var _txtGlow:GlowFilter = new GlowFilter(0x000000, 1, 3, 3, 2);
		
		public var setInteractiveDataCallback:Function = null;
		
		public function drawRect():void
		{
			var g:Graphics = this.graphics;
			
			g.lineStyle(2, 0xff0000);
			
			g.drawRect(0, 0, 128, 128);
			
		}
		
		public	function get released():Boolean		
		{
			return _released;
		}
		
		public function set released(value:Boolean):void
		{
			_released = value;
		}
		
		public function get flashX():int
		{
			return x;
		}
		
		public function get flashY():int
		{
			return y;
		}
		
		
		private var _animationWork:IGameObjAnimationWork = null;
		
		public function setAnimationWork(iWork:IGameObjAnimationWork):void
		{			
			/*
			if (_animationWork != null && !_animationWork.isDone)
			{
				trace("replace AnimationWork", _animationWork, iWork);
			}*/
			
			_animationWork = iWork;
			if (iWork != null)
			{
				iWork.initWork();
			}
		}
		
		public function updateState(nowTime:Number):void
		{
			if (_animationWork != null)
			{
				try 
				{			
					_animationWork.runWork(nowTime);
				} catch (err:Error)
				{
					_animationWork.except(err);
				}
				
				if (_animationWork != null && _animationWork.isDone)
				{
					_animationWork = null;
				}
			}
			
			
			try	{
				if (_animationWork == null && standAnimationLogic != null)
				{
					
					standAnimationLogic.updateNext(nowTime);					
				}
		
			} catch (err:Error)
			{
				trace("standAnimationLogic", err.getStackTrace());
			}
		}
		
		
		public var standAnimationLogic:StandAnimationLogic = null;

		
		private var _direction:int = 0;
		
		public function changeDirection(direction:int):void
		{
			_direction = direction;
			if (displayDelegate != null)
			{
				//trace("changeDirection", direction);
				displayDelegate.changeDirection(direction);
			}
		}
		
		public function get direction():int
		{
			return _direction;
		}
		
		public function getDisplayDelegate():IGameLazyDisplayDelegate
		{
			return displayDelegate;
		}	
		
		
		private function _initNPC001():void
		{

			var lazyDelegate:Npc001DisplayDelegate = new Npc001DisplayDelegate(game);
			
			this.displayDelegate = lazyDelegate;
			
			lazyDelegate.changeDirection(4);
			
			_objContainer.addChild(lazyDelegate);
			
			
			standAnimationLogic = new StandAnimationLogic(lazyDelegate, game);
			standAnimationLogic.init();
		}
		
		private function _initNPC002():void
		{
			var lazyDelegate:Npc002DisplayDelegate = new Npc002DisplayDelegate(game);
			
			this.displayDelegate = lazyDelegate;
			
			lazyDelegate.changeDirection(4);
			
			_objContainer.addChild(lazyDelegate);			
			
			standAnimationLogic = new StandAnimationLogic(lazyDelegate, game);
			standAnimationLogic.init();
		}
		
	
		
		private function _initNPC051():void
		{
			var lazyDelegate:Npc051DisplayDelegate = new Npc051DisplayDelegate(game);
			
			this.displayDelegate = lazyDelegate;
			
			lazyDelegate.changeDirection(4);
			
			_objContainer.addChild(lazyDelegate);
			
			
			standAnimationLogic = new StandAnimationLogic(lazyDelegate, game);
			standAnimationLogic.init();
		}
		
		
		private function _initNPC031():void
		{
			var lazyDelegate:Npc031DisplayDelegate = new Npc031DisplayDelegate(game);
			
			this.displayDelegate = lazyDelegate;
			
			lazyDelegate.changeDirection(4);
			
			_objContainer.addChild(lazyDelegate);
			
			
			standAnimationLogic = new StandAnimationLogic(lazyDelegate, game);
			standAnimationLogic.init();
		}
		
		private function _initWithLazyNPCDelegateClass(DelegateClass:Class):void
		{
			var lazyDelegate:LazyNPCDisplayDelegate = new DelegateClass(game);
			
			this.displayDelegate = lazyDelegate;
			
			lazyDelegate.changeDirection(4);
			
			_objContainer.addChild(lazyDelegate);
			
			
			standAnimationLogic = new StandAnimationLogic(lazyDelegate, game);
			standAnimationLogic.init();
		}
		
		
	
		public function setTemplateId(objType:int, templateId:int):void
		{
			
			//clear children
			
			var numChildren:int = _objContainer.numChildren;
			
			for (var i:int = 0; i < numChildren; i++)
			{
				_objContainer.removeChildAt(0);
			}
			
			switch (templateId) 
			{
				
				case GameTemplateEnums.TC_NPC001:
					_initNPC001();
					break;
					
				case GameTemplateEnums.TC_NPC002:
					_initNPC002();
					break;
				case GameTemplateEnums.TC_NPC003:
					_initWithLazyNPCDelegateClass(Npc054DisplayDelegate);
					break;
					
				case GameTemplateEnums.TC_NPC051:
					_initWithLazyNPCDelegateClass(Npc051DisplayDelegate);
					break;
				
				case GameTemplateEnums.TC_NPC052:
					_initWithLazyNPCDelegateClass(Npc052DisplayDelegate);
					break;
				case GameTemplateEnums.TC_NPC053:
					_initWithLazyNPCDelegateClass(Npc053DisplayDelegate);
					break;
				case GameTemplateEnums.TC_NPC054:
					_initWithLazyNPCDelegateClass(Npc054DisplayDelegate);
					break;
					
				case GameTemplateEnums.TC_OLDMAN01:
					_initNPC002();
					break;
					
				case GameTemplateEnums.TC_BLADEMASTER:
					_initNPC002();
					break;
					
				case GameTemplateEnums.TC_DRAGON01:
					_initNPC031();
					break;
				
					
				default:
			}
			

			
			if (templateId >= GameTemplateEnums.T_SCENEITEM_START && templateId <= GameTemplateEnums.T_SCENEITEM_START +1000)
			{
				_setSceneItemTemplateId(templateId);
			}
		}
		
		private function _setSceneItemTemplateId(templateId:int):void
		{
			
			var displayDataList:SceneCItemDisplayDataList = game.app.getSceneCItemDisplayDataList(templateId);
			
			trace("displayDataList", displayDataList, templateId);
			var lazyDelegate:LazyCItemDisplayDelegate = new LazyCItemDisplayDelegate(displayDataList, game);
			
			this.displayDelegate = lazyDelegate;
			
			//lazyDelegate.changeDirection(4);
			
			_objContainer.addChild(lazyDelegate);
			
			
		}
		
		
	}

}