package dark.loaders 
{
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	
	import dark.display.BitmapAnimationArray;
	import dark.Game;
	import dark.AppDelegate;
	import dark.GameSoundEnums;
	import dark.GameTemplateEnums;
	//import dark.loaders.LoaderNPCSprite;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	
	public class ChangeMapLoaderSprite extends Sprite implements IAssetLoader
	{
		
		
		
		private var _loaderMax:LoaderMax = null;
		private var _progressRect:Rectangle = new Rectangle(0, 0, 0, 12);
		
		private var _textField:TextField = null;
		
		public var game:Game = null;
		
		private var _items:Array = null;
		
		public function ChangeMapLoaderSprite(game:Game) 
		{
			this.game = game;
			
			_textField = new TextField();
			_textField.selectable = false;
			_textField.textColor  = 0xffffff;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textField);
			
			_loaderMax = new LoaderMax( {name: "mainQueue", onProgress:_onLoadProgress, onComplete:_onLoadComplete, onError: _onLoadError} );
			
			_items = new Array();
			_getItemByName = new Dictionary();
			
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
			
		}
		
		public function addItem(loadItem:IAssetLoadItem):void
		{
			_items.push(loadItem);
		}
		
		private var _getItemByName:Dictionary = null;
		
		private function _resizeProgressRect()
		{
			
			var x2:Number = stage.stageWidth * .1;
			_textField.y = stage.stageHeight / 2 - 30;
			_textField.x = x2;
			
			_progressRect.x = x2;
			_progressRect.y = stage.stageHeight / 2 - _progressRect.height/2;
			_progressRect.width = stage.stageWidth * .8;
		}
		
		public var delegate:IAssetLoaderDelegate = null;
		
		public function startLoad(delegate:IAssetLoaderDelegate):void
		{
			this.delegate = delegate;
			
			for (var i:int = 0; i < _items.length; i++)
			{
				var item:IAssetLoadItem = _items[i];
				
				var name:String = "item_" + i;
				
				_getItemByName[name] = item;
				
				var loader:LoaderCore = item.getLoader();
				
				loader.name = name;
				
				_loaderMax.append(loader);
				
			}
			
			game.app.debug.debugMessage("load start...");
			
			_loaderMax.load();
		}
		
		private function _onRemoveFromStage(e:Event)
		{
			stage.removeEventListener(Event.RESIZE, _onStageResize);
		}
		
		private function _onAddedToStage(e:Event)
		{
			_resizeProgressRect();
			stage.addEventListener(Event.RESIZE, _onStageResize);
		}
		
		private function _onStageResize(e:Event)
		{
			
			
			_resizeProgressRect();
			trace("_onStageResize", _progressRect);
		}
		
		
		private function _onLoadError(e:LoaderEvent)
		{
			game.app.debug.debugMessage("_onLoadError" + e);
		}
		
		private function _onLoadProgress(e:LoaderEvent)
		{
			//app.debug.debugMessage("_onLoadProgress: " +  _loaderMax.bytesLoaded + "/" + _loaderMax.bytesTotal);
		
			
			var g:Graphics = this.graphics;
			
			g.clear();
			
			g.beginFill(0x666666, .75);
			g.drawRect(_progressRect.x, _progressRect.y, _progressRect.width, _progressRect.height);
			g.endFill();
			
			var percent:Number = _loaderMax.bytesLoaded / _loaderMax.bytesTotal ;
			
			//var w2:Number = * _progressRect.width;
			var w2:Number = percent * _progressRect.width;
			g.beginFill(0xffffff, .75);
			g.drawRect(_progressRect.x, _progressRect.y, w2, _progressRect.height);
			g.endFill();
			
			
			var percent2:int = (int)( percent * 100.0 );
			
			_textField.text = percent2 + "%...";
			
		}
		
		private function _onLoadComplete(e:LoaderEvent)
		{
			game.app.debug.debugMessage("_onLoadComplete" + e);
			
			/*
			new LoaderBaseSet(_loaderMax.getLoader("base"), app).load();
			
			
			new LoaderAssetsSet(_loaderMax.getLoader("assets"), app).load();
			
			
			new LoaderSound(_loaderMax.getLoader("sound"), app).load();
			
		
			new LoaderMap(_loaderMax.getLoader("maps"), app).load();
			
			
			new LoaderIconSet(_loaderMax.getLoader("icons"), app).load();
			
			
			new LoaderUI( _loaderMax.getLoader("ui"), app).load();
			
			new LoaderNPC2(_loaderMax.getLoader("npc"), app).load();
			
			
			new LoaderSkillEffects(_loaderMax.getLoader("skill_effect"), app).load();
			
			*/
			
			delegate.onAssetLoaded();
			
		}
		
		

	}

}