package dark.views 
{
	import dark.GameObjNameData;
	import dark.IGameObject;
	import dark.net.GameObjectKey;
	import dark.netcallbacks.GameObjGetNameCallback;
	import dark.netcallbacks.GetNameCallbackData;
	import dark.netcallbacks.IGameGetObjNameCallbackDelegate;
	/**
	 * ...
	 * @author ahui
	 */
	public class DisplayNameGetCallbackDelegate implements IGameGetObjNameCallbackDelegate
	{
		
		public var iobj:IGameObject = null;
		public var getNameCallback:GameObjGetNameCallback = null;
		public var container:DisplayNameContainer = null;
		
		public function DisplayNameGetCallbackDelegate(iobj:IGameObject, getNameCallback:GameObjGetNameCallback, container:DisplayNameContainer) 
		{
			this.iobj = iobj;
			this.getNameCallback = getNameCallback;
			this.container = container;
		}
		
		
		public function getObjNameCallback(data:GetNameCallbackData):void
		{
			
			
			container.setCallback(iobj, getNameCallback, data);
		}
		
	}

}