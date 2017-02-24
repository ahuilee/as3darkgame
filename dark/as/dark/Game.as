package dark 
{
	
	
	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Security;	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import flash.utils.Timer;	
	
	import dark.*;
	import dark.views.DisplayNameContainer;
	import dark.views.GameDropItemView;
	import dark.models.GameItem;
	import dark.loaders.ChangeMapLoaderSprite;
	import dark.loaders.IAssetLoader;
	import dark.views.LoginView;
	import dark.views.MapChunk;
	import dark.works.PlayerSkillUseWork;	
	import dark.works.PlayerPositionChangeWork;	
	import dark.simple.*;		
	import dark.net.*;	
	import dark.net.commands.*;
	import dark.views.LazyGameView;
	import dark.netcallbacks.*;
	import dark.ui.*;
	import caurina.transitions.*;
	
	public class Game extends Sprite implements IGame
	{

		public var view:LazyGameView = null;		
		
		public var app:AppDelegate = null;		
		
		public var conn:Connection = null;		
		public var container:Sprite = null;
		public var uiContainer:Sprite = null;
		public var container4:Sprite = null;
		public var container5:Sprite = null;
		public var container6:Sprite = null;
		
		
		
		public var uiGroup1:Sprite = null;
		public var debug:IDebugDelegate = null;
	
		public var player:SimpleCharacter = null;		
		
		public var messageTextField:TextField = null;
		public var connDelegate:LazyGameConnDelegate = null;		
		
		public var syncLogic:LazyGameSyncLogic = null;
		
		private var _queueTimer:Timer = null;
		
		public var mouseHandler:LazyGameMouseHandler = null;
		
		
		public var cItemInfoFactory:CItemInfoFactory = null;
		
		public var assetManager:AssetManager = null;
		
		public function Game(app:AppDelegate, debug:IDebugDelegate) 
		{			
			
			this.app = app;
			this.debug = debug;
			
			container = new Sprite();	
			
			uiContainer = new Sprite();
			container4 = new Sprite();
			container4.mouseEnabled = false;
			container5 = new Sprite();
			container5.mouseEnabled = false;
			container6 = new Sprite();
			
			addChild(container);	
			
			
			addChild(uiContainer);
			addChild(container4);
			addChild(container5);
			addChild(container6);
		
			
			
			
			assetManager = new AssetManager();
			
			this.connDelegate = new LazyGameConnDelegate(this);
			
			conn = new Connection(app, connDelegate);
			app.dataDelegate = new ConnectionDataDelegate(conn);			
			
			
		
			messageTextField = new TextField();
			messageTextField.background = true;
			messageTextField.backgroundColor = 0x000000;
			messageTextField.textColor = 0xffffff;
			messageTextField.autoSize = TextFieldAutoSize.LEFT;
			messageTextField.y = 0;
			messageTextField.width = 800;
			messageTextField.height = 100;
			messageTextField.alpha = 0.5;
			
			addChild(messageTextField);
			
			Security.allowDomain("*");
			
			syncLogic = new LazyGameSyncLogic(this);

			
			mouseHandler = new LazyGameMouseHandler(this);
			
			
			changeToLoginView();
		
			
			cItemInfoFactory = new CItemInfoFactory(this);	
			
			_queueTimer = new Timer(1, 0);
			_queueTimer.addEventListener(TimerEvent.TIMER, _queueTimerLoop);
			_queueTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _queueTimerDone);
			
			this.addEventListener(Event.ADDED_TO_STAGE, _addedToStage);	
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeFromStage);
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);	
			//_mouseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _queueTimerDone);
		}
		
		public function appendCItem(item:GameItem):void
		{
			if (itemListView != null && itemListView.visible)
			{
				itemListView.appendItem(item);		
			}			
		}
		
		public function deleteCItem(itemId:int):void
		{
			
			if (itemListView != null && itemListView.visible)
			{
				itemListView.removeItem(itemId);		
			}	
		}
		
		public function clearCItemInfo(itemId:int):void
		{
			cItemInfoFactory.clearGetInfoDict();
			
			if (itemListView != null && itemListView.visible)
			{
					
			}	
		}
		
		 public function getAssetManager():AssetManager
		 {
			return assetManager;
		 }
		
		
		public function getPlayer():SimpleCharacter
		{
			return player;
		}
		
		
		public function getCurrentMapId():int
		{
			if (view != null)
			{
				
				return view.mapId;
			}
			
			return -1;
		}

		
		public var gameStartServTicks:Number = 0;	
		public var gameStartTime:Number = 0;	

		public var viewChanged:Boolean = true;
		
		public function resize():void
		{
			//container.x = 0;//;stage.stageWidth / 2 - 860 / 2;
			
			
			resizeUI();
		}
	
		private function _queueTimerLoop(e:TimerEvent):void
		{
			app.runWorkQueue();
		}
		
		private function _queueTimerDone(e:TimerEvent):void
		{
			
		}		
		
		private var _lastUpdateMouseTime:Number = 0;
		private var _lastUpdateViewTime:Number = 0;
		private var _lastSortObjTime:Number = 0;
		
		private function _onEnterFrame(e:Event):void
		{
			var nowTime:Number = new Date().getTime();
			
			var checkUpdateView:Boolean = false;
			
			if (app.workQueue.length > 50)
			{
				trace("workQueue BUSY");
			}
			
			if (app.workQueue.length < 50)
			{				
				checkUpdateView =  true;
			}
			
			if (!checkUpdateView)
			{	
				var viewDelta:Number = nowTime - _lastUpdateViewTime;
				
				if (viewDelta > 1000)
				{
					checkUpdateView = true;
				}
			}
			
			if (checkUpdateView)
			{
				if (view != null)
				{
					view.updateGameObjs();	
					
					if (viewChanged)
					{
						//trace("viewChanged");
						
						viewChanged = false;
						
						view.releasedObjs();
						syncLogic.onUpdateGameView();
						view.updateView(nowTime);
						
						if (objDepthChanged || itemDepthChanged)
						{
							var sortDelta:Number = nowTime - _lastSortObjTime;						
							
							if (sortDelta >= 300)
							{
								
								_lastSortObjTime = nowTime;
								if (objDepthChanged)
								{
									objDepthChanged = false;
									view.container.sortGameObjDepth();
								}
								if (itemDepthChanged)
								{
									itemDepthChanged = false;
									var scount:int = view.citemContainer.sortGameObjDepth();
									
									trace("sort items", scount);
								}
								
								//view.sortGameObjDepth();
							}
						}
						
						_lastUpdateViewTime = nowTime;
					}
				}
				
				if (magicBuffListView != null)
				{
					magicBuffListView.updateState(nowTime);
				}
			
			}
			
			var mouseDelta:Number = nowTime - _lastUpdateMouseTime;
			
			if (mouseDelta >= 1000)
			{
				mouseHandler.update(nowTime);
				_lastUpdateMouseTime = nowTime;
			}
			
			
			if (_stageResized == true)
			{
				if (conn != null && stage != null)
				{
					var setStageSizeDelta:Number = nowTime - _lastSetStageSizeTime;
					
					if (setStageSizeDelta >= 1000)
					{
						
						_stageResized = false;
						_lastSetStageSizeTime = nowTime;
						var cmd:GameSetStageSizeCommand = new GameSetStageSizeCommand(stage.stageWidth, stage.stageHeight);
						
						writeCommand(cmd, null);
					}					
				}				
			}
			
			
			
		}
		
		private var _lastSetStageSizeTime:Number = 0;
		public var objDepthChanged:Boolean = false;
		public var itemDepthChanged:Boolean = false;

		
		public function writeCommand(command:ICommand, callback:ICommandCallback = null):int
		{
			return conn.writeCommand(command, callback);
		}
		
		public function setGameMouseActive(enable:Boolean)
		{
			if (enable)
			{
				mouseHandler.enabledWalk = true;
				mouseHandler.enabledSkill = true
			} else {
				mouseHandler.enabledWalk = false;
				mouseHandler.enabledSkill = false
			}
			
			
		}

		//sync game
		
		public function clearGameView():void
		{
			if (view != null)
			{
				if (view.parent != null) {
					view.parent.removeChild(view);
					
				}
				
				syncLogic.clear();
			}
			
			app.workQueue.length = 0;
			
			view = null;
		}
		
		public function initGameView(mapId:int, mapChunkNumOfX:int, mapChunkNumOfY:int):void
		{
			
			
			if (view == null) 
			{
				view = new LazyGameView(app, stage.stageWidth, stage.stageHeight, this);
				container.addChild(view);				
				
				view.x = stage.stageWidth / 2;
				view.y = stage.stageHeight / 2;
				//view.visible = false;
			}	
			
			playerIsDead = false;
			
			view.setMap(mapId, mapChunkNumOfX, mapChunkNumOfY);	
		}
		
		public function updateGameView():void
		{
			centerViewToPlayer();
			
			viewChanged = true;
			
		}
		
		private var _dragEnterDelegates:Array = [];
		
		
		public function hitTestDragEnterDelegate():IGameDragEnterDelegate
		{
			if (stage != null)
			{
				for (var i:int = 0; i < _dragEnterDelegates.length; i++)
				{
					var delegate:IGameDragEnterDelegate = _dragEnterDelegates[i];
					if (delegate.hitTestDragEnter(stage))
					{
						return delegate;
					}
				}
			}
			
			return null;;
		}
		
		
		/*base*/
		

		private function _addedToStage(e:Event):void
		{
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			stage.addEventListener(Event.RESIZE, _stageResize);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _stageKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, _stageKeyUp);
			
			mouseHandler.addEventListener();
			
			
			initUI();
			//
			
			
			_queueTimer.reset();
			_queueTimer.start();
			
			resize();
		}
		
		private var _stageResized:Boolean = false;
		
		private function _stageResize(e:Event):void
		{
			trace("_stageResize", stage.stageWidth, stage.stageHeight);
			
			if (view != null)
			{
			
				
				view.x = stage.stageWidth / 2;
				view.y = stage.stageHeight / 2;
				
				trace("view x, y", view.x, view.y);
				
				view.resizeGameView(stage.stageWidth, stage.stageHeight);
				updateGameView();
			}
			
			
			_stageResized = true;
		
			
		}
		
		private function _removeFromStage(e:Event):void
		{
			mouseHandler.removeEventListener();
		}
	
		
		
		public function reloadCharInfo():void
		{
			var cmd:PlayerCharacterInfoCommand = new PlayerCharacterInfoCommand();
				
			conn.writeCommand(cmd, new CharacterInfoCallback(this));
		}
		
		public function onLoadCharacterInfo(data:CharacterInfoData):void
		{
			
			trace("onLoadCharacterInfo", data);
			
			if (player != null)
			{
				player.moveSpeed = data.moveSpeed;
			}
			
			if (charStatusBar != null)
			{
				charStatusBar.setValueMax(data.maxHp, data.maxMp);
				charStatusBar.setValue(data.hp, data.mp);
				charStatusBar.draw();
			}
			
			
			if (characterInfoView != null)
			{
				characterInfoView.txtCharStr.text = "力量: " + data.charStr;
				characterInfoView.txtCharInt.text = "智力: " + data.charInt;
				characterInfoView.txtCharDex.text = "敏捷: " + data.charDex;
				characterInfoView.txtCharSpi.text = "精神: " + data.charSpi;
				characterInfoView.txtCharCon.text = "體質: " + data.charCon;
			
			}
			
			trace("onLoadCharacterInfo");
		}
		
		public var shortcutsItemListView:ShortcutItemListView = null;
		public var talkView:TalkView = null;
		public var itemListView:ItemListView = null;
		
		public var characterInfoView:CharacterInfoView = null;
		public var userExpBar:UserExpBar = null;
		public var characterSkillListView:CharacterSkillListView = null;
		
		public var shopItemListView:ShopItemListView = null;
		
		public var userStatusView:UserStatusView = null;
		public var charStatusBar:CharacterStatusBar = null;
		
		public var magicBuffListView:MagicBuffListView = null;
		
		public var dropItemHitSprite:GameDropItemView = null;
		
		public function resizeUI():void
		{
			
			uiGroup1.y = stage.stageHeight -128;
			
			userStatusView.x = 0;
			userStatusView.y = 20;
			//userInfoView.y =  stage.stageHeight - 200;
			
			userExpBar.viewWidth = stage.stageWidth;
			userExpBar.draw();
			
			talkView.x = 200;
			talkView.y -= 100;
			
			talkView.viewWidth = stage.stageWidth - 400;
			talkView.draw();
			
			shortcutsItemListView.x = stage.stageWidth - shortcutsItemListView.viewWidth;
			shortcutsItemListView.y = 20;
			//shortcutsItemListView.y = stage.stageHeight -shortcutsItemListView.viewHeight;		
			
			characterInfoView.y = 0;
			characterInfoView.x = 0;
			
			charStatusBar.y = 10;
			charStatusBar.x = 10;
			
			itemListView.y = 0;
			itemListView.x = stage.stageWidth - itemListView.viewWidth;
			
			characterSkillListView.y = 0;
			characterSkillListView.x = stage.stageWidth - characterSkillListView.viewWidth;
			
			
			shopItemListView.y = 0;
			shopItemListView.x = 0;
			
			magicBuffListView.y = 50;
			magicBuffListView.x = stage.stageWidth - 96;
			
			
			
			
		}
		
		
		
		public function initUI():void
		{
			uiGroup1 = new Sprite();
			uiGroup1.visible = false;
			uiContainer.addChild(uiGroup1);
			
			userStatusView = new UserStatusView(200, 180, this);
			//userInfoView.visible = false;
			userStatusView.draw();
			
			talkView = new TalkView(620, 180, this);
			//talkView.visible = false;			
			//talkView.draw();
			
			userExpBar = new UserExpBar(stage.stageWidth, 32, this);
			//userExpBar.draw();
			
			shortcutsItemListView = new ShortcutItemListView(320, 128, this);		
			shortcutsItemListView.draw();
			
			itemListView = new ItemListView(380, 480, this);
			itemListView.isActive = false;
			itemListView.visible = false;	
			
			characterSkillListView = new CharacterSkillListView(380, 480, this);
			characterSkillListView.visible = false;
			characterSkillListView.isActive = false;
			characterSkillListView.draw();
			
			characterInfoView = new CharacterInfoView(380, 480, this);
			characterInfoView.visible = false;
			characterInfoView.draw();
			
			
			charStatusBar = new CharacterStatusBar(this);
			charStatusBar.draw();
			charStatusBar.visible = false;
			
			uiContainer.addChild(charStatusBar);
			
			uiGroup1.addChild(talkView);
			uiGroup1.addChild(userExpBar);			
			uiGroup1.addChild(userStatusView);		
			
			uiGroup1.addChild(shortcutsItemListView);
			
			magicBuffListView = new MagicBuffListView(this);
			
			shopItemListView = new ShopItemListView(380, 480, this);
			shopItemListView.visible = false;
			shopItemListView.draw();
			
			dropItemHitSprite = new GameDropItemView(this); 
			
			uiContainer.addChild(dropItemHitSprite);
			//uiContainer.addChild(itemListView);
			uiContainer.addChild(magicBuffListView);

			uiContainer.addChild(characterInfoView);
			uiContainer.addChild(shopItemListView);
			
			
			charStatusBar.y = uiGroup1.y + 10;
			
		
			
			//uiContainer.addChild(characterInfoView);
			
			//resizeUI();
			
			_dragEnterDelegates = [shortcutsItemListView, dropItemHitSprite];
		}
		
		public function calcTimeByServTicks(servTicks):Number
		{
			return gameStartTime + (servTicks - gameStartServTicks);
		}
		
		public function setGameServTicks(ticks:Number):void
		{
			gameStartServTicks = ticks;
			gameStartTime = new Date().getTime();
		}
		
		
		public function calcEffectSoundVolumeByFlashPt(x2:int, y2:int):Number
		{
			
			var centerDist:Number = Math.sqrt(Math.pow(view.centerPt.x - x2, 2) + Math.pow(view.centerPt.y - y2, 2));
			
			var volume:Number = 1.0;
			
			if (centerDist > 0 )
			{ 
				volume = 1.0 - (1.0 / centerDist / 64.0);		
			

			}
			
			//trace("calcEffectSoundVolumeByFlashPt centerDist=", centerDist, volume);
				
			if (volume < 0.1)
			{
				volume = 0.1;
			}
			
			return volume;
		}
		
		
		public function toggleShowShopItemListView(objKey:GameObjectKey):void
		{
			shopItemListView.visible = !shopItemListView.visible;
			
			if (shopItemListView.visible)
			{
			
				var cmd:ShopItemListCommand = new ShopItemListCommand(objKey);
				
				conn.writeCommand(cmd, new ShopItemListCallback(this));
				

			}
		}
		
		public function toggleShowCharacterInfoView():void
		{
			
			
			characterInfoView.visible = !characterInfoView.visible;
			
			if (characterInfoView.visible)
			{
				reloadCharInfo();
			

			}
			
		}
		
		public function toggleShowCharacterSkillListView():void
		{
			if (characterSkillListView != null)
			{
				characterSkillListView.visible = !characterSkillListView.visible;
				
				//trace("toggleShowCharacterSkillListView", characterSkillListView.visible);
				
				if (characterSkillListView.visible)
				{
					characterSkillListView.isActive = true;
					uiContainer.addChild(characterSkillListView);
					
					itemListView.visible = false;
					itemListView.isActive = false;
					var cmd:PlayerSkillListCommand = new PlayerSkillListCommand();
					
					conn.writeCommand(cmd, new PlayerSkillListCallback(this));
					
					
					
				}else
				{
					if (characterSkillListView.parent != null)
					{
						characterSkillListView.isActive = false;
						characterSkillListView.parent.removeChild(characterSkillListView);
					}
					
				}
			}
		}
		
		
		
		public function toggleShowItemListView():void
		{
			
			
			itemListView.visible = !itemListView.visible;
			
			if (itemListView.visible)
			{
				itemListView.isActive = true;
				
				uiContainer.addChild(itemListView);
			
				characterSkillListView.visible = false;
				characterSkillListView.isActive = false;
				
				var cmd:PlayerItemListCommand = new PlayerItemListCommand();
				
				conn.writeCommand(cmd, new PlayerItemListCallback(this));

			} else 
			{
				itemListView.isActive = false;
				
				if (itemListView.parent != null)
				{
					itemListView.parent.removeChild(itemListView);
				}
				
			}
			
		}
		
		
		private var _lastUseSkillTime:Number = 0;
		
		public function skillUse(skillId:int, targetObj:IGameObject, x2:int, y2:int, dir2:int):void
		{
			var now:Number = new Date().getTime();
			var delta:Number = now - _lastUseSkillTime;
			
			trace("skillUse", delta);
			
			if (delta >= 800)
			{
				
				//var rot2:Number = Math.atan2(
				
				app.putWork(new PlayerSkillUseWork(skillId, targetObj, x2, y2, dir2, this));
				
				_lastUseSkillTime = now;
			}
		
		}
		
	
		
		public function toggleGameMapChunkGrids():void
		{
			if (view == null) return;
			
			DebugSetting.isShowGameMapChunkGrids = !DebugSetting.isShowGameMapChunkGrids ;
			
			
			var mapChunk:MapChunk
			for (var key:String in view.getMapChunkByKey)
			{
				mapChunk = view.getMapChunkByKey[key];
				if (mapChunk != null && mapChunk.gridSprite != null)
				{
					mapChunk.gridSprite.visible = DebugSetting.isShowGameMapChunkGrids;				
					
				}
				
			}
		}
		
		public function toggleGameObjHitTestRects():void
		{
			if (view == null) return;
			
			DebugSetting.isShowGameObjHitTestRects = !DebugSetting.isShowGameObjHitTestRects ;
			
			
			trace("toggleGameObjHitTestRects", DebugSetting.isShowGameObjHitTestRects);
			
			var iobj:IGameObject = null;
			var displayDelegate:IGameLazyDisplayDelegate = null;
			for (var i:int = 0; i < view.gameObjs.length; i++)
			{
				
				iobj = view.gameObjs[i];
				
				displayDelegate = iobj.getDisplayDelegate();
				
				if (displayDelegate != null)
				{
				
					if (DebugSetting.isShowGameObjHitTestRects)
					{
						displayDelegate.showHitTestRects();
					} else
					{
						displayDelegate.hideHitTestRects();
						
					}
				}
				
				
			}
			
			if (player != null)
			{
			
				if (DebugSetting.isShowGameObjHitTestRects )
				{
					player.getDisplayDelegate().showHitTestRects();
				} else
				{
					player.getDisplayDelegate().hideHitTestRects();
						
				}
			}
			
			
		}
		
		/*
		public function clearObjs():void
		{
			syncLogic.clear();
			view.clear();
		}*/
		
		
		
	
		
		private var _gameLoaderSprite:ChangeMapLoaderSprite = null;
		
		
		public function hideGameLoaderView()
		{
			if (_gameLoaderSprite != null)
			{
				if (_gameLoaderSprite.parent != null)
				{
					_gameLoaderSprite.parent.removeChild(_gameLoaderSprite);
					
					_gameLoaderSprite = null;
				}
			}
			
		}
		
		public function changeToGameLoaderView():IAssetLoader
		{
			if (_gameLoaderSprite == null)
			{
				_gameLoaderSprite = new ChangeMapLoaderSprite(this);
			}
			
			container6.addChild(_gameLoaderSprite);
			
			return _gameLoaderSprite;
		}
	
		public function playerUseSkill(skillId:int, targetType:int):void
		{
			switch (targetType) 
			{
				case SkillEnums.TARGET_SELF:
					skillUse(skillId, player, player.gamePt.x, player.gamePt.y, player.getDirection());
					break;
				case SkillEnums.TARGET_SELECT_SINGLE:
				case SkillEnums.TARGET_SELECT_POINT:
					mouseHandler.doMouseSelectTarget(new LazyGameSkillSelectObjDelegateSet(skillId, this));
					break;
				default:
			}
			
		}
		
		
		
		public var keyboardEventDelegate:IGameKeyboardEventDelegate = null;
		
		private function _stageKeyDown(e:KeyboardEvent):void
		{
			if (keyboardEventDelegate != null)
			{
				keyboardEventDelegate.onKeyDown(e);
			}
			
		}
		
		private function _stageKeyUp(e:KeyboardEvent):void
		{
			if (keyboardEventDelegate != null)
			{
				keyboardEventDelegate.onKeyUp(e);
			}
		}
		
		
		public var playerIsDead:Boolean = false;
		
		public function gameLogin(username:String):void
		{
			_loginUsername = username;
			var loginCmd:GameLoginCommand = new GameLoginCommand(username);
			
			conn.writeCommand(loginCmd, new GameLoginCallback(this));
			
			_stageResized = true;
		}
		
		private var _loginUsername:String = "";
		
		public function gameRestart(delegate:IGameInitDelegate):void
		{
			if (restartMenu != null)
			{
				if (restartMenu.parent != null)
				{
					restartMenu.parent.removeChild(restartMenu);
				}
				
				restartMenu = null;
				
			}			
			
			connDelegate.doGameStart(delegate);
		}
		
		
		private var restartMenu:GameRestartBox = null;
		
		public function showReStartMenu():void
		{
			if (restartMenu == null)
			{
				restartMenu = new GameRestartBox(this);
				
			}
			
			uiContainer.addChild(restartMenu);
			restartMenu.x  = stage.stageWidth / 2 - 320 / 2;
			restartMenu.y = stage.stageHeight * 0.2;
		}
		
		public function updateCharLevel(value:int)
		{
			userStatusView.txtCharLevel.text = "等級: " + value;
		}
		
		public function updateCharDef(value:int)
		{
			userStatusView.txtCharDef.text = "防禦: " + value;
		}
		
		// 0 ~ 1
		public function updateCharWeighted(value:Number)
		{
			var n:int = Math.round(value * 100.0);
			
			if (n > 100) 
			{
				n = 100;				
			}
			
			userStatusView.txtCharWeighted.text = "負重: " + n;
		}
		
		
		public function gameViewBgPress()
		{
			//_isPress = true;
		}
		
		public function onGamePlayerMove(x2:int, y2:int, direction2:int):void
		{
			if (y2  != player._gamePt.y)
			{
				objDepthChanged = true;
			}
			
			app.putWork(new PlayerPositionChangeWork(this, x2, y2, direction2));
		}
		
		
		public function centerViewToPlayer():void
		{			
			var flashPt:Point = view.updateCenterGamePt(player.gamePt.x, player.gamePt.y);		
	
			player.x = flashPt.x;
			player.y = flashPt.y;
		}
		
		public function displayGameObjName(gameObj:IGameObject, getNameCallback:GameObjGetNameCallback) 
		{
			if (view != null)
			{
				view.displayNameContainer.displayGameObjName(gameObj, getNameCallback);
			}		
			
		}
		/*
		public function getGameObjNameByKey(key:GameObjectKey, callback:Function):void
		{
			
		}		*/
		
		
		private var loginView:LoginView = null;
			
		public function killLoginView():void
		{
			if (loginView != null)
			{
				uiContainer.removeChild(loginView);
				
				loginView = null;
			}
		}
		
		public function changeToLoginView():void
		{
			if (loginView == null)
			{
				loginView = new LoginView(this);
				
				uiContainer.addChild(loginView);
				
			}
		}
		
		public function cancelAttackGameObj(objKey:GameObjectKey):void
		{
			
			if (player != null)
			{
				player.cancelAttackGameObj(objKey);
			}
		}
		
	
		
		public function getOrCreateDisplayNameSpriteByObjkey(objKey:GameObjectKey):DisplayGameObjNameSprite
		{

			return  view.displayNameContainer.getOrCreateDisplayNameSpriteByObjkey(objKey);;
			
		}
		
		
		public function connectTCP(host:String, port:int):void
		{
			
			app.debug.debugMessage("connectTCP=" + host + " port=" + port);
			conn.connectTCP(host, port);
		}	
		
		
	}

}