package dark.simple
{
	

	import dark.logics.WalkAnimationLogic;
	import dark.objworks.DisplayDelegateWalkToAnimationWork;
	import dark.objworks.SyncGameObjAnimationWork;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.Responder;
	import flash.utils.Timer;
	
	import dark.AppDelegate;	
	import dark.net.GameObjectKey;
	import dark.display.BitmapAnimation;
	import dark.*;	
		
	public class SimpleCharacter extends LazyGameObjectSpriteBase implements ISyncObjDelegate, IAnimationWorkDelegate
	{
	
		public var status:int = 0;		
		public var _gamePt:Point = new Point();
		
		private var _game:Game = null;
		private var _objKey:GameObjectKey = null;		
		
		public var attackRect:Rectangle = null;
		public var talkBound:Rectangle = null;
		
	
		private var _attackRectWidthHalf:Number = 0;
		private var _attackRectHeightHalf:Number = 0;
		
		private var _talkBoundWidthHalf:Number = 0;
		private var _talkBoundHeightHalf:Number = 0;
		
		public var lastHurtTime:Number = 0;
		
		public function SimpleCharacter(objKey:GameObjectKey, game:Game) 
		{
			_objKey = objKey;
			_game = game;
			super();
			
			attackRect = new Rectangle(0, 0, 256, 256);
			talkBound = new Rectangle(0, 0, 256, 256);
			
			_attackRectWidthHalf = attackRect.width / 2;
			_attackRectHeightHalf = attackRect.height / 2;
			_talkBoundWidthHalf = talkBound.width / 2;
			_talkBoundHeightHalf = talkBound.height / 2;
			//changeDirection(4);
			
		
		}
		
		public function cancelAttackGameObj(objKey:GameObjectKey):void
		{
		
			
			if (currentPlayerWork != null)
			{
				if (currentPlayerWork is GamePlayerAttackWork)
				{
				
					var work:GamePlayerAttackWork = currentPlayerWork as GamePlayerAttackWork;
					if (work.attackObjKey.equals(objKey))
					{
								trace("cancelAttackGameObj", objKey);
						work.cancel();
					}
				}
				
			}
		}
		
		private var walkAnimationWork:DisplayDelegateWalkToAnimationWork = null; 
		public function getWalkAnimationWork():DisplayDelegateWalkToAnimationWork
		{
			if (walkAnimationWork == null)
			{
				walkAnimationWork = new DisplayDelegateWalkToAnimationWork(getDisplayDelegate(), game);				
			
			}
			
			return walkAnimationWork;
		}
		
		public function onAnimationWorkDone():void
		{			
			setAnimationWork(null);
			
			var _displayDelegate:IGameLazyDisplayDelegate = this.getDisplayDelegate();
			
			if (_displayDelegate != null)
			{
				
				_displayDelegate.changeViewToStand();
			}
		}		
		
		public override function gameHitTestMouse(mx:Number, my:Number):Boolean
		{
			return super.gameHitTestMouse(mx, my);
		} 
		
		public override function getObjType():int
		{
			return GameEnums.OBJTYPE_CHAR;
		}
		
		
		public override function getObjKey():GameObjectKey
		{
			return _objKey;
		}

		
		public var moveSpeed:int = 8;
		
		public function setMoveSpeed(value:int)
		{
			moveSpeed = value;
		}
		
		public function getMoveSpeed():int
		{
			return moveSpeed;
		}		

		
		public function getAttackGameBounds():Rectangle
		{
			return attackRect;
		}
		
		
		public override function get game():Game
		{
			return _game;
		}
		
		public override function get gamePt():Point
		{
			return _gamePt;
		}
		
		public function set gx(value:int):void
		{
			_gamePt.x = value;
		}
		
		
		public function setGamePosition(x:int, y:int, direction:int)
		{
			gamePt.x = x;
			gamePt.y = y;
			 
			attackRect.x = gamePt.x - _attackRectWidthHalf;
			attackRect.y = gamePt.y - _attackRectHeightHalf;
			
			talkBound.x = gamePt.x - _talkBoundWidthHalf;
			talkBound.y = gamePt.y - _talkBoundHeightHalf;

			changeDirection(direction);		
			
			//trace("setGamePosition", "attackRect", attackRect);
		}
		
		
		public function getSyncDelegate():ISyncObjDelegate
		{
			return this;
		}
		
		public function getGamePoint():Point
		{
			return gamePt;
		}
		
		public function getFlashPoint():Point
		{
			return new Point(this.x, this.y);
		}		
		
		public function getDirection():int
		{
			return this.direction;
		}		
		
		public function setDirection(dir:int):void
		{
			changeDirection(dir);
		}
		
		public function setCharacterPosition(x:int, y:int, direction:int):void
		{
			setGamePosition(x, y, direction);
			
		}
		/*
		public function setTemplateId(templateId:int):void
		{
			this.set
		}*/

		public function deleteObj(game:Game):void
		{			
			released = true;			
		}
		
		public function getDisplayObjectRect():Rectangle
		{
			var bound:Rectangle = new Rectangle(x, y, width, height);
			//trace("getDisplayObjectRect", bound);
			
			return bound; 
		}

		
		public var playerWorks:Array = [];		
		public var currentPlayerWork:IGameObjWork = null;
		
		
		public function clearPlayerWorks():void
		{
			playerWorks.length = 0;
			currentPlayerWork = null;
		}
		
		public function putPlayerWork(work: IGameObjWork):void
		{
			
			playerWorks.push(work);
		}
		
		public override function setAnimationWork(iWork:IGameObjAnimationWork):void
		{
			super.setAnimationWork(iWork); 			
			
			/*
			if (iWork is SyncGameObjAnimationWork)
			{
				var synAni:SyncGameObjAnimationWork = iWork as SyncGameObjAnimationWork;
				if (synAni.animationId == GameAnimationEnums.HURT1)
				{
					this.lastHurtTime = new Date().getTime();
					
					trace("lastHurtTime", lastHurtTime);
				}
				
			}*/
			
		}
		
		public override function updateState(nowTime:Number):void
		{
			try{
				super.updateState(nowTime);
			}
			catch (err:Error)
			{
				trace("Player ERR!", err.getStackTrace());
			}
			//trace("super.updateState(nowTime); done");
			
			
			if (currentPlayerWork == null)
			{
				if (playerWorks.length > 0)
				{
					currentPlayerWork = playerWorks.shift();
					
					if (currentPlayerWork != null)
					{
						currentPlayerWork.onStartWork();
					}
				}
			}
			
			if (currentPlayerWork != null)
			{
				currentPlayerWork.runWork(nowTime);
				if (currentPlayerWork != null && currentPlayerWork.isDone)
				{
					currentPlayerWork.onWorkDone();
					currentPlayerWork = null;
				}
			}
			
		}
	
		
	

	}

}