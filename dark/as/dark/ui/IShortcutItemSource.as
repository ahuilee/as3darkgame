package dark.ui 
{
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IShortcutItemSource 
	{
		
		function getShortcutItemBitmapData():BitmapData;
		//function getShortcutItemText():String;
		function getShortcutItemUseDelegate():IShortcutItemUseDelegate;
		function displayShortcutItemInfo(infoSprite:DisplayItemInfoSprite):void;
		
		
		function getStorageType():int;
		function getStorageId():int;
		
	}
	
}