package dark.works 
{
	import dark.Game;
	import dark.net.ICommand;
	import dark.net.ICommandCallback;
	import dark.IWork;
	/**
	 * ...
	 * @author ahui
	 */
	public class WriteCommandWork  implements IWork
	{
		
		public var game:Game = null;
		public var command:ICommand = null;
		public var callback:ICommandCallback = null;
		
		public function WriteCommandWork(game:Game, command:ICommand, callback:ICommandCallback=null) 
		{
			this.game = game;
			this.command = command;
			this.callback = callback;
		}
		
		public function run():void
		{
			game.conn.writeCommand(command, callback);
		}
		
		public function getWorkWeighted():int
		{
			return 1;
		}
		
		public function except(err:Error):void
		{
			trace("WriteCommandWork err", err);
		}
		
	}

}