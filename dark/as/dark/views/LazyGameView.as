package dark.views 
{
	

	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import dark.*;

	
	public class LazyGameView extends Sprite implements IGameView
	{		
		//debug
		public var displayMapCellPt:Boolean = false;
		//public var displayMapGrid:Boolean = false;
		public var displayMapBlockGrid:Boolean = false;
		
		private var _app:AppDelegate = null;
		public var bg:Sprite = null;
		
		private var _gameObjContainer:Sprite = null;
		
		public var container:GameObjContainer = null;
		public var citemContainer:GameObjContainer = null;
		
		public var	displayNameContainer:DisplayNameContainer = null;
		public var front:Sprite = null;
		public var blockContainer:Sprite = null;
		
		//public var mapRects:Array = [];
		public var mapChunkIndexes:Array = [];
		
		public var viewGameRect:Rectangle = new Rectangle();
		public var viewportRect:Rectangle = new Rectangle();
		public var overViewRect:Rectangle = new Rectangle();
		//for preload
		public var mapViewRect:Rectangle = new Rectangle();
		
		public var centerGamePt:Point = new Point();
		public var centerPt:Point = new Point();
		
		public var gameObjs:Array = null;
		
		public var tileHeightRatio:Number = 0;
		public var tileWidthRatio:Number = 0;
		
		public var game:Game = null;
		
		public function LazyGameView(app:AppDelegate, width:int, height:int, game:Game) 
		{
			_app = app;
			this.game = game;
			
			gameObjs = [];
			
			var tileRotSize:Rectangle = calcRotationSize(GameEnums.MAP_TILE_WIDTH, GameEnums.MAP_TILE_HEIGHT);
			
			tileHeightRatio = tileRotSize.height / 2.0 / GameEnums.MAP_TILE_HEIGHT;
			tileWidthRatio = tileRotSize.width / GameEnums.MAP_TILE_WIDTH;
			
			_gameObjContainer = new Sprite();
			
			bg = new Sprite();	
			citemContainer = new GameObjContainer();
			container = new GameObjContainer();
			front = new Sprite();
			blockContainer = new Sprite();
			
			displayNameContainer = new DisplayNameContainer(this);
			
			
			_gameObjContainer.addChild(bg);			
			_gameObjContainer.addChild(citemContainer);
			_gameObjContainer.addChild(container);			
			
			_gameObjContainer.addChild(blockContainer);
			
			_gameObjContainer.addChild(displayNameContainer);
			
			addChild(_gameObjContainer);
			
			addChild(front);
			
			/*
			var zeroSprite:Sprite = new Sprite();
			zeroSprite.graphics.clear();
			zeroSprite.graphics.lineStyle(1, 0xffffff);
			zeroSprite.graphics.moveTo( -1000, 0);
			zeroSprite.graphics.lineTo(1000, 0);
			zeroSprite.graphics.moveTo(0, -1000);
			zeroSprite.graphics.lineTo(0, 1000);
			
			addChild(zeroSprite);
			*/
			
			resizeGameView(width, height);
			
		}
		
		public function resizeGameView(width:int, height:int):void
		{
			viewportRect.width = width ;
			viewportRect.height = height ;
			
			viewGameRect.width = width * 2;
			viewGameRect.height = height * 1.5;
			
			mapViewRect.width = width * 3;
			mapViewRect.height = height * 2;
			
			overViewRect.width = width * 3;
			overViewRect.height = height * 2;
		}
		
		public function clear():void
		{
			gameObjs.length = 0;
			
			container.clearChildren();
			citemContainer.clearChildren();
			
			_containerChildDict = new Dictionary();
		}
		
		public function mouseHitTestGameObj():Array 
		{
			var rs:Array = new Array();			
			//trace("container.mouseX, container.mouseY", container.mouseX, container.mouseY);			
			for (var i:int = 0; i < gameObjs.length; i++)
			{
				var iobj:IGameObject = gameObjs[i];
				
				if (iobj is IGameMouseHitTest)
				{
					var iHitTest:IGameMouseHitTest = iobj as IGameMouseHitTest;
					
					if (iHitTest.gameHitTestMouse(container.mouseX, container.mouseY))
					{
						rs.push(iobj);
					}
				}
			}
			
			return rs;			
		}
		
		private function _onBgPress(e:MouseEvent):void
		{
			game.gameViewBgPress();
		}
		
		public function addGameObj(iGameObj:IGameObject):void 
		{
			gameObjs.push(iGameObj);			
		}
		
		public function releasedObjs():void
		{
			
			//trace("releasedObjs");
			if (gameObjs.length < 1) return;
			
				var hasReleased:Boolean = false;
				var i:int = 0;
				var iobj:IGameObject = null;
				
				for (i = 0; i < gameObjs.length; i++)
				{
					iobj = gameObjs[i];
					if (iobj.released) {
						hasReleased = true;
						break;
					}
				}
		
				if(hasReleased)
				{
					var newChildren:Array = new Array();
					
					for (i = 0; i < gameObjs.length; i++)
					{
						iobj = gameObjs[i];
						if (iobj.released) 
						{						
							
							var dictObj:* = _containerChildDict[iobj];
							
							
							if (dictObj == true)
							{
								//trace("container.removeChild", iobj);
								var idisplay:DisplayObject = iobj as DisplayObject;
								
								if (idisplay.parent != null)
								{
										idisplay.parent.removeChild(idisplay);
								}
								//container.removeChild(idisplay);
								
								
								delete _containerChildDict[iobj];
							}
							/*
							if (iobj is DisplayObject)
							{
								container.removeChild(iobj as DisplayObject);
								
							}*/
							continue;
						}
						
						newChildren.push(iobj);
					}
					
					
					
					//trace("gameObjs", gameObjs.length, "newChildren", newChildren.length);
					
					this.gameObjs = newChildren;
				}
			
			
		}
		
		private var _containerChildDict:Dictionary = new Dictionary();
		
		
		public function addGameSprite(iobj:IGameObject)
		{
			//trace("addGameSprite", iobj);
			_containerChildDict[iobj] = true;
			var idisplay:DisplayObject = iobj as DisplayObject;
			
			switch (iobj.getObjType()) 
			{
				case GameEnums.OBJTYPE_CHAR:
				case GameEnums.OBJTYPE_SKILL:
					container.addChild(idisplay);
					break;
				case GameEnums.OBJTYPE_ITEM:
					citemContainer.addChild(idisplay);
					break;	
				
			}
			
			
			addGameObj(iobj);
		}
		
		public function updateGameObjs():void
		{
			try 
			{
				_updateGameObjs();
				
			} catch (err:Error)
			{
				trace("updateGameObjs err", err.getStackTrace());
			}
		}
		
		private function _updateGameObjs():void
		{
			//trace("updateGameObjs", gameObjs);
			if (gameObjs != null && gameObjs.length > 0)
			{
				var nowTime:Number = new Date().getTime();
				//trace("_timerLoop");
				for (var i:int = 0; i < gameObjs.length; i++)
				{
					var iobj:IGameObject = gameObjs[i];
					
					if (!iobj.released)
					{
						try
						{
							iobj.updateState(nowTime);
						
						} catch (err:Error)
						{
							trace("!!!!!!!!!!!!OnErr", iobj, err.getStackTrace());
						}
					}
				}
			}			
			
			
			displayNameContainer.updateView();
		}
		
		
		public function get app():AppDelegate
		{
			return _app;
		}
		
		public var focusDisplayObj:DisplayObject = null;
		
		public function updateCenterGamePt(x:int, y:int):Point
		{	
			centerGamePt.x = x;
			centerGamePt.y = y;			
			
			centerPt = calcGamePtToFlashPt(x, y );			
			
			//trace("updateCenterGamePt", x, y, centerPt, viewportRect);			
			
			viewportRect.x = centerPt.x - viewportRect.width / 2;
			viewportRect.y = centerPt.y - viewportRect.height / 2;
			
			mapViewRect.x = centerPt.x - mapViewRect.width / 2;
			mapViewRect.y = centerPt.y - mapViewRect.height / 2;
			
			viewGameRect.x = centerGamePt.x	 - viewGameRect.width / 2;
			viewGameRect.y = centerGamePt.y	 - viewGameRect.height / 2;				
			
			overViewRect.x = centerPt.x - overViewRect.width / 2;
			overViewRect.y = centerPt.y - overViewRect.height / 2;			
			
			
			_gameObjContainer.x = -centerPt.x;
			_gameObjContainer.y = -centerPt.y;	
			
			return centerPt;
		}
		
		public function hitMapBlocks(x:int, y:int):Boolean
		{
			//var i:int = 0;
			var j:int = 0;
			
			var block:Rectangle = null;
			
			for (var key:String in getMapChunkByKey)
			{
				var mapRect:MapChunk = getMapChunkByKey[key];
				
				if (mapRect != null && mapViewRect.intersects(mapRect.chunkRect)) 
				{
					if (mapRect.blocks != null) 
					{
						
						//trace("hitMapBlocks", x, y);
						
						for (j = 0; j < mapRect.blocks.length; j++)
						{
							block = mapRect.blocks[j];
							if (block.contains(x, y))
							{
								trace("block.contains", block, x, y);
								return true;
							}
						}
					}
				}
			}			
			
			return false;
		}
		
		public function updateView(nowTime:Number)		
		{
			
			try 
			{
				_updateView(nowTime);
			} catch (err:Error)
			{
				trace("updateView err", err);
			}
		}
		
		public var getMapChunkByKey:Dictionary = new Dictionary();
		
		public var mapId:int = 1;			
		public var mapChunkNumOfX:int = 0;
		public var mapChunkNumOfY:int = 0;
		
		private var _lastReleaseMapTime:Number = 0;
		
		
		private function _updateView(nowTime:Number)		
		{			
			var curChunkX:int = centerGamePt.x / 64 / 16;
			var curChunkY:int = centerGamePt.y / 64 / 16;
			var chunkPt:Point = new Point(curChunkX, curChunkY);
		
			//trace("_updateView chunkPt", chunkPt);
			
			var chunkXStart = curChunkX - 2;
			var chunkYStart = curChunkY - 2;
			
			var loadedChunk:Dictionary = new Dictionary();
			
			for (var i:int = 0; i < 5; i++)
			{
				for (var j:int = 0; j < 5; j++)
				{
					var chunkX:int = chunkXStart + i;
					var chunkY:int = chunkYStart + j;
				
					var chunkXYKey:String = chunkX + "," + chunkY;
					
					var mapChunk:MapChunk = getMapChunkByKey[chunkXYKey];
					
					if (mapChunk == null)
					{
						mapChunk = createMapChunk(chunkX, chunkY);
						getMapChunkByKey[chunkXYKey] = mapChunk;
					}
					
					loadedChunk[chunkXYKey] = mapChunk;
					mapChunk.lastActiveTime = nowTime;
					
					if (mapChunk.chunkRect.intersects(mapViewRect))
					{
						if (!mapChunk.isLoaded)
						{					
							mapChunk.isLoaded = true;			
							mapChunk.sprite = new Sprite();
							bg.addChild(mapChunk.sprite);
							mapChunk.sprite.x = mapChunk.chunkRect.x;
							mapChunk.sprite.y = mapChunk.chunkRect.y;						
							
							//trace("LoadMapChunk", mapChunk);
							
							app.dataDelegate.getMapChunkData(mapId, mapChunk.chunkX, mapChunk.chunkY, new LazyMapChunkGetDataCallback(mapChunk, this));						
						}					
						
						
						mapChunk.displayNodes(this, mapViewRect);
						
					} else 
					{
						mapChunk.hideNodes(this, mapViewRect);
					}
					
				}			
			}
			
			
			var _releaseDelta:Number = nowTime - _lastReleaseMapTime;
			
			if (_releaseDelta >= 1000)
			{			
				_lastReleaseMapTime = nowTime;
				
				var keyCount:int = 0;
				//unload chunk
				for (var key:String in getMapChunkByKey)
				{
					var chunk:MapChunk = getMapChunkByKey[key];
					
					if (chunk != null && loadedChunk[key] == null)
					{				

						var activeDelta:Number = nowTime - chunk.lastActiveTime;
						if (activeDelta >= 3000)
						{
							//trace("Unload MapChunk", chunk);
							chunk.releaseChunk();
							
							delete getMapChunkByKey[key];						
						}					
					}
					
					keyCount++;
				}
			}
			
			//trace("getMapChunkByKey", keyCount);
			
			
			
		}
		
		public function createMapChunk(chunkX:int, chunkY:int):MapChunk
		{
			var mapChunk:MapChunk = new MapChunk(this);
				
			mapChunk.chunkX = chunkX;
			mapChunk.chunkY = chunkY;
				
			var rectX:int  = mapChunk.chunkX * MapChunk.MAPCHUNK_WIDTH;
			var rectY:int  =  mapChunk.chunkY * MapChunk.MAPCHUNK_HEIGHT;					
			
			mapChunk.gameRect = new Rectangle(rectX, rectY, MapChunk.MAPCHUNK_WIDTH, MapChunk.MAPCHUNK_HEIGHT);				
		//var isoPt:Point = calcIsoPt(rectX, rectY);
			
			var pt2:Point = chunkPtToFlashPt(mapChunk.chunkX, mapChunk.chunkY);					
			//pt2.x = (rectX - rectY) * 
			
			mapChunk.chunkRect = new Rectangle(pt2.x, pt2.y, MapChunk.CHUNK2D_WIDTH, MapChunk.CHUNK2D_WIDTH);	
					
			return mapChunk;
		}
		
	
		public var numTileX:int = 0;
		public var numTileY:int = 0;
		
		
		public function calcRotationSize(width:Number, height:Number):Rectangle
		{
			var angle:Number = 45 * Math.PI / 180.0;
			var sin:Number = Math.sin(angle);
			var cos:Number = Math.cos(angle);
			
			var x1:Number = cos * GameEnums.MAP_TILE_WIDTH;
			var y1:Number = sin * GameEnums.MAP_TILE_WIDTH;
			
			var x2:Number = -sin * GameEnums.MAP_TILE_HEIGHT;
			var y2:Number = cos * GameEnums.MAP_TILE_HEIGHT;
			
			var x3:Number = cos * GameEnums.MAP_TILE_WIDTH - sin * GameEnums.MAP_TILE_HEIGHT;
			var y3:Number = sin * GameEnums.MAP_TILE_WIDTH + cos *  GameEnums.MAP_TILE_HEIGHT;
			
			var minX:Number = Math.min(0, x1, x2, x3);
			var maxX:Number = Math.max(0, x1, x2, x3);
			
			var minY:Number = Math.min(0, y1, y2, y3);
			var maxY:Number = Math.max(0, y1, y2, y3);
			
			var rW:Number = maxX - minX;
			var rH:Number = maxY - minY;	
			
			return new Rectangle(0, 0, rW, rH);			
		}		
		
		
		public function chunkPtToFlashPt(x:Number, y:Number):Point
		{
			var pt:Point = new Point(0, 0);			
			
			pt.x = (int)(((x * GameEnums.CHUNK_NUM_CELL_X * GameEnums.MAP_TILE_WIDTH) - (y * GameEnums.CHUNK_NUM_CELL_Y * GameEnums.MAP_TILE_HEIGHT)) /  2 / tileHeightRatio);			
			pt.y = (int)(((x * GameEnums.CHUNK_NUM_CELL_X * GameEnums.MAP_TILE_WIDTH) + (y * GameEnums.CHUNK_NUM_CELL_Y * GameEnums.MAP_TILE_HEIGHT)) /  2 / tileWidthRatio);
			
			return pt;
		}
		
		public function calcGamePtToFlashPt(x:int, y:int):Point
		{
			var x2:int  = (x - y) * tileWidthRatio / 2;
			var y2:int = (y + x) * tileHeightRatio / 2;
			//var x2:int  = (x * tileWidthRatio -  y * tileHeightRatio) * 2;
			//var y2:int = y * tileHeightRatio + x * tileWidthRatio;
			
			return new Point(x2, y2);
		}
		
		
		public function calcGameMousePt():Point
		{
			
			return calcFlashPtToGamePt(container.mouseX, container.mouseY);
		}
		
		public function calcFlashPtToGamePt(x:Number, y:Number):Point
		{
			
			var pt:Point = new Point(0, 0);				
			
			var x2:Number = x  * tileHeightRatio + y  * tileWidthRatio;
			var y2:Number = y  * tileWidthRatio - x  * tileHeightRatio ;	
	
			
			pt.x = (int)(x2);
			pt.y = (int)(y2);
			
			return pt;
		}
		
		public function flashPtToGameCellPt(x:Number, y:Number):Point
		{
			var pt:Point = new Point(0, 0);				
			
			var x2:Number = x / GameEnums.MAP_TILE_WIDTH  * tileHeightRatio + y / GameEnums.MAP_TILE_HEIGHT * tileWidthRatio;
			var y2:Number = y / GameEnums.MAP_TILE_HEIGHT * tileWidthRatio - x / GameEnums.MAP_TILE_WIDTH * tileHeightRatio ;			
	
			
			pt.x = (int)(x2);
			pt.y = (int)(y2);
			
			return pt;
		}
		
	
		
		public function setMap(mapId:int, mapChunkNumOfX:int, mapChunkNumOfY:int):void
		{
			
			trace("setMap", mapId);
			this.mapId = mapId;

			this.mapChunkNumOfX = mapChunkNumOfX;
			this.mapChunkNumOfY = mapChunkNumOfY;
			
			mapChunkIndexes.length = 0;
	
		}
		
	}

}