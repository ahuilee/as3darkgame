package dark.models 
{
	
	public class GameItem 
	{
		
		public var id:int = 0;
		public var templateId:int = 0;
		
		
		public function toString():String		
		{
			return "<GameItem id=" + id + " templateId=" + templateId  + ">";
		}
	}

}