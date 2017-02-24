package darkjserv;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class GameAssetFactory 
{
	
	
	private static GameAssetFactory _instance = null;
	public static GameAssetFactory getInstance() 
	{
		
		if(_instance == null)
		{
			_instance = new GameAssetFactory();
		}
		
		return _instance;		
	}
	
	
	
	private HashMap<Integer, IAssetLoadItem> _items = null;
	
	public GameAssetFactory()
	{
		load();
		
		
		
	}
	
	public IAssetLoadItem getAssetById(int id)
	{
		return _items.getOrDefault(id, null);
	}
	
	public void load()
	{
		_items = new HashMap<Integer, IAssetLoadItem>();
		List<IAssetLoadItem> items = _getItems();
		
		for(IAssetLoadItem item : items)
		{
			_items.put(item.getAssetId(), item);
		}
	}
	
	private List<IAssetLoadItem> _getItems()
	{
		ArrayList<IAssetLoadItem> items = new ArrayList<IAssetLoadItem>();
		
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_001, "assets/npc001.swf"));
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_002, "assets/npc002.swf"));
		//items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_003, "assets/npc003.swf"));
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_031, "assets/npc031.swf"));
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_051, "assets/npc051.swf"));
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_052, "assets/npc052.swf"));
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_053, "assets/npc053.swf"));
		items.add(new AssetNPCLoadItem(GameAssetEnums.NPC_054, "assets/npc054.swf"));
		return items;		
	}
	
	

}
