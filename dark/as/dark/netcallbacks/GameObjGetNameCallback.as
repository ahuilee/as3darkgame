package dark.netcallbacks 
{
	import dark.IGameInteractiveDelegate;
	
	import dark.IGameObject;

	import dark.Game;
	/**
	 * ...
	 * @author 
	 */
	public class GameObjGetNameCallback 
	{
		
		public var iobj:IGameObject = null;
		
		public var game:Game = null;
	

		
		public function GameObjGetNameCallback(iobj:IGameObject, game:Game) 
		{
			this.iobj = iobj;
			this.game = game;
			
	
		}
		
		public function getNameCallback(data:GetNameCallbackData):void 
		{
			
			trace("getNameCallback", data);
			
			if (data.interactiveData.attack)
			{
				game.mouseHandler.setMouseAttackIfNoSelectTarget();
			} 
			
			
			var interactiveDelegate:IGameInteractiveDelegate = iobj.getInteractiveDelegate();
			
			if (interactiveDelegate != null)
			{
				interactiveDelegate.setGameInteractive(data.interactiveData);
			}
			
			//delegate.showGameObjName(data.name);
			
			/*
			canAttack = data.interactiveData.attack;
				
			
				//trace("getGameObjNameByKey result=", name);
				
			if (setInteractiveDataCallback != null)
			{
				setInteractiveDataCallback(data.interactiveData);
			}
			/
				
			if (canAttack)
			{
				
			}*/
		}
		
		
	}

}