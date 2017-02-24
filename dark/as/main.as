package  
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import dark.Game;	
	
	import dark.net.ConnectionDataDelegate;
	import dark.AppDelegate;
	import dark.loaders.LoaderSprite;
	import dark.IDebugDelegate;
	
	public class main extends Sprite implements IDebugDelegate
	{
		
		public var app:AppDelegate = null;
		private var _loader:LoaderSprite = null;
		public var simpleGame:Game = null;
		public var debugTextField:TextField = null;
		
		public var container:Sprite = null;
		
		
		public var serverHost:String = "127.0.0.1";
		
		public function main() 
		{			
			
			
			
			debugTextField = new TextField();
			debugTextField.textColor = 0xffffff;
			debugTextField.autoSize = TextFieldAutoSize.LEFT;
			
			//debugTextField.y = 600;
			debugTextField.width = 800;
			debugTextField.height = 300;
			debugTextField.mouseEnabled = false;
		
			debugTextField.alpha = 0.3;
			
			
			var flashParameters:Object = this.root.loaderInfo.parameters;
			
			var servHost:String = flashParameters["serv"];
			
			
			if (servHost != null)
			{
				this.serverHost = servHost;
			}
			
			debugMessage("servHost:" + servHost);
			
			container = new Sprite();
			addChild(container);
			addChild(debugTextField);
		
			
			
			app = new AppDelegate(null, this);
			//simpleGame = new SimpleGame(app);
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, _addedToStage);		
		}
		
		public function debugMessage(text:String)
		{
			debugTextField.text = text + "\n" + debugTextField.text;
		}
		
		private function _onStageResize(e:Event):void
		{
			if (simpleGame != null)
			{
				simpleGame.resize();
			}
		}
		
		private function _addedToStage(e:Event):void
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = 	StageAlign.TOP_LEFT;
			
			stage.addEventListener(Event.RESIZE, _onStageResize);
			
			debugMessage("asset load start...");
			_loader = new LoaderSprite(app);
			
			addChild(_loader);
			
			_loader.addEventListener(LoaderSprite.LOADDONE, _onLoadDone);
			
			_loader.startLoad();			
			
			//view.update();			
			/*
			
			view.addMapRect(
			*/
			
			
		}
		
		private function _onLoadDone(e:Event)
		{
			
			removeChild(_loader);
			
			_loader = null;
			
			
			simpleGame = new Game(app, this);
			container.addChild(simpleGame);
			
			simpleGame.connectTCP(serverHost, 16096);
			
			//debugMessage("asset loaded...");
			
			
			
		}
		
		
	}

}