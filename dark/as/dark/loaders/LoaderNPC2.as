package dark.loaders 
{
	import com.greensock.loading.SWFLoader;
	import dark.AppDelegate;
	/**
	 * ...
	 * @author ahui
	 */
	public class LoaderNPC2 
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderNPC2(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		public function load():void
		{
			
			new LazyNPC001Loader(this).load();
			new LazyNPC002Loader(this).load();
			new LazyNPC003Loader(this).load();

			new LazyNPC031Loader(this).load();
		}
		
	}

}