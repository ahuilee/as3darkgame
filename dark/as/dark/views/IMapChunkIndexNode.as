package dark.views 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ahui
	 */
	public interface IMapChunkIndexNode
	{
		function hitTest(flashViewRect:Rectangle):Boolean;
		function getMapChunks(flashViewRect:Rectangle):Array;
		function unload():void;
	}
	
}