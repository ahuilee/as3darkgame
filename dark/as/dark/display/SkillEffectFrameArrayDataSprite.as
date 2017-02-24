package dark.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import dark.IGameInteractiveDelegate;
	import dark.IGameLazyDisplayDelegate;
	import dark.IGameLazyObjMouseDelegate;
	
	import dark.IGameObject;
	import dark.IGameObjWork;
	import dark.Game;
	import dark.net.GameObjectKey;
	import dark.GameEnums;
	/**
	 * ...
	 * @author ahui
	 */
	public class SkillEffectFrameArrayDataSprite extends Sprite implements IGameObject
	{
		
		public var frameData:SkillEffectFrameArrayData = null;
		private var _released:Boolean = false;
		private var _bitmap:Bitmap = null;

		
		private var _gamePt:Point = new Point();
		public var container:Sprite = null;
		public var game:Game = null;
		
		public function SkillEffectFrameArrayDataSprite(x2:int, y2:int, frameData:SkillEffectFrameArrayData, game:Game) 
		{
			_gamePt.x = x2;
			_gamePt.y = y2;
			
			this.frameData = frameData;

			this.game = game;
			
				
			_released = false;
			
			container = new Sprite();
			addChild(container);
			_bitmap = new Bitmap();	
			container.addChild(_bitmap);		
			
			container.x = frameData.x2;
			container.y = frameData.y2;
			
			container.scaleX = frameData.scaleX;
			container.scaleY = frameData.scaleY;
			
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
		}
		

		
		public function getDisplayDelegate():IGameLazyDisplayDelegate
		{
			return null;
		}
		
		
		
		public function getInteractiveDelegate():IGameInteractiveDelegate
		{
			return null;
		}		
		
		public function getMouseDelegate():IGameLazyObjMouseDelegate
		{
			return null;
		}
		
		public function getObjType():int
		{
			return GameEnums.OBJTYPE_SKILL;
		}
		
		public function getObjKey():GameObjectKey
		{
			return null;
		}
		
		public function gameHitTestMouse(mx:Number, my:Number):Boolean
		{
			return false;
		}
		
		private var _startTime:Number = 0;
		public var duration:Number = 2000;
		public var changeValue:int = 0;

		private function _addedToStage(e:Event)		
		{
			_startTime = new Date().getTime();
			duration = frameData.duration;
			changeValue = frameData.frames.length - 1;
		}
		
		private function _removeFromStage(e:Event)		
		{			
			//trace("_removeFromStage SkillEffectAnimationSprite", this);
		}
		
		public function get released():Boolean		
		{
			return _released;
		}
		
		public function set released(value:Boolean):void
		{
			_released = value;
		}
		
		public function updateState(nowTime:Number):void
		{
			
			if (_released ) return;			
			
			
			var t:Number = nowTime - _startTime;
			
			var fx:int = changeValue * t / duration;
			
			//trace("SkillEffectFrameArrayDataSprite",   fx, t, duration);
			
			if (fx >= changeValue)
			{
				_released = true;
				game.viewChanged = true;
				return;
			}
			
			var bd:BitmapData = frameData.frames[fx];
				
			
			//trace("Skill bd", fx, bd);
			_bitmap.bitmapData = bd;	
			
		
		}
		
		
		public function get gamePt():Point
		{
			return _gamePt;
		}
		
		public function get flashX():int
		{
			return x;
		}			 
		
		public function get flashY():int
		{
			return y;
		}
		
		public function calcDisplayNameSpritePt(pt:Point):void
		{
			
			
		}
		
	}

}