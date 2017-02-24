package dark.sprites 
{
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
		
	import flash.display.Sprite;
	import dark.display.SceneCItemDisplayData;
	import dark.display.SceneCItemDisplayDataList;
	import dark.display.SceneCItemDisplayDataSprite;	
	
	import dark.DebugSetting;
	import dark.display.DisplayDelegateFrameArrayDataItem;
	import dark.display.DisplayDelegateFrameArrayDataSprite;
	import dark.IGameLazyDisplayDelegate;
	import dark.AnimationInitData;
	import dark.GameSoundEnums;
	import dark.Game;
	import dark.logics.WalkAnimationLogic;
	
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyCItemDisplayDelegate  extends Sprite implements IGameLazyDisplayDelegate
	{
		
		
		public var displayDataList:SceneCItemDisplayDataList = null;
		public var game:Game = null;
		
		
		
		private var _spriteList:Array;
		
		public var gridSprite:Sprite = null;
	
		
		public function LazyCItemDisplayDelegate(displayDataList:SceneCItemDisplayDataList, game:Game) 
		{
			this.displayDataList = displayDataList;
			this.game =  game;
			
			_spriteList = [];
			
			
			
			if (displayDataList != null && displayDataList.dataList != null)
			{			
				//trace("LazyCItemDisplayDelegate NEW list", displayDataList.dataList.length);
				
				for (var i:int = 0; i < displayDataList.dataList.length; i++)
				{
					var displayData:SceneCItemDisplayData = displayDataList.dataList[i];
					
					
					//trace("LazyCItemDisplayDelegate NEW displayData", displayData);
					
					var sprite:SceneCItemDisplayDataSprite = new SceneCItemDisplayDataSprite(displayData);
					addChild(sprite);
				
					
					sprite.visible = false;
					
					_spriteList.push(sprite);
				}
				
				//trace("LazyCItemDisplayDelegate NEW list Done", displayDataList.dataList.length);
			}
			
			
			
			gridSprite = new Sprite();
			
			gridSprite.graphics.lineStyle(2, 0xff0000);
			gridSprite.graphics.moveTo(0, -32);
			gridSprite.graphics.lineTo(0, 32);
			
			gridSprite.graphics.moveTo(-32, 0);
			gridSprite.graphics.lineTo(32, 0);
			
			
			addChild(gridSprite);
			
			gridSprite.visible = DebugSetting.isShowGameObjHitTestRects;
			
			
			//trace("displayDataList changeDirection afetr", this);
			changeDirection(0);
			
			//trace("displayDataList new Done", this);
		}		
	
		
		public function getNameBoxY():Number
		{
			return -64;
		}		
		
		
		public var gamePt:Point = new Point();
		
		public function getGamePt():Point
		{
			return gamePt;
		}
		
		public function showHitTestRects():void
		{	
			
			gridSprite.visible = true;
			
			if (activeSprite != null)
			{
				activeSprite.showHitTestRects();
			}			
		}
		
		public function hideHitTestRects():void
		{
			gridSprite.visible = false;
			
			if (activeSprite != null)
			{
				activeSprite.hideHitTestRects();
			}						
		}
		
		private var activeSprite:SceneCItemDisplayDataSprite = null;
		
		public function gameHitTestByRect(rect:Rectangle):Boolean
		{
			if (activeSprite.visible && activeSprite.displayData != null && activeSprite.displayData.outerRect != null)
			{				
				if (activeSprite.displayData.outerRect.intersects(rect))
				{						
					return true;
				}
			}
			
			return false;
		}
		
		public function gameHitTestMouse(mx:Number, my:Number):Boolean
		{
			if (activeSprite != null)
			{
				return activeSprite.gameHitTestMouse(mx, my);
				
			}

			return false;
		}
		
		
		
		public var direction:int = 0;
		
		public function changeDirection(direction:int):void
		{
			this.direction = direction;
			
			for (var i:int = 0; i < _spriteList.length; i++)
			{
				var sprite:SceneCItemDisplayDataSprite = _spriteList[i];
				
				//trace("changeDirection", sprite, direction);
				sprite.visible = false;
			}
			
			activeSprite = _spriteList[direction % _spriteList.length];
			activeSprite.visible = true;
		}

		
		public function setAnimationStand1FrameIndex(fx:int):void
		{
			
		}
		
		public function initAnimationStand1Data():AnimationInitData
		{
			return null;
		}
		
		public function changeViewToStand():void
		{
			
		}
		
		public function changeViewToWalk():void
		{
			
		}
		
		public function changeViewToAttack1():void
		{
		
		}
		
		
		public function changeViewToAttack2():void
		{
			
		}
		
		public function changeViewToHurt1():void
		{
			
		}
		
		public function changeViewToDead1():void
		{
		
		}
		
		public function setAnimationWalk1FrameIndex(fx:int):void
		{
			
		}
		
		public function initAnimationWalk1Data():AnimationInitData
		{

			return null;
		}
		
		
		public function setAnimationAttack1FrameIndex(frameIndex:int):void
		{
			
		}
		
		public function initAnimationAttack1Data():AnimationInitData
		{
			return null;
		}
		
	
		
		public function setAnimationAttack2FrameIndex(frameIndex:int):void
		{
			
		}
		
		public function initAnimationAttack2Data():AnimationInitData
		{

			
			return null;
		}
		
		public function setAnimationHurt1FrameIndex(frameIndex:int):void
		{
			
		}
		
		public function initAnimationHurt1Data():AnimationInitData
		{

			return null;
		}
		
		
	
		public function setAnimationDead1FrameIndex(fx:int):void
		{
			
		}
	
		
		public function initAnimationDead1Data():AnimationInitData
		{
			
			return null;
		}
		
	}

}