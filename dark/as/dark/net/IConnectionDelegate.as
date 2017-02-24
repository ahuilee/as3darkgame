package dark.net 
{
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IConnectionDelegate 
	{
		
		
		function onConnectionMade():void;
		
		function onUserLoginSuccess(charDataArray:Array):void;
		
		//if getinfo required then on callback after response answer
		function gameSyncData(ask:int, syncDataList:Array):void;
		
		function gameSyncDeleteObj(objKey:GameObjectKey):void;		
		
		function gamePlayerTeleport(mapId:int, x2:int, y2:int, delay:int):void;
		function gamePlayerLevelUpdate(data:PlayerLevelUpdateData):void;
		function gamePlayerHealthUpdate(data:PlayerHealthUpdateData):void;
		
		function gameEffectPlay(effectId:int, x2:int, y2:int):void;
		function gameEffectPlayFollow(effectId:int, objKey:GameObjectKey):void;
		
		
		function gameSoundPlay(audioId:int, volume:int):void;
		
		
		function gameDisplayTalkMessage(item:DisplayTalkMessageItem):void;
		
		function gamePlayDead():void;
		
		function gamePlayerMagicBuffAdd(typeId:int, templateId:int, expireServTick:Number):void;
		
		function gamePlayerHurtSet():void;
		
	}
	
}