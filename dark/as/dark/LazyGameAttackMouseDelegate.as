package dark 
{
	import com.greensock.data.TweenMaxVars;
	import flash.geom.Point;
	
	import dark.net.commands.ShopItemListCommand;
	import dark.netcallbacks.ShopItemListCallback;
	import dark.simple.GamePlayerAttackWork;
	import dark.simple.SimpleCharacterWalkToWork;	
	
	public class LazyGameAttackMouseDelegate implements IGameLazyObjMouseDelegate
	{
		
		public var objSet:LazyGameSyncObjSet = null;
		
		public function LazyGameAttackMouseDelegate(objSet:LazyGameSyncObjSet) 
		{
			this.objSet = objSet;
		}
		
		
		private function _calcPosition(game:Game):AttackMovePt
		{
			var wHalf:Number = game.player.attackRect.width / 3;
			var hHalf:Number = game.player.attackRect.height  / 3;
				
			var playerGamePt:Point = game.player.gamePt;
			
			var gotoPts:Array = [];
			
			var xList:Array = [];
			var yList:Array = [];
			
			xList.push(objSet.gamePt.x - wHalf);
			xList.push(objSet.gamePt.x + wHalf);	
			
			yList.push(objSet.gamePt.y - hHalf);
			yList.push(objSet.gamePt.y + hHalf);
			
			xList.sort();
			yList.sort();
			
			var minX:Number = xList[0];
			var maxX:Number = xList[xList.length-1];
			var minY:Number = yList[0];
			var maxY:Number = yList[yList.length - 1];
			
			var w2:Number = maxX - minX;
			var h2:Number = maxY - minY;
			
			var w3:Number = w2 / 4;
			var h3:Number = h2 / 4;
			
			for (var ix:int = 0 ; ix < 4; ix++)
			{
				for (var iy:int = 0 ; iy < 4; iy++)
				{
					var x2:Number = minX + ix * w3;
					var y2:Number = minY + iy * h3;
					
					var pt:AttackMovePt = new AttackMovePt(x2, y2, playerGamePt.x, playerGamePt.y);
					
					gotoPts.push(pt);
				}
			}
			
			//gotoPts.push(new AttackMovePt(objSet.gamePt.x - wHalf, objSet.gamePt.y - hHalf, playerGamePt.x, playerGamePt.y));
			//gotoPts.push(new AttackMovePt(objSet.gamePt.x - wHalf, objSet.gamePt.y + hHalf, playerGamePt.x, playerGamePt.y));
			//	
			//gotoPts.push(new AttackMovePt(objSet.gamePt.x + wHalf, objSet.gamePt.y - hHalf, playerGamePt.x, playerGamePt.y));
			//gotoPts.push(new AttackMovePt(objSet.gamePt.x + wHalf, objSet.gamePt.y + hHalf, playerGamePt.x, playerGamePt.y));
				
			gotoPts.sortOn("dist");
			
			/*
			for (var i:int = 0; i < gotoPts.length; i++)
			{
				trace("AttackMovePt", gotoPts[i].dist);
			}*/
				
			var atkMvPt:AttackMovePt = gotoPts[0];
				
			return atkMvPt;
		}
		
		public function calcPressWork(game:Game):Array
		{
			var works:Array = [];
			
			
			var hitAttackBound:Boolean = game.player.attackRect.contains(objSet.gamePt.x, objSet.gamePt.y);
			
			if (!hitAttackBound)
			{
				
				var atkMvPt:AttackMovePt = _calcPosition(game);
				
				trace("atkMvPt", atkMvPt);
				
				var walkWork:SimpleCharacterWalkToWork = game.mouseHandler.makeWalkToWork(atkMvPt.x1, atkMvPt.y1);
				
				trace("makeWalkToWork", hitAttackBound);
				
				works.push(walkWork);
			}
			

			trace("make GamePlayerAttackWork");
			works.push(new GamePlayerAttackWork(objSet.igameObj, objSet.objKey, objSet.game));
			return works;
			
			//return null;
			
		}
		
	}

}