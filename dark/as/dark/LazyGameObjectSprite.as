package dark 
{
	
	import flash.geom.Point;	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	import dark.display.BitmapAnimation;
	import dark.net.commands.GetObjNameCommand;
	import dark.net.GameObjectKey;
	import dark.netcallbacks.GetNameCallbackData;
	import dark.sprites.*;
	
	public class LazyGameObjectSprite extends LazyGameObjectSpriteBase
	{		
		public var lazySet:LazyGameSyncObjSet = null;	
		
		public function LazyGameObjectSprite( lazySet:LazyGameSyncObjSet) 
		{					
			this.lazySet = lazySet;
			
			super();
		}	
		
		
		public override function getInteractiveDelegate():IGameInteractiveDelegate
		{
			return lazySet;
		}
		
		public override function get game():Game
		{
			return lazySet.game;
		}

		public override function getObjKey():GameObjectKey
		{
			return lazySet.objKey;
		}
		
		public override function getObjType():int
		{
			return lazySet.objType;
		}
		
		public override function get gamePt():Point
		{
			return lazySet.gamePt;
		}
		
	}

}