package dark.net 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ahui
	 */
	public class DataByteArray extends ByteArray
	{
		
		public function DataByteArray() 
		{
			super();
		}
		
		public function readObjKey():GameObjectKey
		{
			var key1:int = readInt();
			var key2:int = readInt();
			var key:GameObjectKey = new GameObjectKey(key1, key2);
			
			return key;
		}
		
		public function writeObjKey(objKey:GameObjectKey):void
		{
			writeInt(objKey.key1);
			writeInt(objKey.key2);
		}
		
		public function writeHStrUTF(text:String):void
		{
						
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(text);
				
			writeUInt16(bytes.length);
			writeBytes(bytes, 0, bytes.length);
			
			
		}
		
		public function writeUInt16(value:int):void
		{
			writeByte((value & 0xff00) >> 8);
			writeByte((value & 0x00ff));
		}
		
		
		public function readHStr():String
		{
			var nameNumBytes:int = ((readUnsignedByte() << 8) & 0xff00) | readUnsignedByte();				
			var nameBytes:ByteArray = new ByteArray();
				
			readBytes(nameBytes, 0, nameNumBytes);
			
			return new String(nameBytes);	
		}
		
		public function writeBStr(text:String):void
		{
				
			var nameBytes:ByteArray = new ByteArray();
			nameBytes.writeUTFBytes(text);
			
			var len:int = nameBytes.length & 0xff;
			
			writeByte(len);			
			writeBytes(nameBytes, 0, len);			
			
		}
		
		public function readBStr():String
		{
			var nameNumBytes:int = readUnsignedByte();				
			var nameBytes:ByteArray = new ByteArray();
				
			readBytes(nameBytes, 0, nameNumBytes);
			
			return new String(nameBytes);	
		}
		
		public function readIntN():String
		{
			var countN:int = readByte();
				
			switch (countN) 
			{
				case 0x01:
					return readByte().toString();						
						
				case 0x02:
					return readShort().toString();				
						
				case 0x04:
					return readInt().toString();						
						
				default:
			}
				
			return "";
		}
		
		
		public function writeInt24(value:int):void
		{
			writeByte((value & 0xff0000) >> 16);
			writeByte((value & 0x00ff00) >> 8);
			writeByte(value & 0x0000ff);
		}
		
		public function readUInt48():Number
		{
			return ((readUnsignedByte() << 40 ) & 0xff0000000000) 
				 | ((readUnsignedByte() << 32 ) & 0x00ff00000000) 
			     | ((readUnsignedByte() << 24 ) & 0x0000ff000000) 
			     | ((readUnsignedByte() << 16 ) & 0x000000ff0000) 
			     | ((readUnsignedByte() << 8 )  & 0x00000000ff00)
			     | (readUnsignedByte()          & 0x0000000000ff);
		}
		
		
		public function readUInt24():int
		{
			return ((readUnsignedByte() << 16 ) & 0xff0000) | ((readUnsignedByte() << 8 ) & 0x00ff00) | (readUnsignedByte() & 0x0000ff);
		}
		
		// -8388608 ~ 8388606
		public function readInt24():int
		{
			var val:int = readUInt24();
			
			if (val > 0x7fffff)
			{
				val = val + ( -(0xffffff + 1));
			}
			
			
			return val;
		}
		
	}

}