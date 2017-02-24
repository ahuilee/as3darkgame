package dark.netcallbacks 
{
	
	import dark.CItemInfoFactory;
	import flash.utils.ByteArray;

	import dark.models.*;
	import dark.itemattrs.*;
	import dark.net.DataByteArray;
	import dark.net.ICommandCallback;
	import dark.net.Packet;
	import dark.ui.DisplayItemInfoSprite;
	import dark.ui.ItemListView;
	import dark.ui.ItemSprite;
	
	
	public class PlayerItemInfoCallback2 implements ICommandCallback
	{
		
		public var displaySprite:DisplayItemInfoSprite = null;
		public var itemId:int = 0;
		public var factory:CItemInfoFactory = null;
		
		public function PlayerItemInfoCallback2(displaySprite:DisplayItemInfoSprite, itemId:int, factory:CItemInfoFactory) 
		{
			this.displaySprite = displaySprite;
			this.itemId = itemId; 
		
			this.factory = factory;
		}
		
		public static function getColorById(id:int):uint
		{
			
			switch (id) 
			{
				case 0:
					return 0xffffff;
					
				case 1:
					return 0x999999;
					
				case 2:
					return 0xff9900;
					
				case 3:
					return 0x00ccff;
					
				case 10:
					return 0xff0000;
				case 11:
					return 0x00ff00;
				case 12:
					return 0x0099ff;
			}
			
			
			return 0xffffff;
		}
		
		
		public function doCallback(info:CItemInfo):void
		{
			displaySprite.setItemInfo(info);			
			
			factory.onItemInfoCallback(itemId, info);
		}
		
		
		public static const TERMINAL:int = 0xffff;
		
		
		public function unpackAttrList(attrBytes:DataByteArray ):Array
		{
			var attrs:Array = [];	
			
			attrBytes.position = 0;
				
				for (var i:int = 0; i < 256; i++)
				{
					
					var attrType:int = attrBytes.readUnsignedShort();
					
				
	
					if (attrType == TERMINAL) break;
					
					
					switch (attrType) 
					{
						case ItemAttrTypes.AT_ATTACK_DAMAGE:
							attrs.push(new CItemAttackDamageAttr().loadData(attrBytes));
							break;
						
						case ItemAttrTypes.AT_MAGIC_ATTACK_DAMAGE:
							attrs.push(new CItemMagicAttackDamageAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_DEFENSE:
							attrs.push(new CItemDefenseAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_MAGIC_DEFENSE:
							attrs.push(new CItemMagicDefenseAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_LUCKY:
							attrs.push(new CItemAddLuckyAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_ATTACK_DAMAGE:
							attrs.push(new CItemAddAttackDamageAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_DEFENSE:
							attrs.push(new CItemAddDefenseAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_MAGIC_DAMAGE:
							attrs.push(new CItemAddMagicDamageAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_COLD_DAMAGE:
							attrs.push(new CItemAddColdDamageAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_FIRE_DAMAGE:
							attrs.push(new CItemAddFireDamageAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_LIGHTNING_DAMAGE:
							attrs.push(new CItemAddLightningDamageAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_POISON_DAMAGE:
							attrs.push(new CItemAddPoisonDamageAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_MAXHP:
							attrs.push(new CItemAddMaxHpAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_MAXMP:
							attrs.push(new CItemAddMaxMpAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_STR:
							attrs.push(new CItemAddStrAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_ADD_INT:							
							attrs.push(new CItemAddIntAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_DEX:
							attrs.push(new CItemAddDexAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_CON:
							attrs.push(new CItemAddConAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_SPI:
							attrs.push(new CItemAddSpiAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_ATTACK_SPEED:
							attrs.push(new CItemAddAttackSpeedAttr().loadData(attrBytes));
							break;	
							
						case ItemAttrTypes.AT_ADD_MOVE_SPEED:
							attrs.push(new CItemAddMoveSpeedAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_STOLEN_HP:
							attrs.push(new CItemStolenHpAttr().loadData(attrBytes));
							break;
							
						case ItemAttrTypes.AT_STOLEN_MP:
							attrs.push(new CItemStolenMpAttr().loadData(attrBytes));
							break;

						default:
					}
					
				}
			
			return attrs;
		}
		
		public function success(ask:int, packet:Packet):void
		{
			
			var rd:DataByteArray = packet.body;
			
			var state:int = rd.readByte();
			
			if (state == 0x01)
			{
				var info:CItemInfo = new CItemInfo();
				info.name =  rd.readBStr();
				info.color = getColorById(rd.readUnsignedShort());
				info.count =  rd.readUInt48();			
				
			
				
				var attrByteLen:int = rd.readUnsignedShort();
				
				var attrBytes:DataByteArray = new DataByteArray();
				
				rd.readBytes(attrBytes, 0, attrByteLen);
				
				trace("PlayerItemInfoCallback success", ask, info, "attrByteLen", attrByteLen);

				info.attrs = unpackAttrList(attrBytes);
				
				doCallback(info);
				
			}
			
			
		}
		
		public function errback(reason:String):void
		{
			
		}
		
		
		
	}

}