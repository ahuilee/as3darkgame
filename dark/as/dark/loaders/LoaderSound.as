package dark.loaders 
{
	import dark.GameSoundEnums;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import dark.AppDelegate;

	import com.greensock.loading.SWFLoader;
	/**
	 * ...
	 * @author 
	 */
	public class LoaderSound
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderSound(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		public function load():void
		{
			
			
			app.setMusic(1, loader.getClass("Music01"));
			app.setMusic(2, loader.getClass("Music02"));
			app.setMusic(3, loader.getClass("Music03"));
			
			
			
			app.setSound(GameSoundEnums.GS_TELEPORT, loader.getClass("Sound_Teleport"));
			app.setSound(GameSoundEnums.GS_THUNDER, loader.getClass("Sound_Thunder01"));
			
			
			
			app.setSound(GameSoundEnums.GS_PLAYER_HURT1, loader.getClass("Sound_PlayerHurt"));
			
			//app.setSound(GameSoundEnums.GS_WOLF_HURT1, loader.getClass("Sound_WolfTakingFire"));			
			
			
			app.setSound(GameSoundEnums.GS_BLACKKINGHT_HURT1, loader.getClass("Sound_BlackKnightHurt"));
			app.setSound(GameSoundEnums.GS_BLACKKINGHT_DEAD1, loader.getClass("Sound_BlackKnightDead"));
			
			app.setSound(GameSoundEnums.GS_ATTACK01, loader.getClass("Sound_Attack01"));
			app.setSound(GameSoundEnums.GS_ATTACK02, loader.getClass("Sound_Attack02"));
		}
		
		
		
		
		
	}

}