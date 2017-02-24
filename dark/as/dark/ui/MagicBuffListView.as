package dark.ui 
{
	import dark.Game;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class MagicBuffListView extends Sprite
	{
		
		public var container:Sprite = null;
		public var game:Game = null;
		
		public function MagicBuffListView(game:Game) 
		{
			this.game = game;
			container = new Sprite();
			
			addChild(container);
		}
		
		private var _getSpriteByTypeId:Dictionary = new Dictionary();
		
		public function add(typeId:int, templateId:int, expireTime:Number):void
		{
			trace("MagicBuffListView add", typeId, templateId);			
			
			
			var sprite:MagicBuffListItemSprite = _getSpriteByTypeId[typeId];
			
			if (sprite == null)
			{
				sprite = new MagicBuffListItemSprite();				
				
				sprite.typeId = typeId;
				_getSpriteByTypeId[typeId] = sprite;
			}
			
			sprite.alpha = 0.6;
			sprite.expireTime = expireTime;
			sprite.setTemplateId(templateId, game);
			container.addChildAt(sprite, 0);
			sortItems();
		}
		
		private var _lastUpdateTime:Number = 0;
		
		public function updateState(now:Number):void
		{
			
			var delta:Number = now - _lastUpdateTime;
			
			if (delta >= 200)
			{
				_lastUpdateTime = now;
			
				var expireWarnning:Number = now + 10000;
				
				var removes:Array = [];
				var i:int = 0;
				var sprite:MagicBuffListItemSprite = null;
				
				for (i = 0; i < container.numChildren; i++)
				{
					sprite = container.getChildAt(i) as MagicBuffListItemSprite;
					
					
					if (now >= sprite.expireTime)				
					{
						removes.push(sprite);
						
					} else if (expireWarnning > sprite.expireTime)
					{
						var t:Number = expireWarnning - sprite.expireTime;
						var fx:int = 50 * t / 10000;
						
						if (fx % 2 == 0)
						{
							sprite.alpha = 0.2;
						} else 
						{
							sprite.alpha = 0.6;
						}
						
						//trace("MagicBuffList", idx);
						//
					}
					
				}
				
				for (i = 0; i < removes.length; i++)
				{
					sprite = removes[i];
					
					sprite.parent.removeChild(sprite);
					delete  _getSpriteByTypeId[sprite.typeId];
				}
				
				if (removes.length > 0)
				{
					sortItems();
				}
			
			}
			
		}
		
		public function sortItems():void
		{
			
			var y2:Number = 0;

			for (var i:int = 0; i < container.numChildren; i++)
			{
				var sprite:DisplayObject = container.getChildAt(i);
				
				sprite.y = y2;
				
				y2 += sprite.height + 8;
				
			}
			
			
			
		}
		
		
	}

}