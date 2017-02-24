package dark 
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import dark.net.GameObjectKey;
	import dark.display.DisplayDelegateFrameArrayDataSprite;
	import dark.display.SkillEffectFrameArrayData;
	import dark.display.SkillEffectFrameArrayDataSprite;
	import dark.display.SkillEffectFrameArrayDataFollowSprite;


	
	public class LazyGameSkillEffectPlay 
	{
		
		public var game:Game = null;
		
		public function LazyGameSkillEffectPlay(game:Game) 
		{
			this.game = game;
		}
		
		
		
		
		public function play(effectId:int, x2:int, y2:int)
		{
			trace("gameEffectPlay2", effectId, x2, y2);		
			
			
			var frames:SkillEffectFrameArrayData = null;
			
			var SoundClass:Class = null;
			
			frames = game.app.getSkillEffectFrameArrayData(effectId);
			
			switch(effectId) 
			{
				
				//升級
				case SkillEnums.SE_007:					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					
					break;
				
				case SkillEnums.SE_001:
					
					
					break;
					
				case SkillEnums.SE_002:					
					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;
				
				//隕石術
				case SkillEnums.SE_003:
					
					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;
					
				//冰雪暴
				case SkillEnums.SE_004:
					
				
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;	
				
				case SkillEnums.SE_005:
					
					frames = game.app.getSkillEffectFrameArrayData(effectId);
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;
				case SkillEnums.SE_006:
					
					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;	
					
				case SkillEnums.SE_008:
					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					
					trace("SkillEnums.TELEPORT:", frames);
					break;	
					
				case SkillEnums.SE_009:					
					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;	
					
				case SkillEnums.SE_010:	
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					break;	
					
				default:
					break;
			}
			
			if (frames != null)
			{
				
				var iobj:SkillEffectFrameArrayDataSprite = new SkillEffectFrameArrayDataSprite(x2, y2, frames, game);
			
			
				var pt:Point = game.view.calcGamePtToFlashPt(x2, y2);
				iobj.x = pt.x;
				iobj.y = pt.y;
				
				if (SoundClass != null)
				{					

					var volume:Number = game.calcEffectSoundVolumeByFlashPt(pt.x, pt.y);
					
					if (volume > 0)
					{
						var sound:Sound = new SoundClass();
						
						trace("!!!!!!!!!!!Effect volume", volume);

						var soundTransform:SoundTransform = new SoundTransform(volume);
						sound.play(0, 0, soundTransform);					
					}
				}
				
				game.view.addGameSprite(iobj);
				
				return ;
			}
		}
		
		public function playFollow(effectId:int, objKey:GameObjectKey):void
		{
			
			var syncDelegate:ISyncObjDelegate = game.syncLogic.getSyncDelegateByKey(objKey);
			
			if (syncDelegate == null)
			{
				return;
			}
			
			var frames:SkillEffectFrameArrayData = null;
			
			var SoundClass:Class = null;
			frames = game.app.getSkillEffectFrameArrayData(effectId);
			
			switch(effectId) 
			{
				
				//升級
				case SkillEnums.SE_007:					
					SoundClass = game.app.getSoundClass(GameSoundEnums.GS_THUNDER);
					
					break;
			}
			
			if (frames != null)
			{
				
				
				var sprite:SkillEffectFrameArrayDataFollowSprite = new SkillEffectFrameArrayDataFollowSprite(syncDelegate, frames, game);
			
				var gamePt:Point = syncDelegate.getGamePoint();
				var pt:Point = game.view.calcGamePtToFlashPt(gamePt.x, gamePt.y);
				sprite.x = pt.x;
				sprite.y = pt.y;
				
				if (SoundClass != null)
				{					
					var centerDist:Number = Math.sqrt(Math.pow(game.view.centerGamePt.x - pt.x, 2) + Math.pow(game.view.centerGamePt.y - pt.y, 2));
					
					var sound:Sound = new SoundClass();
					var volume:Number = 1.0 / centerDist / 4.0;					
					
					
					if (volume < 0.2)
					{
						volume = 0.2;
					}
					
					
					trace("Effect centerDist", centerDist, volume);

					var soundTransform:SoundTransform = new SoundTransform(volume);
					sound.play(0, 0, soundTransform);
				}
				
				game.view.addGameSprite(sprite);
				
			}
			
		}
		
		
		
		
	}

}