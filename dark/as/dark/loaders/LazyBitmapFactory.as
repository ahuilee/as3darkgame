package dark.loaders 
{
	import com.greensock.loading.SWFLoader;
	import dark.AppDelegate;
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyBitmapFactory 
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LazyBitmapFactory(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			
		}
		
	}

}