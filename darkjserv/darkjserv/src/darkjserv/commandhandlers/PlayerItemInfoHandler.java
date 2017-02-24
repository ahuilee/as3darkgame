package darkjserv.commandhandlers;


import darkjserv.CItemFactory;
import darkjserv.items.CItemEnums;
import darkjserv.items.ICItem;

import darkjserv.net.*;


public class PlayerItemInfoHandler 
{
	
	public Connection conn = null;
	
	public PlayerItemInfoHandler(Connection conn)
	{
		this.conn = conn;
	}
	
	
	private String calcItemName(ICItem item)
	{
		String name = CItemFactory.getInstance().getItemNameByBaseId(item.getItemBaseId());
		
		
		byte itemType = CItemEnums.getItemTypeByBaseId(item.getItemBaseId());
		
		if(itemType == CItemEnums.TYPE_EQUIPMENT)
		{
			
			
			if(item.getEquipmentIsUse())
			{
				name = name + "(¸Ë³Æ¤¤)";
			}
			
			
		}
		
		return name;
	}
	

	public void handle(int ask, DataReader rd) throws Exception
	{
		int itemId = rd.readInt();
		ICItem item = conn.player.itemList.getItemById(itemId);
		
		System.out.println(String.format("ItemInfo %s", item));
		
		AnswerSuccessResponse answer = new AnswerSuccessResponse(ask);
		
		
		
		if(item == null)
		{
			answer.w.writeByte(0x00);
		}else
		{
			answer.w.writeByte(0x01);
			
			String itemName = calcItemName(item);
			
			answer.w.writeBStrUTF(itemName);			
			
			answer.w.writeUInt16(item.getNameColorId());
			answer.w.writeUInt48(item.getItemCount());				
			
			
			byte[] attrBytes = item.getAttrList().makeBytes();
			
			//System.out.println(String.format("attrBytes =%d", attrBytes.length));
			
			answer.w.writeHBytes(attrBytes);
			
			
		}
		
		
		
		conn.putWork(new WriteAnswerWork(answer, conn));
		
	}
	
	
	
}
