package dark 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import dark.*;
	import dark.netcallbacks.GameObjGetNameCallback;
	import dark.objworks.DisplayDelegateWalkToAnimationWork;
	import dark.views.LazyGameView;	
	import dark.simple.*;
	import dark.net.commands.*;
	import dark.works.*;

	/**
	 * ...
	 * @author ahui
	 */
	public class LazyGameMouseHandler 
	{
		
		public var game:Game = null;
		private var _isPress:Boolean = false;		
	
		public var mouseSprite:GameMouse = null;		
		
		public var enabledWalk:Boolean = false;
		public var enabledSkill:Boolean = false;		
	
			
		public function LazyGameMouseHandler(game:Game) 
		{
			this.game = game;
			
			
			mouseSprite = new GameMouse(game);
			
			game.container4.addChild(mouseSprite);
		}	
		
		
		private var _isDragging:Boolean = false;
		
		public function setMouseDragItemNull():void
		{
			_isDragging = false;
			mouseSprite.setMouseDragChild(null);
		}
		

		
		public function setMouseDragItem(image:Sprite):void
		{
			_isDragging = true;
			mouseSprite.setMouseDragChild(image);
		}
		
		public function addEventListener():void
		{
				
			//game.stage.addChild(mouseSprite);	
			
			//game.container.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			game.stage.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			game.stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			game.stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
		}
		
		public function removeEventListener():void
		{
			//game.stage.addChild(mouseSprite);	
			//game.container.removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			game.stage.removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			game.stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			game.stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
		}
		

		private var _prevMouseMoveGameObj:IGameObject = null;
		public var currentMouseGameObj:IGameObject = null;
		
		private var _lastGameObjGetNameObj:IGameObject = null;
		
		private var _lastGetNameTime:Number = 0;
		private var _lastGetNameCallback:GameObjGetNameCallback = null;
		
		
		public function update(nowTime:Number):void
		{
			//trace("update", nowTime);
			updateMouse();
			
		}
		
		private function _gameGetNameCheck(iobj:IGameObject, nowTime:Number):void
		{
			if (iobj == null) return;
				
				var getNameWork:Boolean = false;
						
				if (iobj != _lastGameObjGetNameObj)
				{
					getNameWork = true;
				}
						
				if (getNameWork == false)
				{
					var delta:Number = nowTime -_lastGetNameTime;
							
					if (delta >= 1000)
					{
						getNameWork = true;
					}
				}
						
						//trace("getNameWork",nowTime, getNameWork);
						
				if (_lastGetNameCallback == null)
				{
					getNameWork = true;
				}
						
				if (getNameWork)
				{						

					var callback:GameObjGetNameCallback = new GameObjGetNameCallback(currentMouseGameObj, game);
					
					game.displayGameObjName(currentMouseGameObj, callback); 
					
					_lastGetNameCallback = callback;					
					_lastGetNameTime = nowTime;	
					
				}		
						
				_lastGameObjGetNameObj = iobj;
				
			

		
		}
		
		private var _lastHitTestMouseGameObjTime:Number = 0;
		
		public function hitTestMouseGameObj()
		{
			if (game.view != null)
			{
				var nowTime:Number = new Date().time;
				
				var delta:Number = nowTime - _lastHitTestMouseGameObjTime;
				
				if (delta > 100)
				{
					//trace("hitTestMouseGameObj");
					
					var iobjs:Array = game.view.mouseHitTestGameObj();
					
					//trace("hitTest", iobjs);
					
					if (iobjs.length > 0)
					{
						
						var iobj:IGameObject = null;
						
						if (iobjs.length == 1)
						{
							iobj = iobjs[0];					
						} else
						{
							
							iobjs.sortOn("flashY");
							
							iobj = iobjs[iobjs.length - 1];
							
						}
						
						if (_prevMouseMoveGameObj != null && _prevMouseMoveGameObj != iobj)
						{
							game.view.displayNameContainer.hideGameObjName(_prevMouseMoveGameObj);
							
							//trace("hideGameObjName", _prevMouseMoveGameObj);
								
							
						}
						
						
						currentMouseGameObj = iobj;
						
						if (iobj != null)
						{
							
							_gameGetNameCheck(iobj, nowTime);
							
						} 
						
						_prevMouseMoveGameObj = currentMouseGameObj;

					
					} else {
						currentMouseGameObj = null;
					}
					
					_lastHitTestMouseGameObjTime = nowTime;
				}
				
			}
		}
		
		
		
		public function updateMouse()
		{
			if (_isDragging) return;
			
			if (_isPress) return;
			
			if (_mouseHitTestUI()) return;
			
			
			hitTestMouseGameObj();
			
			if (currentMouseGameObj == null)
			{
				if (_selectTargetDelegate == null)
				{
					this.setMouseNormal();
				}
			
				if (_lastGameObjGetNameObj != null)
				{
					game.view.displayNameContainer.hideGameObjName(_lastGameObjGetNameObj);
					//_lastGameObjGetNameDelegate.hideGameObjName();
					_lastGameObjGetNameObj = null;
				}					
				
				_prevMouseMoveGameObj = null;
				_lastGetNameCallback = null;
			}
		}
		
		private function _onStageMouseMove(e:MouseEvent)
		{			
			
			updateMouse();
			
			
			//debug
			if (game.view != null)
			{
				
				if (game.messageTextField != null)
				{
					var pt1:Point = new Point(-game.view.container.x + game.view.container.mouseX, game.view.container.y + game.view.container.mouseY);
					var pt2:Point = game.view.flashPtToGameCellPt(game.view.container.mouseX, game.view.container.mouseY);
				
				//var y2:Number = (int)((view.centerIsoPt.y - view.viewRect.height / 2 + stage.mouseY) / MapRect.MAP_TAIL_HEIGHT);
					game.messageTextField.text = "mouse=" + pt1 + " fpt=" + pt2 + "cpt=" + game.view.container.x;
				}	
			
			}
		}		
		
		
		
		private function _mouseHitTestUI():Boolean
		{
			
			
			if (game.itemListView != null && game.itemListView.checkMouseInUI())
			{
				
				return true;
			}
			
			if (game.characterSkillListView != null && game.characterSkillListView.checkMouseInUI())
			{
				return true;
			}
			
			if (game.characterInfoView != null && game.characterInfoView.checkMouseInUI())
			{
				return true;
			}
			
			
			
			if (game.shortcutsItemListView != null && game.shortcutsItemListView.checkMouseInUI())
			{
				return true;
			}
			
			return false;
		}
		
		private function _mouseDown(e:MouseEvent):void
		{
			_isPress = true;
			_mouseUpDoWalk = true;
			
			if (_selectTargetDelegate != null)
			{
				return;
			}
			

			if (_mouseHitTestUI())
			{
				_mouseUpDoWalk = false;		
				return;
			}
			
			
			//trace("_mouseDown", currentMouseGameObj);
			
			if (currentMouseGameObj != null)
			{

				
					
				
				var mouseHandler:IGameLazyObjMouseDelegate = currentMouseGameObj.getMouseDelegate();
						
				if (mouseHandler != null)
				{
							
					var works:Array = mouseHandler.calcPressWork(game);
							
					if (works != null)
					{
						player.clearPlayerWorks();
						for (var i:int = 0; i < works.length; i++)
						{
							var work:IGameObjWork = works[i];
							player.putPlayerWork(work);
						}
								
						_mouseUpDoWalk = false;					
					}						
						
				}	
					
					
			}
			
		}
		
		public function getMouseIsPress():Boolean
		{
			return _isPress;
		}
		
		private var _mouseUpDoWalk:Boolean = false;
			
		private function _onStageMouseUp(e:MouseEvent)
		{
			if (_isPress )
			{	
				
				if (_selectTargetDelegate != null)
				{
					var pressGamePt:Point = game.view.calcGameMousePt();
					var pressFlashPt:Point = new Point(game.view.container.mouseX, game.view.container.mouseY);
					_selectTargetDelegate.onSelectDone(currentMouseGameObj, pressGamePt, pressFlashPt);
					
					setMouseNormal();
					
					_selectTargetDelegate = null;
					
					return;
				}
				
				
				
				if (enabledSkill && game.characterSkillListView != null && game.characterSkillListView.visible)
				{
					if (game.characterSkillListView.hitGameMouseInRect())
					{
						return;
					}					
				}

				if (enabledWalk && _mouseUpDoWalk)
				{
					_doWalkTo();	
				}
			}
			
			_isPress = false;
		}
		
		public function get view():LazyGameView
		{
			return game.view;
		}
		
	
		//private var walkAnimationWork:DisplayDelegateWalkToAnimationWork = null; 
		
		public function makeWalkToWork(gotoX:Number, gotoY:Number):SimpleCharacterWalkToWork
		{
			var gotoGamePt2:Point =  new Point(gotoX / 8 * 8, gotoY / 8 * 8);	
			
			var gotoFlashPt:Point = view.calcGamePtToFlashPt(gotoGamePt2.x, gotoGamePt2.y);
			/*
			var rot:Number = Math.atan2(pressGamePt.x - player.gamePt.x, pressGamePt.y - player.gamePt.y) * 180/ Math.PI;
			var dir2:int = GameUtils.calcDirectionByRotation(rot);
			
			trace("walk to rot", rot);*/
			
			var work:SimpleCharacterWalkToWork = new SimpleCharacterWalkToWork(player, gotoGamePt2, gotoFlashPt, game);
			
			return work;
		}
		
		
		
		private function _doWalkTo()
		{
			
			var hurtDelta:Number = new Date().getTime() - player.lastHurtTime;
			
			if (hurtDelta >= 200)
			{			
				var mouseGamePt:Point =  game.view.calcFlashPtToGamePt(view.container.mouseX, view.container.mouseY);
				
				player.clearPlayerWorks();
				player.putPlayerWork(makeWalkToWork(mouseGamePt.x, mouseGamePt.y));
			}
		}
		
		private function _doAttack(item:GamePressObjData)
		{
			trace("_doAttack");
			
			player.clearPlayerWorks();
			player.putPlayerWork(new GamePlayerAttackWork(item.iobj, item.objKey, game));
		}
	
		
		public function setMouseNormal():void
		{
			
			mouseSprite.changeNormal();
			//stage.removeChild(mouseSprite);
		}
		
		public function setMouseAttack():void
		{
			
			mouseSprite.changeAttack();
		}
		
		public function setMouseAttackIfNoSelectTarget():void
		{
			if (_selectTargetDelegate == null)
			{
				mouseSprite.changeAttack();
			}
		}
		
		private var _selectTargetDelegate:IGameMouseSelectTargetDelegate = null;
		
		public function doMouseSelectTarget(delegate:IGameMouseSelectTargetDelegate):void
		{
			_selectTargetDelegate = delegate;
			mouseSprite.changeSelectTarget();
		}
		
		
		public function get player():SimpleCharacter
		{
			return game.player;
		}
		
	}

}