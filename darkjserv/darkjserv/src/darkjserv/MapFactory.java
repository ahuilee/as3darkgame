package darkjserv;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import darkjserv.maps.*;

public class MapFactory 
{
	
	private static MapFactory _instance = null;
	public static MapFactory getInstance()
	{
		if(_instance == null)
		{
			_instance = new MapFactory();
		}
		
		return _instance;
	}
	
	
	public void load()
	{
		loadMapData();
		loadNPC();
	}
	

	private HashMap<Integer, IMapData> _getMapDataById = new HashMap<Integer, IMapData>();
	
	public void loadMapData()
	{
		ArrayList<IMapData> mapDataList = new ArrayList<IMapData>();
		
		mapDataList.add(new WorldMap(1));
		mapDataList.add(new Map02(2));
		mapDataList.add(new Map03(3));
		
		for(IMapData map : mapDataList)
		{
			_getMapDataById.put(map.getMapId(), map);
		}
	}
	
	public void loadNPC()
	{
		
		for(Entry<Integer, IMapData> entry : _getMapDataById.entrySet())
		{
			IMapData mapData = entry.getValue();
			
			mapData.loadNpc(this);
		}
		
	}
	
	public IMapData getMapDataById(int mapId)
	{
		IMapData mapData = _getMapDataById.getOrDefault(mapId, null);
		
		if(mapData == null)
		{
			 mapData = _getMapDataById.get(1);
		}
		
		return mapData;
	}
	
	public List<IMapData> getAllMapData()
	{
		
		return new ArrayList<IMapData>( _getMapDataById.values());		
	}
	
	

}
