package dark.views 
{
	import flash.geom.Rectangle;
	
	
	public interface IMapRectNode 
	{
		
		function get bound():Rectangle;
		
		function hide(gameView:LazyGameView):void;
		function display(gameView:LazyGameView, gameBound:Rectangle):void;
		
		
	}
	
}