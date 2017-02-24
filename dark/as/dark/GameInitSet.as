package dark 
{
	import dark.loaders.IAssetLoader;
	import dark.loaders.IAssetLoaderDelegate;
	import dark.loaders.IAssetLoadItem;
	import dark.models.GameInitData;
	import dark.models.GameInitDoneData;
	import dark.models.GameStartData;
	import dark.net.commands.*;
	import dark.netcallbacks.*
	import dark.simple.SimpleCharacter;
	/**
	 * ...
	 * @author ahui
	 */
	public class GameInitSet  implements IAssetLoaderDelegate
	{
		public var delegate:IGameInitDelegate;
		public var connDelegate:LazyGameConnDelegate;
		
		public var startData:GameStartData;
		public var loader:IAssetLoader;
		
		
		public function GameInitSet(delegate:IGameInitDelegate, connDelegate:LazyGameConnDelegate) 
		{
			this.delegate = delegate;
			this.connDelegate = connDelegate;
		}
		
		public function run():void 
		{
			this.loader =  connDelegate.game.changeToGameLoaderView();
			
			var game:IGame = connDelegate.game;
			
			game.setGameMouseActive(false);
		
			
			var initCmd:GameInitCommand = new GameInitCommand();
			
			connDelegate.conn.writeCommand(initCmd, new GameInitCallback(this));
			
		}
		
		public function onGameStarted(data:GameStartData):void
		{
			var game:IGame = connDelegate.game;
			
			game.killLoginView();

			var now:Date = new Date();			
			
			game.setGameServTicks(data.servTicks);		
			game.clearGameView();			
			
			run();			
		}
		
		
		public var mapId:int = 0;
		public var mapChunkNumOfX:int = 0;
		public var mapChunkNumOfY:int = 0;
		
		public function onGameInitCallback(data:GameInitData):void
		{
			var game:IGame = connDelegate.game;
			var assetMgr:AssetManager = game.getAssetManager();
			
			this.mapId = data.mapId;
			this.mapChunkNumOfX = data.mapChunkWidth;
			this.mapChunkNumOfY = data.mapChunkHeight;
			
			var assetPks:Array = [];
			
			for (var i:int = 0; i < data.assetPks.length; i++)
			{
				var assetPk:int = data.assetPks[i];
				
				if (assetMgr.getAssetIsLoaded(assetPk) == false)
				{
					assetPks.push(assetPk);
				}
				
			}
			
			if (assetPks.length == 0)
			{
				doGameInitDone();
			} else 
			{			
				var assetInfoCmad:GameAssetGetInfoCommand = new GameAssetGetInfoCommand(assetPks);			
				
				connDelegate.conn.writeCommand(assetInfoCmad, new GameInitAssetGetInfoCallback(this));				
				
			}
			trace("onGameInitCallback");	
		}
		
		public function onGameInitAssetGetInfoCallback(loadItems:Array):void
		{
			trace("onGameInitAssetGetInfoCallback", loadItems);
			for (var i:int = 0; i < loadItems.length; i++)
			{
				var iItem:IAssetLoadItem = loadItems[i];
				
				trace(iItem);
				loader.addItem(iItem);
			}
			
			loader.startLoad(this);			
		}
		
		
		public function onAssetLoaded():void
		{
			doGameInitDone();
		}
		
		public function doGameInitDone():void
		{
			connDelegate.game.hideGameLoaderView();
			var initDoneCmd:GameInitDoneCommand = new GameInitDoneCommand();			
			
			connDelegate.conn.writeCommand(initDoneCmd, new GameInitDoneCallback(this));
			
			connDelegate.game.initGameView(mapId, mapChunkNumOfX, mapChunkNumOfY);	
		}
		
		public function onGameInitDoneCallback(data:GameInitDoneData):void
		{
			
			trace("onGameInitDoneCallback");
			
			var game:Game = connDelegate.game;
			
			var player:SimpleCharacter = new SimpleCharacter(data.objKey, game);
			player.setTemplateId(GameEnums.OBJTYPE_CHAR, data.templateId);
			player.gamePt.x = data.charX;
			player.gamePt.y = data.charY;
			player.changeDirection(data.direction);		
			player.setMoveSpeed(data.moveSpeed);
			
			game.player = player;
			
			game.updateCharLevel(data.charLevel);
			game.updateCharDef(data.charDef);
			game.updateCharWeighted(data.charDef);
			game.userExpBar.update(data.charExpPercent);
			//trace("player", player, "gamePt", player.gamePt);
			
			game.charStatusBar.setValueMax(data.charMaxHp, data.charMaxMp);
			game.charStatusBar.setValue(data.charHp, data.charMp);
			game.charStatusBar.draw();
			game.charStatusBar.visible = true;
			
			game.playerIsDead = false;			
			game.view.addGameSprite(player);
			
			game.view.focusDisplayObj = player;		
			game.updateGameView();		
			
			
			game.uiGroup1.visible = true;
			
			game.mouseHandler.enabledWalk = true;
			game.mouseHandler.enabledSkill = true;
			
			trace("enabledWalk", game.mouseHandler.enabledWalk);
			
			game.app.playMusic(3, 0.5);			
			
			connDelegate.loadShortcuts();
			
			game.keyboardEventDelegate = new LazyGameStartKeyboardDelegate(game);			
			
			
			if (delegate != null)
			{
				delegate.gameInitDone();
			}
			
		}
		
		
		
	}

}