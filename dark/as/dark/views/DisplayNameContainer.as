package dark.views 
{

	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	import dark.IGameObject;
	import dark.net.commands.GetObjNameCommand;
	import dark.netcallbacks.GameObjGetNameCallback;
	import dark.netcallbacks.GetNameCallbackData;
	import dark.netcallbacks.IGameGetObjNameCallbackDelegate;
	import dark.netcallbacks.LazyGameGetObjNameCallback;
	
	
	import dark.Game;
	import dark.net.GameObjectKey;
	import dark.ui.DisplayGameObjNameSprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class DisplayNameContainer extends Sprite
	{
		
		public var view:LazyGameView = null;
		
		
		private var container1:Sprite = new Sprite();
		private var container2:Sprite = new Sprite();
		private var _defaultSprite:DisplayGameObjNameSprite = null;
		
		public function DisplayNameContainer(view:LazyGameView) 
		{
			this.view = view;
			
			mouseEnabled = false;
			
			container1 = new Sprite();
			container2 = new Sprite();
			
			addChild(container1);
			addChild(container2);
			
			_defaultSprite = new DisplayGameObjNameSprite();
			
			container1.addChild(_defaultSprite);
			
			/*
			graphics.clear();
			graphics.beginFill(0x336699, 0.5);
			graphics.drawRect(0, 0, 960, 640);
			graphics.endFill();*/
		}
		
		private var _nameDisplaySpriteDict:Dictionary = new Dictionary();
		private var _displayItemInfos:Boolean = false;
				
		public function getOrCreateDisplayNameSpriteByObjkey(objKey:GameObjectKey):DisplayGameObjNameSprite
		{
			if (_displayItemInfos)
			{
				var key:String = view.game.syncLogic.makeSyncKey(objKey);
			
				var sprite:DisplayGameObjNameSprite = _nameDisplaySpriteDict[key];
				
				if (sprite == null)
				{
					sprite = new DisplayGameObjNameSprite();
					_nameDisplaySpriteDict[key] = sprite;
					//nameViewChanged = true;
				}
				
				container2.addChild(sprite);
				
				return sprite;
			}
			
			
			return _defaultSprite;
		}
		
		
		private var _getCacheByKey:Dictionary = new Dictionary();
		

		private function setData(igameObj:IGameObject, data:GetNameCallbackData):void
		{
			
			var sprite:DisplayGameObjNameSprite = getOrCreateDisplayNameSpriteByObjkey(igameObj.getObjKey());
			
			if (sprite != null)
			{
				sprite.setName(data.name,  0xffffff);
				sprite.visible = true;
				sprite.followObj = igameObj;			
				
				_followObj(sprite);
				trace("getObjNameCallback", igameObj, data);
			}
			
		}
		
		public function setCallback(igameObj:IGameObject, getNameCallback:GameObjGetNameCallback,  data:GetNameCallbackData):void
		{

			var cacheData:DisplayNameCacheData = new DisplayNameCacheData();
			cacheData.expire = new Date().getTime() + 5000;
			cacheData.data = data;
			
			_getCacheByKey[igameObj.getObjKey()] = cacheData;
			//var key:String = view.game.syncLogic.makeSyncKey();
			
			setData(igameObj, data);
			if (getNameCallback != null)
			{
				getNameCallback.getNameCallback(data);
			}
		}
		
		public function hideGameObjName(igameObj:IGameObject):void 
		{
			if (_displayItemInfos) return;
			
			var sprite:DisplayGameObjNameSprite = getOrCreateDisplayNameSpriteByObjkey(igameObj.getObjKey());
			
			if (sprite != null)
			{
				sprite.visible = false;
			}
		}
		
		public function displayGameObjName(gameObj:IGameObject, getNameCallback:GameObjGetNameCallback):void
		{

			var objKey:GameObjectKey = gameObj.getObjKey();
			
			var cacheData:DisplayNameCacheData = _getCacheByKey[objKey];
			
			var now:Number = new Date().getTime();
			
			if (cacheData != null)
			{
				if (now > cacheData.expire)
				{
					cacheData = null;
					
					delete _getCacheByKey[objKey];
					
				}
				
			}
			
			if (cacheData == null)
			{
			
				var cmd:GetObjNameCommand = new GetObjNameCommand(objKey);
				var delegate:IGameGetObjNameCallbackDelegate = new DisplayNameGetCallbackDelegate(gameObj, getNameCallback, this);
				view.game.conn.writeCommand(cmd, new dark.netcallbacks.LazyGameGetObjNameCallback(view.game, delegate));
			

				
			} else {
				
				//trace("DisplayName hasCacheData", gameObj, cacheData.data);
				setData(gameObj, cacheData.data);
				
				if (getNameCallback != null)
				{
					getNameCallback.getNameCallback(cacheData.data);
				}
				
			}
			

		}
		
		public function displayAllItemInfos():void
		{
			_displayItemInfos = true;
			container1.visible = false;
			container2.visible = true;
			
			//trace("displayAllItemInfos");
			
			for (var i:int = 0; i < view.gameObjs.length; i++)
			{
				var iobj:IGameObject = view.gameObjs[i];
				
				displayGameObjName(iobj, null);
				
				//LazyGameGetObjNameCallback
				//view.game.getGameObjNameByKey(iobj.getObjKey(), new GameObjGetNameCallback(currentMouseGameObj, getNameDelegate, game))
				
				
			}
		}
		
		public function hideAllItemInfos():void
		{
			trace("hideAllItemInfos");
			
			_displayItemInfos = false;
			
			container1.visible = true;
			container2.visible = false;
			
			_nameDisplaySpriteDict = new Dictionary();
			var nums:int = container2.numChildren;
			for (var i:int = 0; i < nums; i++)
			{
				container2.removeChildAt(0);
				//var sprite:DisplayGameObjNameSprite = container2.getChildAt(0);				
			}
			
			
			
		}
		
		private function _followObj( sprite:DisplayGameObjNameSprite ):void
		{
			if (sprite.visible && sprite.followObj != null)
			{
				var pt:Point = new Point();
				
				sprite.followObj.calcDisplayNameSpritePt(pt);
					
				sprite.x = pt.x - sprite.width / 2;
				sprite.y = pt.y;
			}
		}
		
		public function updateView():void
		{
			if (stage == null) return;
			
			if (_displayItemInfos)
			{
				
				var nums:int = container2.numChildren;
				for (var i:int = 0; i < nums; i++)
				{
					var sprite:DisplayGameObjNameSprite = container2.getChildAt(i) as DisplayGameObjNameSprite;
					
					_followObj(sprite);					
				}
				
			
			} else
			{
				_followObj(_defaultSprite);
			}
			
			
		}
		
	}

}