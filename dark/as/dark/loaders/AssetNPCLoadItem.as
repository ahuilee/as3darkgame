package dark.loaders 
{
	import dark.AssetManager;
	import dark.IGame;
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	import dark.display.DisplayDelegateFrameArrayData;
	import dark.display.DisplayDelegateFrameArrayDataItem;
	import dark.Game;
	import dark.netcallbacks.AssetByteArray;

	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.SWFLoader;
	
	
	public class AssetNPCLoadItem implements IAssetLoadItem
	{
		public var assetId:int;
		public var url:String;
		public var game:Game;
		public var keyPrefix:String;
		
		public function AssetNPCLoadItem(assetId:int, keyPrefix:String, url:String, game:Game) 
		{
			this.assetId = assetId;
			this.keyPrefix = keyPrefix;
			this.url = url;
			this.game = game;
		}
		
		private var _loader:SWFLoader = null;
		
		private function _onComplete(e:LoaderEvent):void
		{
			var content:* = _loader.rawContent;

			
			var _rd:ByteArray = content.getData();	
			//_rd.position = 0;
			
			var rd:AssetByteArray = new AssetByteArray();
			rd.writeBytes(_rd, 0, _rd.length);
			rd.position = 0;
			
			trace("_onComplete", this, content, rd.length);
			
			
			var getFrameDataByIdx:Dictionary = new Dictionary();
			
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			var idx:int = 0;
			
			var frameArrayCount:int = rd.readUnsignedShort();
			
			for (i = 0; i < frameArrayCount; i++)
			{
				var frameArray:DisplayDelegateFrameArrayData = new DisplayDelegateFrameArrayData();
				
				idx = rd.readUnsignedShort();				

				frameArray.numFrames = rd.readUnsignedShort();				
				
				var items:Array = [];
				
				var itemCount:int = rd.readUnsignedShort();
				
				for (j = 0; j < itemCount; j++)
				{
					var x2:Number = rd.readFloat(); 
					var y2:Number = rd.readFloat(); 
					var scaleX:Number = rd.readFloat(); 
					var scaleY:Number = rd.readFloat();
					
					var outerRect:Rectangle = rd.readRect();
					
					var hitRects:Array = [];
					var hitRectCount:int = rd.readUnsignedShort();
					
					for(k = 0; k < hitRectCount; k++)
					{
						hitRects.push(rd.readRect());
					}
					
					var frames:Array = [];
					
					var classNameCount:int = rd.readUnsignedShort();
					for (k = 0; k < classNameCount; k++)
					{
						
						var className:String = rd.readHStrUTF();					
						
						var ClassInst:Class = _loader.getClass(className);
						
						//trace("className", className, ClassInst);
							
						var bdInst:BitmapData = new ClassInst();
						
						frames.push(bdInst);
						
					}
					
					
					var frameItem:DisplayDelegateFrameArrayDataItem = new DisplayDelegateFrameArrayDataItem(frames, x2, y2, scaleX, scaleY);
					frameItem.hitTestBoundOuter = outerRect;
					frameItem.hitTestRects = hitRects;
					//frameItem.classNameList = classNameList;
					
					items.push(frameItem);
				}
				
				frameArray.items = items;
				
				
				getFrameDataByIdx[idx] = frameArray;
				
				//trace("set FrameData" , idx, frameArray);
			}
			
			
			//trace("Load FrameData", key, frameData);
			
			var frameKeys:int = rd.readByte();
			
			for (i = 0; i < frameKeys; i++)
			{
				idx = rd.readByte();
				var fxKey:int = rd.readUnsignedShort();
				
				var keyWrap:String = keyPrefix + "_" + getFxNameByKey(fxKey);
				
				var frameData:DisplayDelegateFrameArrayData = getFrameDataByIdx[idx];				
				
				//trace("Load FrameData", keyWrap, frameData);
				game.app.setFrameArrayData(keyWrap, frameData);
			}
			
			
			//var game:IGame = connDelegate.game;
			var assetMgr:AssetManager = game.getAssetManager();
			assetMgr.setAssetIsLoaded(assetId);
		}
		
		public static function getFxNameByKey(fxKey:int):String
		{
			switch (fxKey) 
			{
				case FrameEnums.STAND1:
					return "STAND1";
				case FrameEnums.WALK1:
					return "WALK1";
				case FrameEnums.ATTACK1:
					return "ATTACK1";
				case FrameEnums.ATTACK2:
					return "ATTACK2";
				case FrameEnums.HURT1:
					return "HURT1";
				case FrameEnums.DEAD1:
					return "DEAD1";
				default:
			}
			
			return "STAND1";			
		}
		
		public function getLoader():LoaderCore
		{
			if (_loader == null)
			{
				_loader = new SWFLoader(url, {onComplete: _onComplete});
			}
		
			return _loader;
		}
		
		
		public function toString():String
		{
			
			return "<AssetNPCLoadItem url=" + url + ">";
		}
		
	}

}