package dark.loaders 
{
	import com.greensock.loading.SWFLoader;
	import dark.AppDelegate;
	import dark.display.BitmapAnimationArray;
	import dark.display.SkillEffectFrameArrayData;
	
	import dark.SkillEnums;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class LoaderSkillEffects 
	{
		
		public var loader:SWFLoader = null;
		public var app:AppDelegate = null;
		
		public function LoaderSkillEffects(loader:SWFLoader, app:AppDelegate) 
		{
			this.loader = loader;
			this.app = app;
		}
		
		public function load():void
		{
			loadSkill001();
			loadSkill002();
			loadSkill003();
			loadSkill004();
			loadSkill005();
			loadSkill006();
			loadSkill007();
			loadSkill008();
			loadSkill009();
			loadSkill010();
			loadSkill011();
			loadSkill012();
			loadSkill013();
			loadSkill014();
			loadSkill015();
			loadSkill016();
			
			_loadCrack01Frames();
			_loadThunder01Frames();
		}
		
		
		public function loadSkill016():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_016_001",
				"BD_SE_016_002",
				"BD_SE_016_003",
				"BD_SE_016_004",
				"BD_SE_016_005",
				"BD_SE_016_006",				
			]);
			
			frames.y2 = -240;
			frames.x2 = -245;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 500;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 15, frames);
			
			
		}
		
		public function loadSkill015():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_015_001",
				"BD_SE_015_002",
				"BD_SE_015_003",
				"BD_SE_015_004",
				"BD_SE_015_005",
				"BD_SE_015_006",
				"BD_SE_015_007",
				"BD_SE_015_008",
				"BD_SE_015_009",
				"BD_SE_015_010",
				"BD_SE_015_011",				
				"BD_SE_015_012",				
				"BD_SE_015_013",				
				"BD_SE_015_014",				
				"BD_SE_015_015",				
				"BD_SE_015_016",				
			]);
			
			frames.y2 = -280;
			frames.x2 = -240;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 800;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 14, frames);
			
			
		}
		
		
		public function loadSkill014():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_014_001",
				"BD_SE_014_002",
				"BD_SE_014_003",
				"BD_SE_014_004",
				"BD_SE_014_005",
				"BD_SE_014_006",
				"BD_SE_014_007",
				"BD_SE_014_008",
				"BD_SE_014_009",
				"BD_SE_014_010",
				"BD_SE_014_011",
				"BD_SE_014_012",
				"BD_SE_014_013",
				"BD_SE_014_014",
				"BD_SE_014_015",
				
			]);
			
			frames.y2 = -70;
			frames.x2 = -80;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 500;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 13, frames);
			
			
		}
		
		public function loadSkill013():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_013_001",
				"BD_SE_013_002",
				"BD_SE_013_003",
				"BD_SE_013_004",
				"BD_SE_013_005",
				"BD_SE_013_006",
				"BD_SE_013_007",
				"BD_SE_013_008",
				"BD_SE_013_009",
				"BD_SE_013_010",
				"BD_SE_013_011",
				"BD_SE_013_012",
				"BD_SE_013_013",
				"BD_SE_013_014",
				"BD_SE_013_015",
				
			]);
			
			frames.y2 = -230;
			frames.x2 = -260;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 500;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 12, frames);
			
			
		}
		
		public function loadSkill012():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_012_001",
				"BD_SE_012_002",
				"BD_SE_012_003",
				"BD_SE_012_004",
				"BD_SE_012_005",
				"BD_SE_012_006",
				"BD_SE_012_007",
				"BD_SE_012_008",
				"BD_SE_012_009",
				"BD_SE_012_010",
				"BD_SE_012_011",
				"BD_SE_012_012",
				"BD_SE_012_013",
				
			]);
			
			frames.y2 = -190;
			frames.x2 = -195;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 500;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 11, frames);
			
			
		}
		
		public function loadSkill011():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_011_001",
				"BD_SE_011_002",
				"BD_SE_011_003",
				"BD_SE_011_004",
				"BD_SE_011_005",
				"BD_SE_011_006",
				"BD_SE_011_007",
				"BD_SE_011_008",
				"BD_SE_011_009",
				"BD_SE_011_010",
				"BD_SE_011_011",
				"BD_SE_011_012",
				"BD_SE_011_013",

				
			]);
			
			frames.y2 = -240;
			frames.x2 = -160;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 600;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 10, frames);
			
			
		}
		
		public function loadSkill010():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_010_001",
				"BD_SE_010_002",
				"BD_SE_010_003",
				"BD_SE_010_004",
				"BD_SE_010_005",
				"BD_SE_010_006",
				"BD_SE_010_007",
				"BD_SE_010_008",
				"BD_SE_010_009",
				"BD_SE_010_010",
				"BD_SE_010_011",
				"BD_SE_010_012",
				"BD_SE_010_013",
				"BD_SE_010_014",
				"BD_SE_010_015",
				"BD_SE_010_016",
				
			]);
			
			frames.y2 = -320;
			frames.x2 = -150;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 800;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 9, frames);
			
			
		}
		
		public function loadSkill009():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_009_001",
				"BD_SE_009_002",
				"BD_SE_009_003",
				"BD_SE_009_004",
				"BD_SE_009_005",
				"BD_SE_009_006",
				"BD_SE_009_007",
				"BD_SE_009_008",
				"BD_SE_009_009",
				"BD_SE_009_010",
				"BD_SE_009_011",
				"BD_SE_009_012",
				"BD_SE_009_013",
				"BD_SE_009_014",
				"BD_SE_009_015",
				"BD_SE_009_016",
			]);
			
			frames.y2 = -420;
			frames.x2 = -175;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 800;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 8, frames);
			
		
		}
		
		public function loadSkill008():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_008_001",
				"BD_SE_008_002",
				"BD_SE_008_003",
				"BD_SE_008_004",
				"BD_SE_008_005",
				"BD_SE_008_006",
				"BD_SE_008_007",
				"BD_SE_008_008",
				"BD_SE_008_009",
				
			]);
			
			frames.y2 = -240;
			frames.x2 = -175;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 500;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 7, frames);
			
			trace("loadSkill008", frames);
		}
		
		public function loadSkill007():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_007_001",
				"BD_SE_007_002",
				"BD_SE_007_003",
				"BD_SE_007_004",
				"BD_SE_007_005",
				"BD_SE_007_006",
				"BD_SE_007_007",
				"BD_SE_007_008",
				"BD_SE_007_009",
				"BD_SE_007_010",
				"BD_SE_007_011",
				"BD_SE_007_012",					
			]);
			
			frames.y2 = -256;
			frames.x2 = -256;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 1000;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 6, frames);
		}
		
		public function loadSkill006():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_006_001",
				"BD_SE_006_002",
				"BD_SE_006_003",
				"BD_SE_006_004",
				"BD_SE_006_005",
				"BD_SE_006_006",
				"BD_SE_006_007",
				"BD_SE_006_008",
				"BD_SE_006_009",
				"BD_SE_006_010",
				"BD_SE_006_011",
				"BD_SE_006_012",
				"BD_SE_006_013",
				"BD_SE_006_014",
				"BD_SE_006_015",				
				"BD_SE_006_016",				
				"BD_SE_006_017",				
				"BD_SE_006_018",				
			]);
			
			frames.y2 = -100;
			frames.x2 = -80;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 1000;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 5, frames);
		}
		
		public function loadSkill005():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_005_001",
				"BD_SE_005_002",
				"BD_SE_005_003",
				"BD_SE_005_004",
				"BD_SE_005_005",
				"BD_SE_005_006",
				"BD_SE_005_007",
				"BD_SE_005_008",
				"BD_SE_005_009",
				"BD_SE_005_010",
				"BD_SE_005_011",
				"BD_SE_005_012",
				"BD_SE_005_013",				
			]);
			
			frames.y2 = -220;
			frames.x2 = -220;
			frames.scaleX = 1.3;
			frames.scaleY = 1.3;
			frames.duration = 800;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_IDXSTART + 4, frames);
		}
		
		public function loadSkill004():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_004_001",
				"BD_SE_004_002",
				"BD_SE_004_003",
				"BD_SE_004_004",
				"BD_SE_004_005",
				"BD_SE_004_006",
				"BD_SE_004_007",
				"BD_SE_004_008",
				"BD_SE_004_009",
				"BD_SE_004_010",
				"BD_SE_004_011",
				"BD_SE_004_012",
				"BD_SE_004_013",
				"BD_SE_004_014",
				"BD_SE_004_015",
				"BD_SE_004_016",
				"BD_SE_004_017",
				"BD_SE_004_018",
				"BD_SE_004_019",
				"BD_SE_004_020",
				"BD_SE_004_021",
				"BD_SE_004_022",
				"BD_SE_004_023",
				
			]);
			
			frames.y2 = -300;
			frames.x2 = -240;
			frames.scaleX = 2;
			frames.scaleY = 2;			
			frames.duration = 2000;
			app.setSkillEffectFrameArrayData(SkillEnums.SE_004, frames);
		}
		
		public function loadSkill003():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_003_001",
				"BD_SE_003_002",
				"BD_SE_003_003",
				"BD_SE_003_004",
				"BD_SE_003_005",
				"BD_SE_003_006",
				"BD_SE_003_007",
				"BD_SE_003_008",
				"BD_SE_003_009",
				"BD_SE_003_010",
				"BD_SE_003_011",
				"BD_SE_003_012",
				"BD_SE_003_013",
				"BD_SE_003_014",
				"BD_SE_003_015",
				"BD_SE_003_016",
				"BD_SE_003_017",
				"BD_SE_003_018",
				"BD_SE_003_019",
				"BD_SE_003_020",
				"BD_SE_003_021",
				"BD_SE_003_022",
				"BD_SE_003_023",
				
			]);
			
			frames.y2 = -300;
			frames.x2 = -280;
			frames.scaleX = 2;
			frames.scaleY = 2;
			frames.duration = 2000;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_003, frames);
		}
		
		public function loadSkill001():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_001_001",
				"BD_SE_001_002",
				"BD_SE_001_003",
				"BD_SE_001_004",
				"BD_SE_001_005",
				"BD_SE_001_006",
				"BD_SE_001_007",
				"BD_SE_001_008",
				"BD_SE_001_009",
				"BD_SE_001_010",
				"BD_SE_001_011",
				"BD_SE_001_012",
				"BD_SE_001_013",
				"BD_SE_001_014",
				"BD_SE_001_015",
				"BD_SE_001_016",
				"BD_SE_001_017",
				"BD_SE_001_018",
				"BD_SE_001_019",
				"BD_SE_001_020",
				"BD_SE_001_021",
				"BD_SE_001_022",
				"BD_SE_001_023",
				"BD_SE_001_024",
				"BD_SE_001_025",
				"BD_SE_001_026",
				"BD_SE_001_027",
				"BD_SE_001_028",
				"BD_SE_001_029",
				"BD_SE_001_030",
				"BD_SE_001_031",
				"BD_SE_001_032",
				"BD_SE_001_033",
			]);
			
			frames.y2 = -105;
			frames.x2 = -90;
			frames.scaleX = 2;
			frames.scaleY = 2;
			frames.duration = 1000;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_001, frames);
		}
		
		
		public function loadSkill002():void
		{
			var frames:SkillEffectFrameArrayData = makeSkillFrameArrayData([
				"BD_SE_002_001",
				"BD_SE_002_002",
				"BD_SE_002_003",
				"BD_SE_002_004",
				"BD_SE_002_005",
				"BD_SE_002_006",
				"BD_SE_002_007",
				"BD_SE_002_008",
				"BD_SE_002_009",
				"BD_SE_002_010",
				"BD_SE_002_011",
				"BD_SE_002_012",
				"BD_SE_002_013",
				"BD_SE_002_014",
				"BD_SE_002_015",
				"BD_SE_002_016",
				"BD_SE_002_017",
				"BD_SE_002_018",
				"BD_SE_002_019",
				"BD_SE_002_020",
				"BD_SE_002_021",
		
			]);
			
			frames.y2 = -135;
			frames.x2 = -90;
			frames.scaleX = 1;
			frames.scaleY = 1;
			frames.duration = 2000;
			
			app.setSkillEffectFrameArrayData(SkillEnums.SE_002, frames);
		}
		
		
		public function makeSkillFrameArrayData(names:Array):SkillEffectFrameArrayData
		{
			var frames:SkillEffectFrameArrayData = new SkillEffectFrameArrayData();
			
			var bds:Array = new Array();
			
			
			for (var i:int = 0; i < names.length; i++)
			{
				var ClassType:Class = loader.getClass(names[i]);
				
				var bd:BitmapData = new ClassType();
				
				
				bds.push(bd);
				
			}
			
			frames.frames = bds;
			
			return frames;
		}
		
		
		private function _loadThunder01Frames()
		{
			var frames:Array = new Array();
			
			var Bd_Class:Class = loader.getClass("BD_SE_Thunder01");
			
			var src:BitmapData = new Bd_Class();
			var clip:BitmapData = new BitmapData(256, 384, true, 0x00);
			
			for (var i:int = 0 ; i < 7; i++)
			{
				clip.fillRect(clip.rect, 0x00);
				clip.copyPixels(src, new Rectangle(256 * i, 0, clip.width, clip.height), new Point(0, 0), null, null, true);
				
				frames.push(clip.clone());
			}
				
			
			app.setSkillEffectFramsArray("SE_Thunder01", frames);
		}
		
		private function _loadCrack01Frames()
		{
			var frames:Array = new Array();
			
			var Bd_Class:Class = loader.getClass("BD_SE_Crack01");
			
			var src:BitmapData = new Bd_Class();
			var clip:BitmapData = new BitmapData(256, 256, true, 0x00);
			
			for (var i:int = 0 ; i < 7; i++)
			{
				clip.fillRect(clip.rect, 0x00);
				clip.copyPixels(src, new Rectangle(256 * i, 0, clip.width, clip.height), new Point(0, 0), null, null, true);
				
				frames.push(clip.clone());
			}
				
			
			app.setSkillEffectFramsArray("SE_Crack01", frames);
		}
		
		
	}

}