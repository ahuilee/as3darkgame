package dark 
{
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author ahui
	 */
	public class LazyGameStartKeyboardDelegate implements IGameKeyboardEventDelegate
	{
		
		public var game:Game = null;
		
		public function LazyGameStartKeyboardDelegate(game:Game) 
		{
			this.game = game;
		}
		
		public function onKeyDown(e:KeyboardEvent)
		{
			//trace("_keyDown");
			switch (e.keyCode) 
			{
				
				case Keyboard.NUMBER_6:
					game.toggleGameMapChunkGrids();
					break;
					
				case Keyboard.NUMBER_7:
					game.toggleGameObjHitTestRects();
					break;
				
				case Keyboard.I:
					game.toggleShowItemListView();
					break;
					
				case Keyboard.C:
					game.toggleShowCharacterInfoView();
					break;
				
				case Keyboard.S:
					game.toggleShowCharacterSkillListView();
					break;					
					
				case Keyboard.Z:
					if (!_displayItemInfos)
					{
						_displayItemInfos = true;
						game.view.displayNameContainer.displayAllItemInfos();
					}
					//trace("Z");
					break;
				
				case Keyboard.ESCAPE:
					/*
					trace("ESCAPE");
					if (shopItemListView.visible)
					{
						shopItemListView.visible = false;
					}*/
					
					break;
					
				default:
			}
		}
		
		private var _displayItemInfos:Boolean = false;
		
		public function onKeyUp(e:KeyboardEvent)
		{
			if (_displayItemInfos)
			{
				_displayItemInfos = false;
				game.view.displayNameContainer.hideAllItemInfos();
			}
			
		}
		
	}

}