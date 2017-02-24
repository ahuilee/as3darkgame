package darkjserv.maps;

import java.awt.Point;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import darkjserv.Factory;
import darkjserv.GameAssetEnums;
import darkjserv.IGameMonster;
import darkjserv.IGameObj;
import darkjserv.Utils;
import darkjserv.monsters.IMonsterBorn;
import darkjserv.monsters.IMonsterDelegate;
import darkjserv.monsters.MonsterCreator;
import darkjserv.monsters.MonsterEnums;
import darkjserv.net.MapChunk;
import darkjserv.npcs.SimpleGroceryMan;

public class WorldMap extends MapDataBase
{
	
	
	
	public WorldMap(int mapId)
	{
		super(mapId);
		
	
		
		initMap();
	}
	
	public void initMap()
	{
		
		assetPks.clear();
		
		assetPks.add(GameAssetEnums.NPC_001);
		assetPks.add(GameAssetEnums.NPC_002);
		//assetPks.add(GameAssetEnums.NPC_003);
		assetPks.add(GameAssetEnums.NPC_031);
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
		
		
		//村莊
		MapChunkHomeGroup centerGroup = new MapChunkHomeGroup();
		
		Point center00 = new Point(2048, 2048);
		
		
		/*
		for(MapChunkGroupChild child : centerGroup.makeChunks())
		{
			//System.out.println(String.format("%s", child));
			
			_getMapChunkByPt.put(new Point(1024 + child.rx, 1024 + child.ry), child.mapChunk);
			
		}*/
		
		
		
		
		//練功點1
		
		MapChunkGroupGround01 g01Group = new MapChunkGroupGround01();
		
		for(MapChunkGroupChild child : g01Group.makeChunks())
		{
			
			
			getMapChunkByPt.put(new Point(2048 + child.rx, 2048 + child.ry), child.mapChunk);
			
		}
		
		/*
		MapChunkGroupBound01 b1Group = new MapChunkGroupBound01();
		
		for(MapChunkGroupChild child : b1Group.makeChunks())
		{
			//System.out.println(String.format("%s", child));
			
			_getMapChunkByPt.put(new Point(2248 + child.rx, 2248 + child.ry), child.mapChunk);
			
		}
		*/
		
		
		centerGamePt = new Point(center00.x * 64 *16, center00.y * 64 *16);
		
		safePts.add(new MapPt(mapId, centerGamePt.x + 64*16, centerGamePt.y + 64 * 16));
		safePts.add(new MapPt(mapId, centerGamePt.x + 64*19, centerGamePt.y + 64 * 16));
	
		
		
		//addGameObj(npc1);
		
		_loadBaseGroup1();
		_loadDragonGroup1();
	
	}
	
	private void _loadBaseGroup1()
	{
		int baseX1 = 2048 * 64 * 16;
		int baseY1 = 2048 * 64 * 16;
		
		
		for(int i=0; i<50; i++)
		{
			
			addMonster(MonsterEnums.MONSTER_001, 1, baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
		}
		
	}
	
	
	private void _loadDragonGroup1()
	{
		int baseX1 = 2045 * 64 * 16;
		int baseY1 = 2050 * 64 * 16;
		
		for(int i=0; i<20; i++)
		{
			addMonster(MonsterEnums.MONSTER_001, 1,  baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
		
		}
		
		for(int i=0; i<20; i++)
		{
			addMonster(MonsterEnums.MONSTER_002, 1, baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
			
		}
		
		for(int i=0; i<20; i++)
		{
			addMonster(MonsterEnums.MONSTER_003, 1, baseX1+Utils.rand.nextInt(64)*64, baseY1 + Utils.rand.nextInt(64) *64);
			
			
		}
		
		
		// boss dragon
		addMonster(MonsterEnums.DRAGON_01, 1, baseX1, baseY1);
		
		
	}
	
	
	Point centerGamePt  = null;
	
	ArrayList<IGameObj> allNpc = null;
	
	
	public void loadNpc(Factory factory)
	{
		allNpc = new ArrayList<IGameObj> ();
		
		SimpleGroceryMan npc1 = new SimpleGroceryMan(factory.makeObjId(), "商人");
		
		
		npc1.x = centerGamePt.x + 64 * 20;
		npc1.y = centerGamePt.y + 64 * 10;
		
		factory.addGameObj(npc1);
	}
	
	
	
	public  int getNumChunkOfX()
	{
		return 4096;
	}
	
	public int getNumChunkOfY()
	{
		return 4096;
	}


}
