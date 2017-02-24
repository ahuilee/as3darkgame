package dark.sprites 
{
	import caurina.transitions.properties.DisplayShortcuts;
	import dark.DebugSetting;
	import dark.display.DisplayDelegateFrameArrayDataItem;
	import dark.display.DisplayDelegateFrameArrayDataSprite;
	import dark.IGameLazyDisplayDelegate;
	import dark.AnimationInitData;
	import dark.GameSoundEnums;
	import dark.Game;
	import dark.logics.WalkAnimationLogic;
	import flash.geom.Point;
	import flash.geom.Rectangle;
		
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyNPCDisplayDelegate  extends Sprite implements IGameLazyDisplayDelegate
	{
		
		public var stdSprite:DisplayDelegateFrameArrayDataSprite = null;
		public var walkSprite:DisplayDelegateFrameArrayDataSprite = null;
		public var atk1Sprite:DisplayDelegateFrameArrayDataSprite = null;
		public var atk2Sprite:DisplayDelegateFrameArrayDataSprite = null;
		public var hurtSprite:DisplayDelegateFrameArrayDataSprite = null;
		public var dead1Sprite:DisplayDelegateFrameArrayDataSprite = null;
		public var game:Game = null;
		
		public var gridSprite:Sprite = null;
		
		public function LazyNPCDisplayDelegate(game:Game) 
		{
			this.game =  game;
			
			stdSprite = new DisplayDelegateFrameArrayDataSprite(game.app.getFrameArrayData(getStand1FrameArrayKey()));
			walkSprite = new DisplayDelegateFrameArrayDataSprite(game.app.getFrameArrayData(getWalk1FrameArrayKey()));
			atk1Sprite =  new DisplayDelegateFrameArrayDataSprite(game.app.getFrameArrayData(getAttack1FrameArrayKey()));
			
			atk2Sprite = new DisplayDelegateFrameArrayDataSprite(game.app.getFrameArrayData(getAttack2FrameArrayKey()));
			hurtSprite = new DisplayDelegateFrameArrayDataSprite(game.app.getFrameArrayData(getHurt1FrameArrayKey()));
			dead1Sprite = new DisplayDelegateFrameArrayDataSprite(game.app.getFrameArrayData(getDead1FrameArrayKey())); 	
			
		
			addChild(stdSprite);
			addChild(walkSprite);
			addChild(atk1Sprite);
			addChild(atk2Sprite);
			addChild(hurtSprite);
			addChild(dead1Sprite);
			
			stdSprite.visible = true;
			walkSprite.visible = false;
			atk1Sprite.visible = false;
			atk2Sprite.visible = false;
			hurtSprite.visible = false;
			dead1Sprite.visible = false;
			
			gridSprite = new Sprite();
			
			gridSprite.graphics.lineStyle(2, 0xff0000);
			gridSprite.graphics.moveTo(0, -32);
			gridSprite.graphics.lineTo(0, 32);
			
			gridSprite.graphics.moveTo(-32, 0);
			gridSprite.graphics.lineTo(32, 0);
			
			addChild(gridSprite);
			
			gridSprite.visible = DebugSetting.isShowGameObjHitTestRects;
			
		}
		
	
		
		public function getNameBoxY():Number
		{
			return -200;
		}		
		
		public function getStand1FrameArrayKey():String
		{
			return "NPC001_STAND1";
		}
		
		public function getWalk1FrameArrayKey():String
		{
			return "NPC001_WALK1";
		}
		
		public function getAttack1FrameArrayKey():String
		{
			return "NPC001_ATTACK1";
		}
		
		public function getAttack2FrameArrayKey():String
		{
			return "NPC031_ATTACK2";
		}
		
		public function getHurt1FrameArrayKey():String
		{
			return "NPC001_HURT1";
		}
		
		public function getDead1FrameArrayKey():String
		{
			return "NPC001_DEAD1";
		}
		
		public var gamePt:Point = new Point();
		
		public function getGamePt():Point
		{
			return gamePt;
		}
		
		public function showHitTestRects():void
		{
			stdSprite.showHitTestRects();
			walkSprite.showHitTestRects();
			atk1Sprite.showHitTestRects();
			atk2Sprite.showHitTestRects();
			hurtSprite.showHitTestRects();
			dead1Sprite.showHitTestRects();
			
			gridSprite.visible = true;
		}
		
		public function hideHitTestRects():void
		{
			stdSprite.hideHitTestRects();
			walkSprite.hideHitTestRects();
			atk1Sprite.hideHitTestRects();
			atk2Sprite.hideHitTestRects();
			hurtSprite.hideHitTestRects();
			dead1Sprite.hideHitTestRects();
			
			gridSprite.visible = false;
			
		}
		
		
		public function gameHitTestByRect(rect:Rectangle):Boolean
		{
			
			return false;
		}
		
		public function gameHitTestMouse(mx:Number, my:Number):Boolean
		{
			var item:DisplayDelegateFrameArrayDataItem =  null;
			
			if (stdSprite.visible)
			{
				item = stdSprite.frameArrayData.items[direction];
			}
			if (walkSprite.visible)
			{
				item = walkSprite.frameArrayData.items[direction];
			}
			if (atk1Sprite.visible)
			{
				item = atk1Sprite.frameArrayData.items[direction];
			}
			
			if (atk2Sprite.visible)
			{
				item = atk2Sprite.frameArrayData.items[direction];
			}
			
			if (hurtSprite.visible)
			{
				item = hurtSprite.frameArrayData.items[direction];
			}
			
			if (dead1Sprite.visible)
			{
				item = dead1Sprite.frameArrayData.items[direction];
			}
			
			if (item != null)
			{
				if (item.hitTestBoundOuter != null)
				{
					var isHit:Boolean = item.hitTestBoundOuter.contains(this.mouseX, this.mouseY);
					
					if (isHit)
					{
						if (item.hitTestRects != null)
						{
							var rect:Rectangle = null;
							for (var i:int = 0; i < item.hitTestRects.length; i++)
							{
								rect = item.hitTestRects[i];
								
								if (rect.contains(this.mouseX, this.mouseY))
								{
									return true;
								}
							}
							
							return false;
						}
					
					}
					
					
				
				}
			}
			
			
			
		
			return false;
		}
		
		
		
		public var direction:int = 0;
		
		public function changeDirection(direction:int):void
		{
			this.direction = direction;
			//trace("changeDirection", direction);
			if (stdSprite != null)
			{
			
				stdSprite.changeDirection(direction);
			}
			
			if (walkSprite != null)
			{
				walkSprite.changeDirection(direction);
			}
			
			if (atk1Sprite != null)
			{
				atk1Sprite.changeDirection(direction);
			}
			
			if (atk2Sprite != null)
			{
				atk2Sprite.changeDirection(direction);
			}
			
			if (hurtSprite != null)
			{
				hurtSprite.changeDirection(direction);
			}
			
			if (dead1Sprite != null)
			{
				dead1Sprite.changeDirection(direction);
			}
		}

		
		public function setAnimationStand1FrameIndex(fx:int):void
		{
			stdSprite.setFrameIndex(fx);
		}
		
		public function initAnimationStand1Data():AnimationInitData
		{
			var data:AnimationInitData = new AnimationInitData();
			data.numFrames = stdSprite.frameArrayData.numFrames;
			data.totalDuration = 1000;
			data.soundClass = null;		
			
			
			return data;
		}
		
		public function changeViewToStand():void
		{
			
			
			stdSprite.visible = true;
			walkSprite.visible = false;
			atk1Sprite.visible = false;
			atk2Sprite.visible = false;
			hurtSprite.visible = false;
			dead1Sprite.visible = false;
			
		}
		
		public function changeViewToWalk():void
		{
			stdSprite.visible = false;
			walkSprite.visible = true;
			atk1Sprite.visible = false;
			atk2Sprite.visible = false;
			hurtSprite.visible = false;
			dead1Sprite.visible = false;
			
		}
		
		public function changeViewToAttack1():void
		{
			stdSprite.visible = false;
			walkSprite.visible = false;			
			atk2Sprite.visible = false;			
			hurtSprite.visible = false;
			dead1Sprite.visible = false;
			
			
			atk1Sprite.visible = true;	
			
		}
		
		
		public function changeViewToAttack2():void
		{
			stdSprite.visible = false;
			walkSprite.visible = false;
			atk1Sprite.visible = false;
					
			hurtSprite.visible = false;
			dead1Sprite.visible = false;
		
			atk2Sprite.visible = true;	
		}
		
		public function changeViewToHurt1():void
		{
			stdSprite.visible = false;
			walkSprite.visible = false;
			atk1Sprite.visible = false;
			atk2Sprite.visible = false;	
			
			hurtSprite.visible = true;
			dead1Sprite.visible = false;
			

		}
		
		public function changeViewToDead1():void
		{
			stdSprite.visible = false;
			walkSprite.visible = false;
			atk1Sprite.visible = false;
			atk2Sprite.visible = false;				
			hurtSprite.visible = false;
			dead1Sprite.visible = true;		

		}
		
		public function setAnimationWalk1FrameIndex(fx:int):void
		{
			walkSprite.setFrameIndex(fx);
		}
		
		public function initAnimationWalk1Data():AnimationInitData
		{
			var data:AnimationInitData = new AnimationInitData();
			data.numFrames = walkSprite.frameArrayData.numFrames;
			data.totalDuration = 480;
			data.soundClass = null;	
			
			
			
			return data;
		}
		
		
		public function setAnimationAttack1FrameIndex(frameIndex:int):void
		{
			atk1Sprite.setFrameIndex(frameIndex);
		}
		
		public function initAnimationAttack1Data():AnimationInitData
		{
			var data:AnimationInitData = new AnimationInitData();
			data.numFrames = atk1Sprite.frameArrayData.numFrames;
			data.totalDuration = 1000;
			data.soundClass =  getAttack1SoundClass();
			
			
			return data;
		}
		
		public function getAttack1SoundClass():Class
		{
			return game.app.getSoundClass(GameSoundEnums.GS_ATTACK01);	
		}
		
		public function setAnimationAttack2FrameIndex(frameIndex:int):void
		{
			atk2Sprite.setFrameIndex(frameIndex);
		}
		
		public function initAnimationAttack2Data():AnimationInitData
		{
			var data:AnimationInitData = new AnimationInitData();
			data.numFrames = atk2Sprite.frameArrayData.numFrames;
			data.totalDuration = 1000;
			data.soundClass = game.app.getSoundClass(GameSoundEnums.GS_ATTACK02);		
			
			
			return data;
		}
		
		public function setAnimationHurt1FrameIndex(frameIndex:int):void
		{
			hurtSprite.setFrameIndex(frameIndex);
		}
		
		public function initAnimationHurt1Data():AnimationInitData
		{
			var data:AnimationInitData = new AnimationInitData();
			data.numFrames = hurtSprite.frameArrayData.numFrames;
			data.totalDuration = 300;
			data.soundClass = getHurt1SoundClass();
			
			
			return data;
		}
		
		
	
		public function setAnimationDead1FrameIndex(fx:int):void
		{
			dead1Sprite.setFrameIndex(fx);
			//trace("setAnimationDead1FrameIndex", fx);
		}
		
		public function getHurt1SoundClass():Class
		{
			return game.app.getSoundClass(GameSoundEnums.GS_PLAYER_HURT1);	
		}
		
		public function getDead1SoundClass():Class
		{
			return game.app.getSoundClass(GameSoundEnums.GS_BLACKKINGHT_DEAD1);	
		}
		
		public function initAnimationDead1Data():AnimationInitData
		{
			var data:AnimationInitData = new AnimationInitData();
			data.numFrames = dead1Sprite.frameArrayData.numFrames;
			data.totalDuration = 1000;
			data.soundClass = 	getDead1SoundClass();
			
			
			return data;
		}
		
	}

}