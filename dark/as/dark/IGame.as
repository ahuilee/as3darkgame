package dark 
{
	
	import dark.net.ICommand;
	import dark.net.ICommandCallback;
	import dark.simple.SimpleCharacter;
	import dark.models.GameItem;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IGame 
	{
		function getCurrentMapId():int;
		
		function getPlayer():SimpleCharacter;
		
		function gameRestart(delegate:IGameInitDelegate):void;
		
		function setGameServTicks(ticks:Number):void;
		function calcTimeByServTicks(servTicks):Number;
		
		
		function setGameMouseActive(enable:Boolean);
		
		function killLoginView():void;
		function clearGameView():void;
		function updateGameView():void;
		
		function writeCommand(command:ICommand, callback:ICommandCallback = null):int;
		
		
		function getAssetManager():AssetManager;
		
		
		
		
		//interactives
		function appendCItem(item:GameItem):void;
		function deleteCItem(itemId:int):void;
		function clearCItemInfo(itemId:int):void;
		
	}
	
}