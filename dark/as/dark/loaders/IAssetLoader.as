package dark.loaders 
{
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IAssetLoader 
	{
		function addItem(loadItem:IAssetLoadItem):void;
		function startLoad(delegate:IAssetLoaderDelegate):void;
	}
	
}