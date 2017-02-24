package dark 
{
	import caurina.transitions.properties.ColorShortcuts;
	import dark.display.IBitmapAnimationArray;
	import dark.display.DisplayDelegateFrameArrayData;
	import dark.display.SceneCItemDisplayData;
	import dark.display.SceneCItemDisplayDataList;
	import dark.display.SkillEffectFrameArrayData;
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ahui
	 */
	public class AppDelegate 
	{
		
		public var manager:Manager = null;
		public var debug:IDebugDelegate = null;
		public var dataDelegate:IGameDataDelegate = null;
		public var workQueue:Array = [];
		
		public function AppDelegate(dataDelegate:IGameDataDelegate, debug:IDebugDelegate) 
		{
			this.dataDelegate = dataDelegate;
			this.debug = debug;
			manager = new Manager();
		}
		
		
			
		public function runWorkQueue():void
		{
			var work:IWork = null;
			
			
			var weighted:int = 0;
			
			for (var i:int = 0; i < workQueue.length; i++)
			{
				if (weighted > 100) break;
				work = workQueue.shift();
			
				//if (work == null) break;
			
				//trace("get work", work);
				
				try {
					weighted += work.run();
				
				} catch (err:Error)
				{
					work.except(err);
				}
			
			
			}
			
		}
		
		public function putWork(work:IWork):void
		{
			workQueue.push(work);
		}
		
		
		public function makeTIKeyByTemplateId(templateId):String
		{
			
			var idx:int = templateId - GameTemplateEnums.TI_INDEX_START;
			
			
			if (idx < 1)
			{
				idx = 1;
			}
			
			var keyName:String = idx.toString();
				
			if (idx < 1000)
			{
				keyName = "0" + keyName;
			}
				
			if (idx < 100)
			{
				keyName = "0" + keyName;
			}				
				
			if (idx < 10)
			{
				keyName = "0" + keyName;
			}
				
			keyName = "TI_" +keyName;
				
			return keyName;
			
			
					
		}
		
		
		
		private var _getSkillEffectFrameArrayDataByKey:Dictionary = new Dictionary();
		public function getSkillEffectFrameArrayData(key:int):SkillEffectFrameArrayData
		{
			return _getSkillEffectFrameArrayDataByKey[key];
		}
		
		public function setSkillEffectFrameArrayData(key:int, frames:SkillEffectFrameArrayData):void
		{
			_getSkillEffectFrameArrayDataByKey[key] = frames;
		}

		
		private var _getSkillEffectFramsArray:Dictionary = new Dictionary();
		public function getSkillEffectFramsArray(key:String):Array
		{
			return _getSkillEffectFramsArray[key];
		}
		
		public function setSkillEffectFramsArray(key:String, array:Array):void
		{
			_getSkillEffectFramsArray[key] = array;
		}
		
		
		private var _getFrameArrayDict:Dictionary = new Dictionary();
		
		public function setFrameArray(key:String, frameArray:IBitmapAnimationArray):void
		{
			//trace("setMapTail", id, bitmapData);
			_getFrameArrayDict[key] = frameArray;
		}
		
		public function getFrameArray(key:String):IBitmapAnimationArray
		{
			return _getFrameArrayDict[key];
		}
		
		
		
		
		
		
		private var _getFrameArrayDataByKey:Dictionary = new Dictionary();
		
		public function setFrameArrayData(key:String, frameArrayData:DisplayDelegateFrameArrayData):void
		{
			//trace("setMapTail", id, bitmapData);
			_getFrameArrayDataByKey[key] = frameArrayData;
		}
		
		public function getFrameArrayData(key:String):DisplayDelegateFrameArrayData
		{
			return _getFrameArrayDataByKey[key];
		}
		
		
		
		
		private var _uiBDKlassDict:Dictionary = new Dictionary();
		
		public function setUIBDKlass(id:int, klass:Class):void
		{
			//trace("setMapTail", id, bitmapData);
			_uiBDKlassDict[id] = klass;
		}
		
		public function getUIBDKlass(id:int):Class
		{
			return _uiBDKlassDict[id];
		}
		
		private var _uiBdDict:Dictionary = new Dictionary();
		
		public function setUIBd(key:String, bitmapData:BitmapData):void
		{
			//trace("setMapTail", id, bitmapData);
			_uiBdDict[key] = bitmapData;
		}
		
		public function getUIBd(key:String):BitmapData
		{
			return _uiBdDict[key];
		}
		
		
		private var _setTemplateBdDict:Dictionary = new Dictionary();
		
		public function setTemplateBd(id:int, bitmapData:BitmapData):void
		{
			//trace("setMapTail", id, bitmapData);
			_setTemplateBdDict[id] = bitmapData;
		}
		
		public function getTemplateBd(id:int):BitmapData
		{
			return _setTemplateBdDict[id];
		}
		
		
		private var _getSceneCItemDisplayDataByTemplateId:Dictionary = new Dictionary();
		
		public function setSceneCItemDisplayDataList(templateId:int, displayData:SceneCItemDisplayDataList):void
		{
			//trace("setMapTail", id, bitmapData);
			_getSceneCItemDisplayDataByTemplateId[templateId] = displayData;
		}
		
		public function getSceneCItemDisplayDataList(templateId:int):SceneCItemDisplayDataList
		{
			return _getSceneCItemDisplayDataByTemplateId[templateId];
		}
		
		
		
		private var _getMapTileById:Dictionary = new Dictionary();
		
		public function setMapTile(id:int, bitmapData:BitmapData):void
		{
			//trace("setMapTail", id, bitmapData);
			_getMapTileById[id] = bitmapData;
		}
		
		public function getMapTile(id:int):BitmapData
		{
			var bd:BitmapData = _getMapTileById[id];
			
			//trace("getMapTile", id, bd);
			
			if (bd == null) 
			{
				bd = _getMapTileById[0];
			}
			
			return bd;
		}
		
		
		private var _soundDict:Dictionary = new Dictionary();
		
		public function setSound(id:int, soundClass:Class):void
		{
			_soundDict[id] = soundClass;
		}
		
		public function getSoundClass(id:int):Class
		{
			return _soundDict[id];
		}
		
		public function playSound(id:int, volume:Number):void
		{
			var SoundKlass:Class = _soundDict[id];
			
			var sound:Sound = new SoundKlass() as Sound;
			var transform:SoundTransform = new SoundTransform(volume, 0);
			sound.play(0, 0, transform);
			
			
			trace("playSound", id, "volume", volume);			
			
		}
		
		private var _musicDict:Dictionary = new Dictionary();
		
		public function setMusic(id:int, soundClass:Class):void
		{
			_musicDict[id] = soundClass;
		}
		
		public function playMusic(id:int, volume:Number):void
		{
			var SoundKlass:Class = _musicDict[id] ;
			
			var sound:Sound = new SoundKlass() as Sound;
			var transform:SoundTransform = new SoundTransform(volume, 0);
			sound.play(0, 0, transform);
			
			
			trace("playMusic", id);			
			
		}
		
		private var _getClassByKey:Dictionary = new Dictionary();
		public function getClassByKey(key:String):Class
		{
			return _getClassByKey[key];
		}
		
		public function setClassByKey(key:String, klass:Class):void 
		{
			_getClassByKey[key] = klass;
		}
		
		private var _getIconBdByKey:Dictionary = new Dictionary();
		public function getIconBdByKey(key:String):BitmapData
		{
			return _getIconBdByKey[key];
		}
		
		public function setIconBdByKey(key:String, bitmapData:BitmapData):void 
		{
			_getIconBdByKey[key] = bitmapData;
		}
		
		
	}

}