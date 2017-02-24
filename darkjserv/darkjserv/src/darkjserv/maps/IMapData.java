package darkjserv.maps;


import java.util.List;

import darkjserv.MapFactory;
import darkjserv.monsters.IMonsterBorn;
import darkjserv.net.MapChunk;

public interface IMapData
{
	int getMapId();
	int getNumChunkOfX();
	int getNumChunkOfY();
	
	MapChunk getChunkByPt(int x, int y);
	
	MapChunk getDefaultChunk();
	
	List<MapPt> getEnterPts();
	List<MapPt> getSafePts();
	
	MapPt randEnterPt();
	MapPt randSafePt();
	
	void loadNpc(MapFactory factory);
	
	List<Integer> getAssetPks();
	
	List<IMonsterBorn> getAllMonsterBorns();
	
}
