package darkjserv.monsters;

import java.util.List;

import darkjserv.items.ICItem;

public interface IMonsterDropItemDelegate 
{
	List<ICItem> makeDropItems();
}
