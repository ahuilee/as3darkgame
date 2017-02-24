package dark.works 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import dark.IGame;
	import dark.IGameInitDelegate;
	import dark.simple.SimpleCharacter;	
	import dark.net.CommandCode;
	import dark.net.commands.PlayerTeleportDoneCommand;

	/**
	 * ...
	 * @author 
	 */
	public class GameTeleportWork implements IGameInitDelegate
	{
		
		public var mapId:int = 0;
		public var x2:int = 0;
		public var y2:int = 0;

		public var game:IGame = null;
		
		public function GameTeleportWork(mapId:int, x2:int, y2:int, game:IGame) 
		{
			this.mapId = mapId;
			this.x2 = x2;
			this.y2 = y2;
	
			this.game = game;
		}
		
		public function gameInitDone():void
		{
			
			trace("GameTeleportWork gameInitDone");
			
			var cmd:PlayerTeleportDoneCommand = new PlayerTeleportDoneCommand(mapId, x2, y2);
				
			game.writeCommand(cmd, null);
		}
		
		public function start(delay:int)
		{
			var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, callback);
			timer.start();
		}
		
		public function callback(e:TimerEvent)
		{			
			
			var player:SimpleCharacter = game.getPlayer();
			
			player.gamePt.x = x2;
			player.gamePt.y = y2;
			
			game.updateGameView();	
			
			trace("gamePlayerTeleport", mapId, x2, y2);
			
			var currentMapId:int = game.getCurrentMapId();
			
			if (mapId != currentMapId)
			{
				game.gameRestart(this);
			} else 
			{			
				gameInitDone();
			}
		}
		
	}

}