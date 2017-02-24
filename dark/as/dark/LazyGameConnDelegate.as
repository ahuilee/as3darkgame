package dark 
{
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	

	import dark.loaders.IAssetLoader;
	import dark.loaders.IAssetLoadItem;
	import dark.models.GameInitData;
	import dark.models.GameStartData;
	import dark.views.LoginView;
	import dark.works.GameTeleportWork;
	import dark.net.*;
	import dark.net.commands.*;
	import dark.netcallbacks.*;
	import dark.simple.SimpleCharacter;
	
	public class LazyGameConnDelegate  implements IConnectionDelegate, IGameInitDelegate
	{
		
		public  var game:Game;
		
		public var effectPlay:LazyGameSkillEffectPlay = null;
		
		public function LazyGameConnDelegate(game:Game) 
		{
			this.game = game;
			
			this.effectPlay = new LazyGameSkillEffectPlay(game);
		}		
		
		public function gamePlayerHurtSet():void
		{
			
			if (game.player != null)
			{
				trace("gamePlayerHurtSet");
				game.player.lastHurtTime = new Date().getTime();
			}
			
		}
			
		public function gamePlayerMagicBuffAdd(typeId:int, templateId:int, expireServTick:Number):void
		{
			if (this.game.magicBuffListView != null)
			{
				var expireTime:Number = game.calcTimeByServTicks(expireServTick);
				
				this.game.magicBuffListView.add(typeId, templateId, expireTime);
			}
			
		}
		
		public function gameEffectPlay(effectId:int, x2:int, y2:int):void
		{
			
			effectPlay.play(effectId, x2, y2);
		}
		
		public function gameEffectPlayFollow(effectId:int, objKey:GameObjectKey):void
		{
			effectPlay.playFollow(effectId, objKey);
		}
		
		public function gameSyncData(ask:int, syncDataList:Array):void
		{
			game.syncLogic.gameSyncData(ask, syncDataList);
		}
		
		public function gameSyncDeleteObj(objKey:GameObjectKey):void
		{
			game.syncLogic.gameSyncDeleteObj(objKey);
			
			game.viewChanged = true;
			//trace("gameSyncDeleteObj");
		}
	
		public function gamePlayerLevelUpdate(data:PlayerLevelUpdateData):void
		{
			//trace("onPlayerLevelUpdate", data);
			
			game.updateCharLevel(data.charLevel);
			game.charStatusBar.setValueMax(data.maxHp, data.maxMp);
			game.userExpBar.update(data.charExpPercent);
		}
		
		public function gamePlayerHealthUpdate(data:PlayerHealthUpdateData):void
		{
			//trace("gamePlayerHealthUpdate", data);
			game.charStatusBar.setValue(data.charHp, data.charMp);
			game.charStatusBar.draw();
			
		}
		
		public function gamePlayerTeleport(mapId:int, x2:int, y2:int, delay:int):void
		{
			
			var work:GameTeleportWork = new GameTeleportWork(mapId, x2, y2, game);
			work.start(delay);		
		}
		
		public function gameSoundPlay(id:int, volume:int):void
		{
			//trace("gameSoundPlay", id, volume);
			var asVolume:Number  = volume / 255.0;
			app.playSound(id, asVolume);
		}	
		
		
		public function doGameStart(delegate:IGameInitDelegate):void
		{
			if (delegate == null)
			{
				delegate = this;
			}
			
			
			var startTime:Date = new Date();
			game.gameStartTime = startTime.getTime();
			
			var initSet:GameInitSet = new GameInitSet(delegate, this);
			
			
			var cmd:GameStartCommand = new GameStartCommand(currentPlayerCharId);
			
			conn.writeCommand(cmd, new GameStartCallback(initSet));
		}
		
		
		
		public function gamePlayDead():void
		{
			trace("gamePlayDead");
			game.keyboardEventDelegate = null;
			
			game.playerIsDead = true;
			
			game.mouseHandler.enabledWalk = false;
			game.mouseHandler.enabledSkill = false;
			
			game.showReStartMenu();
		}
		
		public function loadShortcuts():void		
		{
			var cmd:PlayerGetShortcutInfoCommand = new PlayerGetShortcutInfoCommand();
			conn.writeCommand(cmd, new PlayerGetShortcutInfoCallback(game));
		}
		
		
		public function gameDisplayTalkMessage(item:DisplayTalkMessageItem):void
		{
			game.talkView.appendMessage(item.text);
			
		}
		
		public var currentPlayerCharId:int = 0;
		
		public function onUserLoginSuccess(charDataArray:Array):void
		{
			var charData:UserCharacterData = charDataArray[0];
			
			currentPlayerCharId = charData.charId;
			doGameStart(this);
		}
		
		public function gameInitDone():void
		{
			
		}
		
		
		public function onConnectionMade():void
		{
			trace("onConnectionMade");

		}
		
		
		
		public function get conn():Connection
		{
			return game.conn;
		}
		
		public function get app():AppDelegate
		{
			return game.app;
		}
		
		
		public function get player():SimpleCharacter
		{
			return game.player;
		}
		
		public function set player(value:SimpleCharacter):void
		{
			game.player = value;
		}
		
	}

}