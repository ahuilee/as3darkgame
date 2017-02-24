package dark 
{
	
	
	public interface IGameObjWork 
	{
		
		function onStartWork():void;
		function runWork(nowTime:Number):void;
		function onWorkDone():void;
		
		function get isDone():Boolean;
		
	}
	
}