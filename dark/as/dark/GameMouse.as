package dark 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class GameMouse extends Sprite
	{
		
		public var bitmap:Bitmap = null;
		
		public var game:Game = null;
		public var bdAttack:BitmapData = null;
		public var bdSelectTarget:BitmapData = null;
		public var bdNormal:BitmapData = null;
		
		public var dragContainer:Sprite = null;
		public var container:Sprite = null;
		
		public function GameMouse(game:Game) 
		{
			this.game = game;
			
			var atkKlass:Class = game.app.getClassByKey("Base_Bd_MouseAttack");
			bdAttack = new atkKlass();
			
			var NormalKlass:Class = game.app.getClassByKey("Base_Bd_MouseNormal");
			bdNormal = new NormalKlass();
			
			var SkillSelectKlass:Class = game.app.getClassByKey("BASE_BD_MouseSkillSelect");
			bdSelectTarget = new  SkillSelectKlass();

		
			
			container = new Sprite();
			dragContainer = new Sprite();
			
			bitmap = new Bitmap(bdNormal);		
			
			container.addChild(dragContainer);	
			container.addChild(bitmap);			
		
			addChild(container);
			
			this.addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeFromToStage);
			
		}
		
		public function setMouseDragChild(sprite:Sprite):void
		{
			var numChildren:int = dragContainer.numChildren;
			for (var i:int = 0; i < numChildren; i++)
			{
				dragContainer.removeChildAt(0);
			}
			
			if (sprite != null)
			{
			
				dragContainer.addChild(sprite);
			}
			
		}
		
		private function _addedToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			
			Mouse.hide();
		}
		
		private function _removeFromToStage(e:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
			Mouse.show();
		}
		
		
		
		private function _onStageMouseMove(e:MouseEvent)
		{
			this.x = stage.mouseX;
			this.y = stage.mouseY;
		}
		

		public function changeAttack():void
		{
			this.x = stage.mouseX;
			this.y = stage.mouseY;
			bitmap.bitmapData = bdAttack;
			
		}
		
			
		public function changeSelectTarget():void
		{
			this.x = stage.mouseX - bdSelectTarget.width/ 2;
			this.y = stage.mouseY - bdSelectTarget.height/ 2;
			bitmap.bitmapData = bdSelectTarget;
			
		}
		
		public function changeNormal():void
		{
			this.x = stage.mouseX;
			this.y = stage.mouseY;
			bitmap.bitmapData = bdNormal;
			
		}
		
	}

}