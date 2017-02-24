package darkjserv.maps;

import java.awt.Point;
import java.util.ArrayList;
import java.util.List;

import darkjserv.GameAssetEnums;
import darkjserv.IGameObj;
import darkjserv.MapFactory;
import darkjserv.Utils;
import darkjserv.monsters.MonsterEnums;

public class Map02 extends MapDataBase
{
	
	
	
	public Map02(int mapId)
	{
		super(mapId);
		
		initMap();
	}
	
	public void initMap()
	{
		enterPts.clear();
		assetPks.clear();
		
		assetPks = new ArrayList<Integer>();
		assetPks.add(GameAssetEnums.NPC_051);
		assetPks.add(GameAssetEnums.NPC_052);
		assetPks.add(GameAssetEnums.NPC_053);
		assetPks.add(GameAssetEnums.NPC_054);
		
		int i = 0;
		//map left top
		getMapChunkByPt.put(new Point(0, 0), new MapChunkLeft00());
		
		//map top
		for(i = 0; i<getNumChunkOfX(); i++)
		{
			getMapChunkByPt.put(new Point(1+i, 0), new MapChunkTopSide1());
		}
		
		//left side
		for(i = 0; i<getNumChunkOfY(); i++)
		{
			getMapChunkByPt.put(new Point(0, 1+i), new MapChunkLeftSide1());
		}
		
		
		Point center00 = new Point(getNumChunkOfX() / 2 , getNumChunkOfY() / 2);	
		
		
		centerGamePt = new Point(center00.x * 64 *16, center00.y * 64 *16);
		

		
		enterPts.add(new MapPt(mapId, centerGamePt.x + 64*16, centerGamePt.y + 64 * 16));
		enterPts.add(new MapPt(mapId, centerGamePt.x + 64*19, centerGamePt.y + 64 * 16));
	
		
		
		//addGameObj(npc1);
		loadMonsters1();
		
		
	
	}
	
	void loadMonsters1()
	{
		int baseX1 = (getNumChunkOfX() / 2 - 2) * 64 * 16;
		int baseY1 = (getNumChunkOfX() / 2 - 2) * 64 * 16;
		
		for(int i=0; i<50; i++)
		{
		
			addMonster(MonsterEnums.MONSTER_051, 1, baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
			
			addMonster(MonsterEnums.MONSTER_052, 1,  baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
			
			addMonster(MonsterEnums.MONSTER_053, 1, baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
			addMonster(MonsterEnums.MONSTER_054, 1, baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
		}
		
	}
	
	Point centerGamePt  = null;
	
	ArrayList<IGameObj> allNpc = null;
	
	
	public void loadNpc(MapFactory factory)
	{
		allNpc = new ArrayList<IGameObj> ();

	}
	
	public List<MapPt> getSafePts() {
		// TODO Auto-generated method stub
		return MapFactory.getInstance().getMapDataById(1).getSafePts();
	}
	
	
	public  int getNumChunkOfX()
	{
		return 64;
	}
	
	public  int getNumChunkOfY()
	{
		return 64;
	}


}
