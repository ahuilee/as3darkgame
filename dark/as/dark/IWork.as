package dark 
{
	
	
	public interface IWork 
	{
		function getWorkWeighted():int;
		function run():void;
		
		function except(err:Error):void;
	}
	
}