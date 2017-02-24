package dark.net 
{
	
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ahui
	 */
	public class CommandReceiveHandler 
	{
		
		public var conn:Connection = null;
		
		public function CommandReceiveHandler(conn:Connection) 
		{
			this.conn = conn;
		}
		
		public function onDeleObj(ask:int, rd:DataByteArray)
		{
			var count:int = rd.readUnsignedShort();
			var pks:Array = [];
			for (var i:int = 0; i < count; i++)
			{
				var objKey1:int = rd.readInt();
				var objKey2:int = rd.readInt();
				
				var delKey:GameObjectKey = new GameObjectKey(objKey1, objKey2);
				
				conn.delegate.gameSyncDeleteObj(delKey);
			}
			
			conn.writeAnswerSuccess(ask, null);
		}
		
		private function unpackSyncData(rd:DataByteArray):GameSyncData
		{
			var syncData:GameSyncData = new GameSyncData();
			
			var j:int = 0;
			var objKey1:int = 0;
			var objKey2:int = 0;					
			var nodeType:int = 0;
			var nodeCount:int = 0;
						
				//trace("GAME_SYNC_DATA", count);
			objKey1 = rd.readInt();
			objKey2 = rd.readInt();
						
			syncData.objKey = new GameObjectKey(objKey1, objKey2);
			nodeCount = rd.readShort();
						
			for (j = 0; j < nodeCount; j++)
			{
				nodeType = rd.readShort();
							
				switch (nodeType) 
				{
					case SyncDataTypes.CHARACTER_POSITION:
									
						var charPos:SyncDataCharPosItem = new SyncDataCharPosItem();
						charPos.x = rd.readInt();
						charPos.y = rd.readInt();
						charPos.dir = rd.readByte();
									
						syncData.infos.push(charPos);
									
						break;
						/*			
						case SyncDataTypes.ANIMATION_GOTO:
									
							var animationGotoData:SyncDataCharAnimationGoto = new SyncDataCharAnimationGoto();
							animationGotoData.animationId = rd.readShort();							
							animationGotoData.frameIndex = rd.readShort();		
									
							syncData.infos.push(animationGotoData);
									
							break;
					*/			
					case SyncDataTypes.WALK_TO:
							
						var walkTo:SyncDataObjWalkTo = new SyncDataObjWalkTo();									
						walkTo.x1 = rd.readInt();
						walkTo.y1 = rd.readInt();									
						walkTo.direction1 = rd.readByte();
							
						walkTo.x2 = rd.readInt();
						walkTo.y2 = rd.readInt();
						walkTo.startServTicks = rd.readUInt48();
						walkTo.duration = rd.readInt24();
						walkTo.debugType = rd.readByte();
						syncData.infos.push(walkTo);
						break;
							
					case SyncDataTypes.ANIMATION:
							
						var animationData:SyncAnimationData = new SyncAnimationData();
						animationData.direction2 = rd.readByte();
						animationData.animationId = rd.readShort();
						animationData.startServTicks = rd.readUInt48();						
						animationData.duration = rd.readInt24();
						animationData.debugType = rd.readByte();
						
						syncData.infos.push(animationData);
						break;
							
					case SyncDataTypes.OBJ_DEAD:
						var objDeadData:SyncDataObjDead = new SyncDataObjDead();				
						objDeadData.animationStartServTicks = rd.readUInt48();
						objDeadData.x = rd.readInt();
						objDeadData.y = rd.readInt();
						objDeadData.direction = rd.readByte();
						//trace("OBJ_DEAD", objDeadData);
						syncData.infos.push(objDeadData);
						break;
							
					case SyncDataTypes.STAND:							
		
						var stdData:SyncDataObjStand = new SyncDataObjStand();
						stdData.x = rd.readInt();
						stdData.y = rd.readInt();
						stdData.direction = rd.readByte();							
						stdData.debugType = rd.readByte();
						
						syncData.infos.push(stdData);					
							
							//trace("standData", syncData.infos, stdData);
							
						break;
						/*
					case SyncDataTypes.HURT:
						
						var hurtData:SyncDataObjHurt = new SyncDataObjHurt();
						hurtData.startServTicks = rd.readUInt48();
						//hurtData.x = rd.readInt();
						//hurtData.y = rd.readInt();
						//hurtData.direction = rd.readByte();							
							
						syncData.infos.push(hurtData);		
						
						break;
					*/			
					default:
						break;
				}						
			}
				
			return syncData;
		}
		
		private function onSyncData(ask:int, rd:DataByteArray):void
		{
			var count:int = rd.readShort();
			
			//trace("onSyncData", count);
					
			//var i:int = 0;	
			var syncDataList:Array = [];
					
			for (var i:int = 0; i < count; i++)
			{
				syncDataList.push(unpackSyncData(rd));	
			}
			
	
			conn.delegate.gameSyncData(ask, syncDataList);	
			//conn.writeAnswerSuccess(ask, null);
		}
		
		private function onPlayerTeleport(ask:int, rd:DataByteArray):void
		{
			var mapId:int = rd.readInt();
			var x2:int = rd.readInt();
			var y2:int = rd.readInt();
			var delay:int = rd.readInt();
			
			conn.delegate.gamePlayerTeleport(mapId, x2, y2, delay);
		}
		
		private function onSkillEffectPlay(ask:int, rd:DataByteArray):void
		{
			var effectId:int = rd.readInt24();
			var x2:int = rd.readInt();
			var y2:int = rd.readInt();
			
			conn.delegate.gameEffectPlay(effectId, x2, y2);
		}
		
		private function onSkillEffectPlayFollow(ask:int, rd:DataByteArray):void
		{
			var effectId:int = rd.readInt24();
			var objKey:GameObjectKey = rd.readObjKey();
			
			
			conn.delegate.gameEffectPlayFollow(effectId, objKey);
		}
		
		private function onGameSoundPlay(ask:int, rd:DataByteArray):void
		{
			var audioId:int = rd.readInt();
			var volume:int = rd.readByte();
			trace("onGameAudioPlay", ask, "audioId", audioId, "volume", volume);
			
			conn.delegate.gameSoundPlay(audioId, volume);
		}
		
		
		private function onDisplayTalkMessage(ask:int, rd:DataByteArray):void
		{		
			
			var item:DisplayTalkMessageItem = new DisplayTalkMessageItem();
			item.text = rd.readHStr();
			
			//trace("onDisplayTalkMessage", item.text );
			
			conn.delegate.gameDisplayTalkMessage(item);
		}
		
		
		private function onPlayerLevelUpdate(ask:int, rd:DataByteArray):void
		{		
			
			var data:PlayerLevelUpdateData = new PlayerLevelUpdateData();
			data.charLevel = rd.readShort();
			
			data.charExpPercent = rd.readUnsignedByte() / 255.0;	
			
			data.maxHp = rd.readInt24();
			data.maxMp = rd.readInt24();
			
			
			conn.delegate.gamePlayerLevelUpdate(data);
		}
		
		private function onPlayerHealthUpdate(ask:int, rd:DataByteArray):void
		{		
			
			var data:PlayerHealthUpdateData = new PlayerHealthUpdateData();
			data.charHp = rd.readInt24();
			data.charMp = rd.readInt24();		
			
			
			conn.delegate.gamePlayerHealthUpdate(data);
		}
		
		private function onPlayerDead(ask:int, rd:DataByteArray):void
		{	
			conn.delegate.gamePlayDead();
			
		}
		
		private function onPlayerMagicBuffAdd(ask:int, rd:DataByteArray):void
		{	
			var typeId:int = rd.readInt24();
			var templateId:int = rd.readInt24();
			var expireServTick:int = rd.readUInt48();
			
			
			
			conn.delegate.gamePlayerMagicBuffAdd(typeId, templateId, expireServTick);
			
		}
		
		
		public function commandReceived(packet:Packet):void
		{
			var rd:DataByteArray = packet.body;
			var ask:int = rd.readInt();
			var code:int = rd.readInt24();
			
			//trace("commandReceived", ask, code);
			
			switch(code)
			{			
				case CommandCode.GAME_SYNC_DATA:
					onSyncData(ask, rd);
					break;
					
				case CommandCode.GAME_REMOVE_OBJ:
					onDeleObj(ask, rd);					
					break;
					
				case CommandCode.SKILL_EFFECT_PLAY:
					onSkillEffectPlay(ask, rd);
					break;
					
				case CommandCode.SKILL_EFFECT_PLAY_FOLLOW:
					onSkillEffectPlayFollow(ask, rd);
					break;
					
				case CommandCode.GAME_SOUND_PLAY:
					onGameSoundPlay(ask, rd);
					break;
					
				case CommandCode.PLAYER_TELEPORT:
					onPlayerTeleport(ask, rd);
					break;
					
				case CommandCode.DISPLAY_TALK_MESSAGE:
					onDisplayTalkMessage(ask, rd);
					break;
				
				case CommandCode.PLAYER_HEALTH_UPDATE:
					onPlayerHealthUpdate(ask, rd);
					break;
					
				case CommandCode.PLAYER_LEVEL_UPDATE:
					onPlayerLevelUpdate(ask, rd);
					break;
					
				case CommandCode.PLAYER_MAGIC_BUFF_ADD:
					onPlayerMagicBuffAdd(ask, rd);
					break;
					
				case CommandCode.PLAYER_HURT_SET:
					conn.delegate.gamePlayerHurtSet();
					break;
				
				case CommandCode.PLAYER_DEAD:
					onPlayerDead(ask, rd);
					break;
					
				
					
				
			}
			
		
			
		}
		
	}

}