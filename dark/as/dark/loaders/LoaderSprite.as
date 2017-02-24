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
	
	import dark.display.BitmapAnimationArray;
	import dark.AppDelegate;
	import dark.GameSoundEnums;
	import dark.GameTemplateEnums;
	//import dark.loaders.LoaderNPCSprite;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	
	public class LoaderSprite extends Sprite
	{
		
		public static const LOADDONE:String = "LOADDONE";
		
		private var _loaderMax:LoaderMax = null;
		private var _progressRect:Rectangle = new Rectangle(0, 0, 0, 12);
		
		private var _textField:TextField = null;
		
		public var app:AppDelegate = null;
		
		public function LoaderSprite(app:AppDelegate) 
		{
			this.app = app;
			
			_textField = new TextField();
			_textField.textColor  = 0xffffff;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textField);
			
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
			
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
		
		private function _resizeProgressRect()
		{
			
			var x2:Number = stage.stageWidth * .1;
			_textField.y = stage.stageHeight / 2 - 30;
			_textField.x = x2;
			
			_progressRect.x = x2;
			_progressRect.y = stage.stageHeight / 2 - _progressRect.height/2;
			_progressRect.width = stage.stageWidth * .8;
		}
		
		public function startLoad():void
		{
			_loaderMax = new LoaderMax( {name: "mainQueue", onProgress:_onLoadProgress, onComplete:_onLoadComplete, onError: _onLoadError} );
			_loaderMax.append(new SWFLoader("base.swf", { name: "base" } ));
			_loaderMax.append(new SWFLoader("maps.swf", { name: "maps" } ));
			_loaderMax.append(new SWFLoader("assets.swf", { name: "assets" } ));
			
			_loaderMax.append(new SWFLoader("icons.swf", { name: "icons" } ));
			
			_loaderMax.append(new SWFLoader("sound.swf", { name: "sound" } ));
			_loaderMax.append(new SWFLoader("skill_effect.swf", { name: "skill_effect" } ));
			_loaderMax.append(new SWFLoader("ui.swf", { name: "ui" } ));
			//_loaderMax.append(new SWFLoader("npc.swf", { name: "npc" } ));
			
			app.debug.debugMessage("_loaderMax start...");
			
			_loaderMax.load();
		}
		
		
		private function _onLoadError(e:LoaderEvent)
		{
			app.debug.debugMessage("_onLoadError" + e);
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
			app.debug.debugMessage("_onLoadComplete" + e);
			
			
			new LoaderBaseSet(_loaderMax.getLoader("base"), app).load();
			
			
			new LoaderAssetsSet(_loaderMax.getLoader("assets"), app).load();
			
			
			new LoaderSound(_loaderMax.getLoader("sound"), app).load();
			
		
			new LoaderMap(_loaderMax.getLoader("maps"), app).load();
			
			
			new LoaderIconSet(_loaderMax.getLoader("icons"), app).load();
			
			
			new LoaderUI( _loaderMax.getLoader("ui"), app).load();
			
			//new LoaderNPC2(_loaderMax.getLoader("npc"), app).load();
			
			
			new LoaderSkillEffects(_loaderMax.getLoader("skill_effect"), app).load();
			
			
			dispatchEvent(new Event(LOADDONE));
		}
		
		

		
		private function _loadTAndSet(loader:SWFLoader, templateId:int, className:String)
		{
		
		}
		

		
		
	}

}