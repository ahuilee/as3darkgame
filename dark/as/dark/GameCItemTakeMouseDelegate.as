package dark 
{
	import com.greensock.core.SimpleTimeline;
	import dark.net.commands.PlayerCItemTakeCommand;
	import dark.netcallbacks.PlayerTakeItemCallback;
	import dark.simple.GamePlayerTakeCItemWork;
	import dark.simple.SimpleCharacterWalkToWork;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ahui
	 */
	public class GameCItemTakeMouseDelegate implements IGameLazyObjMouseDelegate
	{
		public var objSet:LazyGameSyncObjSet = null;
		
		public function GameCItemTakeMouseDelegate(objSet:LazyGameSyncObjSet) 
		{
			this.objSet = objSet;
		}
		
		public function calcPressWork(game:Game):Array
		{
			
			
			var works:Array = [];
			
			var displayDelegate:IGameLazyDisplayDelegate = objSet.getDisplayDelegate();
			
			if (displayDelegate != null)
			{
				var objFlashPt:Point = objSet.getFlashPoint();
				
				var takeBound:Rectangle = new Rectangle(game.player.x-64, game.player.y-64, 128, 128);
				
				
				var takeBoundForTarget2:Rectangle = takeBound.clone();
				
				takeBoundForTarget2.x -= objFlashPt.x;
				takeBoundForTarget2.y -= objFlashPt.y;
				
				trace("takeBoundForTarget2", takeBoundForTarget2, objFlashPt.x, objFlashPt.y);
				
				
				if (!displayDelegate.gameHitTestByRect(takeBoundForTarget2))
				{
					var walkWork:SimpleCharacterWalkToWork = game.mouseHandler.makeWalkToWork(objSet.gamePt.x, objSet.gamePt.y);

					works.push(walkWork);				
				}
				
				var work:GamePlayerTakeCItemWork = new GamePlayerTakeCItemWork(objSet, game);
				
				works.push(work);
				
					
				
			}
			
			
			
			return works;
			
		}
	}

}