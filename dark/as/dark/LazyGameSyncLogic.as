package dark 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import dark.net.commands.GetObjInfoCommand;
	import dark.net.*;
	import dark.objworks.*;
	import dark.netcallbacks.*;

	/**
	 * ...
	 * @author ahui
	 */
	public class LazyGameSyncLogic
	{
		
		public var game:Game = null;
		
		private var _waitSyncDict:Dictionary = new Dictionary();
		private var _getGameObjDelegateByKey:Dictionary = new Dictionary();
		
		
		public function LazyGameSyncLogic(game:Game) 
		{
			this.game = game;
		}
		
		public function clear():void
		{
			_waitSyncDict = new Dictionary();
			_getGameObjDelegateByKey = new Dictionary();
		}
		
		public function getSyncDelegateByKey(key:GameObjectKey):ISyncObjDelegate
		{
			if (game.player != null)
			{
				if (game.player.getObjKey().equals(key))
				{
					return game.player;
				}
			}
			
			var syncKey:String = makeSyncKey(key);
			var objDelegate:ISyncObjDelegate = _getGameObjDelegateByKey[syncKey];
			
			return objDelegate;
		}
		
		public function onUpdateGameView():void
		{
			
			var removeObjs:Array = [];
			
			var key:String = "";
			
			for (key in _getGameObjDelegateByKey)
			{				
				var objDelegate:ISyncObjDelegate  = _getGameObjDelegateByKey[key];				
				
				if (objDelegate != null)
				{
					var rect:Rectangle = objDelegate.getDisplayObjectRect();
					
					if (!game.view.overViewRect.intersects(rect))
					{						
						removeObjs.push(key);
					}					
				}		
			}
			
			for (var i:int = 0; i < removeObjs.length; i++)
			{
				key = removeObjs[i];				
				gameDeleteObj(key);
			}		
			
		}
		
		
		
		
		public function makeSyncKey(objKey:GameObjectKey):String
		{
			return objKey.key1  + "_" + objKey.key2;
		}
		
		public function gameDeleteObj(syncKey:String):void
		{
			var objDelegate:ISyncObjDelegate = _getGameObjDelegateByKey[syncKey];
			
			//trace("gameDeleteObj", new Date(), syncKey);
			
			if (objDelegate != null)
			{
				objDelegate.deleteObj(game);
				delete _waitSyncDict[syncKey];
				delete _getGameObjDelegateByKey[syncKey];
			}
		}
		
		public function gameSyncDeleteObj(objKey:GameObjectKey):void
		{
			
			gameDeleteObj(makeSyncKey(objKey));
		}
		
		public function gameSyncData(ask:int, syncDataList:Array):void
		{
			
			var sendGetInfoKeys:Array = [];
			
			for (var i:int = 0; i < syncDataList.length; i++)
			{
				var syncData:GameSyncData = syncDataList[i];
				var syncKey:String = makeSyncKey(syncData.objKey);
				var objDelegate:ISyncObjDelegate = null;
				
				//trace("gameSyncData", syncKey);
				
				if (game.player.getObjKey().equals(syncData.objKey))
				{
					objDelegate = game.player;
				} 
				
				if (objDelegate == null)
				{	
					objDelegate = _getGameObjDelegateByKey[syncKey];	
				}
				
				if (objDelegate == null)
				{			
					//trace("No Game Object From Server Get!", syncData, syncData.infos);
					
					var waitSyncDataList:Array = _waitSyncDict[syncKey];
					
					var isSendGetInfo:Boolean = false;
					
					if (waitSyncDataList == null)
					{
						waitSyncDataList = [];
						
						_waitSyncDict[syncKey] = waitSyncDataList;
						
						isSendGetInfo = true;
						
					}
					
					waitSyncDataList.push(syncData);
					
					if (isSendGetInfo) 
					{
						sendGetInfoKeys.push(syncData.objKey);
					}
				
				} else 
				{
					syncGameObjSet(objDelegate, [syncData]);
				}
			}
			
			if (sendGetInfoKeys.length > 0)
			{				
				var getInfoCmd:GetObjInfoCommand = new GetObjInfoCommand(sendGetInfoKeys);
				var getInfoAsk:int = game.conn.writeCommand(getInfoCmd, new LazyGameGetObjInfoCallback(ask, game));
				
				//trace("send GetObjInfoCommand", getInfoAsk, sendGetInfoKeys);
				return;
			} 			
			
			//trace("gameSyncData writeAnswerSuccess=", ask);
			game.conn.writeAnswerSuccess(ask, null);
		}	
		
		
		
		public function onGameGetObjInfoCallback(objKey:GameObjectKey,  objType:int, templateId:int, objX:int, objY:int, dir:int):void
		{
			var syncKey:String = makeSyncKey(objKey);
			
			var syncDataList:Array = _waitSyncDict[syncKey];
			
			delete _waitSyncDict[syncKey];
			
			//trace("onGameGetObjInfoCallback", objKey, templateId, "syncKey", syncKey);
			
			var lazyObj:LazyGameSyncObjSet = new LazyGameSyncObjSet(objKey, game);
			
			_getGameObjDelegateByKey[syncKey] = lazyObj;
			
			lazyObj.setTemplateId(objType, templateId);
			lazyObj.setCharacterPosition(objX, objY, dir);
			
			switch(objType) 
			{
				case GameEnums.OBJTYPE_ITEM:
					game.itemDepthChanged = true;
					break;
				case GameEnums.OBJTYPE_CHAR:
					game.objDepthChanged = true;
					break;
				default:
			}
			
			
			
			//var interactiveData:GameObjInteractiveData = new GameObjInteractiveData();
			
			//lazyObj.setGameInteractive(interactiveData);
			//lazyObj.setCharacterPosition(
			
			syncGameObjSet(lazyObj, syncDataList);
			
		}
		
		
		private function _syncObjDead(objDeadData:SyncDataObjDead, objDelegate:ISyncObjDelegate)
		{
			
			
			game.cancelAttackGameObj(objDelegate.getObjKey());
			
			
			if (objDelegate != null)
			{
			
				var startTime:Number = game.calcTimeByServTicks(objDeadData.animationStartServTicks);			
				
				var startDuration = new Date().getTime() - startTime;
				//trace("_syncObjDead", objDeadData, "startDuration", startDuration);
				
				
				objDelegate.setCharacterPosition(objDeadData.x, objDeadData.y, objDeadData.direction);
				
				var work:SyncGameObjDeadWork = new SyncGameObjDeadWork(objDelegate, startDuration, game);
				
				objDelegate.setAnimationWork(work);
			}
		}
		
		private function _syncObjAnimation(data:SyncAnimationData, objDelegate:ISyncObjDelegate)
		{
		
			var startTime:Number = game.calcTimeByServTicks(data.startServTicks);			
			
			var startDuration = new Date().getTime() - startTime;		
			
			if (startDuration < 1)
			{
				startDuration = 0;
			}
			
			if (startDuration >= data.duration)
			{
				trace("_syncObjAnimation isOverTime", data, "startDuration", startDuration, "data.duration", data.duration);
			}
			
			
			objDelegate.setDirection(data.direction2);
			
			
			if(data.debugType == 1)
			{
				trace("GameAnimationEnums ATTACK1", data);
			
			}
			
			//if (startDuration < data.duration)
			if (true)
			{		
				var animationDelegate:IAnimationWorkDelegate = null;
				
				if (objDelegate is IAnimationWorkDelegate)
				{
					animationDelegate = objDelegate as IAnimationWorkDelegate;
				}
				
				var work:SyncGameObjAnimationWork = new SyncGameObjAnimationWork(objDelegate, data.animationId, startDuration, animationDelegate, game);
			
				objDelegate.setAnimationWork(work);
				
			
				
			}
		}
		
		private function _syncObjStand(data:SyncDataObjStand, objDelegate:ISyncObjDelegate)
		{
			//trace("_syncObjStand", objDelegate.getObjId());
			objDelegate.setCharacterPosition(data.x, data.y, data.direction);
			objDelegate.setAnimationWork(null);
			objDelegate.getDisplayDelegate().changeViewToStand();
			
			if (data.debugType == 1)
			{
				trace("_syncObjStand", data);
			}
		}
		
		private function _syncObjHurt(data:SyncDataObjHurt, objDelegate:ISyncObjDelegate)
		{
			var startTime:Number = game.calcTimeByServTicks(data.startServTicks);			
			
			var startDuration = new Date().getTime() - startTime;	
			
			/*
			objDelegate.setCharacterPosition(data.x, data.y, data.direction);
			objDelegate.setAnimationWork(null);
			objDelegate.getDisplayDelegate().changeViewToStand();*/
		}
		
		private function _syncObjWalkTo(walkTo:SyncDataObjWalkTo, objDelegate:ISyncObjDelegate)
		{

			var startTime:Number = game.calcTimeByServTicks(walkTo.startServTicks);	
			
				
			var walkWork:SyncGameObjWalkToWork = new SyncGameObjWalkToWork(objDelegate, new Point(walkTo.x1, walkTo.y1), new Point(walkTo.x2, walkTo.y2), startTime, walkTo.duration, game);
				
			
			if (walkTo.debugType == 1)
			{
				trace("Sync WalkTo", objDelegate.getObjKey(), walkTo);
				
				var now:Number = new Date().getTime();
				/*
				if (startTime > now)
				{
					var overDelta:Number =  startTime - now;
					trace("Sync WalkTo Over startTime=", startTime, now, "delta", overDelta);
				}*/
				
				walkWork.debug = true;
			}
			
			objDelegate.setCharacterPosition(walkTo.x1, walkTo.y1, walkTo.direction1);
			//objDelegate.setDirection(walkTo.direction1);
			
			objDelegate.setAnimationWork(walkWork);
		}
		
		public function syncGameObjSet(objDelegate:ISyncObjDelegate, syncDataList:Array)
		{
			var isUpdateView:Boolean = false;
			
			for (var i:int = 0; i < syncDataList.length; i++)
			{
				var syncData:GameSyncData = syncDataList[i];
				
				for (var j:int = 0; j < syncData.infos.length; j++)
				{
					var info:* = syncData.infos[j];			
					
					
					if (info is SyncDataObjStand)
					{
						_syncObjStand(info as SyncDataObjStand, objDelegate);
					} else 
					
					if (info is SyncDataCharPosItem)
					{
						var charPos:SyncDataCharPosItem = info as SyncDataCharPosItem;
						objDelegate.setCharacterPosition(charPos.x, charPos.y, charPos.dir);
						
						isUpdateView = true;
					} else if (info is SyncDataCharAnimationGoto)
					{
						// alrealdy remove
						var aniGoto:SyncDataCharAnimationGoto = info as SyncDataCharAnimationGoto;						
						//trace("animationGotoAndPlay;", aniGoto.animationId);
						
						//objDelegate.animationGotoAndPlay(aniGoto.animationId, aniGoto.frameIndex);
					} else if (info is SyncDataObjWalkTo)
					{
						_syncObjWalkTo(info as SyncDataObjWalkTo, objDelegate);
						isUpdateView = true;
						
					} else if (info is SyncDataObjDead)
					{						
						_syncObjDead(info as SyncDataObjDead, objDelegate);
						
						isUpdateView = true;				
						
					} else if (info is SyncAnimationData)
					{
						_syncObjAnimation(info as SyncAnimationData, objDelegate);
					}		
					/*
					else if (info is SyncDataObjHurt)
					{
						_syncObjHurt(info as SyncDataObjHurt, objDelegate);
						
					}*/
					 
				}
				
				
			}
			
			
			
			if (isUpdateView)
			{
				game.viewChanged =  true;
				//game.view.updateView();
			}
		}
		
		
	}

}