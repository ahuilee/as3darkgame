package dark 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ahui
	 */
	public class AssetManager 
	{
		
		public function AssetManager() 
		{
			
		}
		
		
		private var _loadedAssetPks:Dictionary = new Dictionary();
		
		public function getAssetIsLoaded(assetPk:int):Boolean
		{
			if (_loadedAssetPks[assetPk] != null)			
			{
				return true;
			}
			
			return false;
		}
		
		public function setAssetIsLoaded(assetPk:int):void
		{
			_loadedAssetPks[assetPk] = true;
		}
		
	}

}