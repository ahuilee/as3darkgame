package dark 
{
	
	import flash.geom.Point;
	import flash.geom.Rectangle;	
	import dark.net.GameObjectKey;	
	
	public class LazyGameSyncObjSet implements ISyncObjDelegate, IGameInteractiveDelegate, IAnimationWorkDelegate
	{
		
		public var objKey:GameObjectKey = null;
		public var game:Game = null;		
		public var igameObj:IGameObject = null;
		public var lazySprite:LazyGameObjectSprite = null;		
		public var gamePt:Point = new Point();
		
		public function LazyGameSyncObjSet(objKey:GameObjectKey, game:Game) 
		{
			this.objKey = objKey;
			this.game = game;
		}
		
		
		public function onAnimationWorkDone():void
		{
			
			setAnimationWork(null);
			
			if (lazySprite != null)
			{
				
				var _displayDelegate:IGameLazyDisplayDelegate = lazySprite.getDisplayDelegate();
				if (_displayDelegate != null)
				{
					_displayDelegate.changeViewToStand();
				}
			}
			
		}
		
		public function getObjKey():GameObjectKey
		{
			return objKey;
		}
		
		public function getDirection():int
		{
			return lazySprite.direction;
		}
		
		public function setDirection(dir:int):void
		{
			if (lazySprite != null)
			{
				lazySprite.changeDirection(dir);
			}
		}
		
		public function setCharacterPosition(x:int, y:int, direction:int):void
		{
		
			
			if (lazySprite != null)
			{			
				var pt2:Point = game.view.calcGamePtToFlashPt(x, y);
				
				lazySprite.x = pt2.x;
				lazySprite.y = pt2.y;
				lazySprite.changeDirection(direction);
				
				if (gamePt.y != y)
				{
					game.objDepthChanged = true;
				}
			}
			
			gamePt.x = x;
			gamePt.y = y;
			
			//trace("setCharacterPosition", x, y, direction, lazySprite);
		}
		
		public function getDisplayObjectRect():Rectangle
		{
			var bound:Rectangle = new Rectangle(lazySprite.x, lazySprite.y, lazySprite.width, lazySprite.height);
			//trace("getDisplayObjectRect", bound);
			
			return bound;
		}
		
		public function deleteObj(game:Game):void
		{
			if (igameObj != null)
			{
				//game.view.container.removeChild(lazySprite);
				igameObj.released = true;
			}
		}
		
		
		
		public var moveDelta:int = 1;
		
		public function setMoveDelta(value:int):void
		{
			this.moveDelta = value;
		}
		
		public function getMoveDelta():int
		{
			return moveDelta;
		}
		
		
		public function getGamePoint():Point
		{
			return igameObj.gamePt;
		}
		
		public function getFlashPoint():Point
		{
			return new Point(lazySprite.x, lazySprite.y);
		}		
		
		public function setAnimationWork(iWork:IGameObjAnimationWork):void
		{
			if (lazySprite != null)
			{
				lazySprite.setAnimationWork(iWork);
			}			
		}
		
		public var objType:int = 0;
		
		public function setTemplateId(objType:int, templateId:int):void
		{
			this.objType = objType;
		
			
			//trace("setTemplateId", objType);
			
			if (igameObj == null)
			{
				igameObj = lazySprite = new LazyGameObjectSprite(this);
				//lazySprite.setInteractiveDataCallback = setGameInteractiveCallback;
				
				game.view.addGameSprite(lazySprite);
			}
			
			lazySprite.setTemplateId(objType, templateId);		
		}
		
		public function setGameInteractive(data:GameObjInteractiveData):void
		{
			
			//trace("setGameInteractive", data);
			
			if (data.take == true)
			{
				
				var takeItemDelegate:GameCItemTakeMouseDelegate = new GameCItemTakeMouseDelegate(this);
				
				lazySprite.setMouseDelegate(takeItemDelegate);
				
				return;
			}
			
			if (data.shop == true)
			{
				var shopDelegate:LazyGameShopMouseDelegate = new LazyGameShopMouseDelegate(this);
				
				lazySprite.setMouseDelegate(shopDelegate);
				
				return;
			}
			
			if (data.attack == true)
			{
				var attacKDelegate:LazyGameAttackMouseDelegate = new LazyGameAttackMouseDelegate(this);
				lazySprite.setMouseDelegate(attacKDelegate);
				
				return ;
			}
			
			
			
		}
		
		
		public function getDisplayDelegate():IGameLazyDisplayDelegate
		{
			if (lazySprite != null)
			{
				return lazySprite.getDisplayDelegate();
			}
			return null;
		}
		
	
		
	}

}