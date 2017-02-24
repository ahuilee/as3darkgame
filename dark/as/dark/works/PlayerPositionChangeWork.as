package dark.works 
{
	import dark.IWork;
	import dark.Game;
	import dark.net.commands.PlayerPositionChangeCommand;
	
	import dark.simple.SimpleCharacter;
	/**
	 * ...
	 * @author ahui
	 */
	public class PlayerPositionChangeWork implements IWork
	{
		
		public var game:Game = null;
		public var x2:int = 0;
		public var y2:int = 0;
		public var direction:int = 0;
		
		public function PlayerPositionChangeWork(game:Game, x2:int, y2:int, direction:int) 
		{
			this.game = game;
			this.x2 = x2;
			this.y2 = y2;
			this.direction = direction;
		}
		
		public function run():void
		{
			//trace("Run PlayerMoveWork");
			var player:SimpleCharacter = game.player;
			
			
			player.setGamePosition(x2, y2, direction);
			
			var moveCmd:PlayerPositionChangeCommand = new PlayerPositionChangeCommand(player.gamePt.x, player.gamePt.y, player.direction);
			
			game.conn.writeCommand(moveCmd, null);

			
			game.updateGameView();
		}
		
		public function getWorkWeighted():int
		{
			return 1;
		}
		
		public function except(err:Error):void
		{
			trace("PlayerMoveWork err", err);
		}
		
	}

}