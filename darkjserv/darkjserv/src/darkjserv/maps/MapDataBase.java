package darkjserv.maps;

import java.awt.Point;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import darkjserv.Factory;
import darkjserv.IGameMonster;
import darkjserv.MapFactory;
import darkjserv.Utils;
import darkjserv.monsters.IMonsterBorn;
import darkjserv.monsters.IMonsterDelegate;
import darkjserv.monsters.MonsterCreator;
import darkjserv.net.MapChunk;

public class MapDataBase implements IMapData
{
	public int mapId = 0;
	
	
	public HashMap<Point, MapChunk> getMapChunkByPt = null;
	public ArrayList<MapPt> safePts = null;
	public ArrayList<MapPt> enterPts = null;
	public ArrayList<Integer> assetPks = null;
	
	public ArrayList<IMonsterBorn> monsterBorns = null;
	
	public MapDataBase(int mapId)
	{
		this.mapId = mapId;
		safePts = new ArrayList<MapPt>();
		enterPts = new ArrayList<MapPt>();
		getMapChunkByPt = new HashMap<Point, MapChunk>();
		
	
		assetPks = new ArrayList<Integer>();
		
		monsterBorns = new  ArrayList<IMonsterBorn>();
	}
	
	

	class MonsterBorn implements IMonsterBorn
	{
		
		public IMapData mapData;
		public int monsterType;
		public int level;
		public int baseX;
		public int baseY;
		
		public MonsterBorn(IMapData mapData, int monsterType, int level, int baseX, int baseY)
		{
			this.mapData = mapData;
			this.monsterType = monsterType;
			this.level = level;
			this.baseX = baseX;
			this.baseY = baseY;
		}

		public IMonsterDelegate createMonsterDelegate()
		{
			MonsterCreator creator = new MonsterCreator();
			
			
			IMonsterDelegate delegate = creator.makeMonsterByType(monsterType, level);
			
			IGameMonster iobj = delegate.getMonster();
			
			int x1 = baseX;
			int y1 = baseY;
			
			iobj.setMapId(mapData.getMapId());
			iobj.setX(x1);
			iobj.setY(y1);
			
			
			
			int w2 = 2048;
			int h2 = 2048;
			int x2 = iobj.getX() - w2/2;
			int y2 = iobj.getY() - h2/2;
			
			
			delegate.setMoveBound(x2, y2, w2, h2);
			
			return delegate;
		}
		
	}
	
	public void addMonster(int type, int level, int baseX, int baseY)
	{
		
		MonsterBorn born = new MonsterBorn(this, type, level, baseX, baseY);
		
		monsterBorns.add(born);
		
	}
	

	public int getMapId() {
		// TODO Auto-generated method stub
		return mapId;
	}

	public int getNumChunkOfX() 
	{
		// TODO Auto-generated method stub
		return 16;
	}

	public int getNumChunkOfY() {
		// TODO Auto-generated method stub
		return 16;
	}

	public MapChunk getChunkByPt(int x, int y) {
		// TODO Auto-generated method stub
		Point key = new Point(x, y);
		return getMapChunkByPt.containsKey(key) ? getMapChunkByPt.get(key) : null;
		
	}
	
	private MapChunk _defaultChunk = new MapChunkDefault();
	
	public MapChunk getDefaultChunk() {
		// TODO Auto-generated method stub
		return _defaultChunk;
	}
	
	public List<MapPt> getEnterPts() {
		// TODO Auto-generated method stub
		return enterPts;
	}

	public MapPt randEnterPt() 
	{
		List<MapPt> pts = getEnterPts();	
		
		if(pts.size() == 0) return null;
		 
		return pts.get(Utils.rand.nextInt(pts.size()));
	}

	public List<MapPt> getSafePts() {
		// TODO Auto-generated method stub
		return safePts;
	}

	public MapPt randSafePt() 
	{
		List<MapPt> safePts = getSafePts();	
		
		if(safePts.size() == 0) return null;
		 
		return safePts.get(Utils.rand.nextInt(safePts.size()));
	}

	public void loadNpc(MapFactory factory)
	{
		// TODO Auto-generated method stub
		
	}


	public List<Integer> getAssetPks() {
		// TODO Auto-generated method stub
		return assetPks;
	}

	public List<IMonsterBorn> getAllMonsterBorns() {
		// TODO Auto-generated method stub
		return monsterBorns;
	}

	

}
