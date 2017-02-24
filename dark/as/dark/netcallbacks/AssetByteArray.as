package dark.netcallbacks
{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ahui
	 */
	public class AssetByteArray extends ByteArray
	{
		
		public function writeUInt16(value:int):void
		{
			writeByte((value & 0xff00) >> 8);
			writeByte((value & 0x00ff));
		}
		
		public function writeHStrUTF(text:String):void
		{

			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(text);
				
			writeUInt16(bytes.length);
			writeBytes(bytes, 0, bytes.length);

		}
		
		public function readHStrUTF():String
		{
			var nameNumBytes:int = ((readUnsignedByte() << 8) & 0xff00) | readUnsignedByte();				
			var nameBytes:ByteArray = new ByteArray();
				
			readBytes(nameBytes, 0, nameNumBytes);
			
			return new String(nameBytes);	
		}
		
		
		public function writeRect(rect:Rectangle):void
		{
			writeFloat(rect.x);
			writeFloat(rect.y);
			writeFloat(rect.width);
			writeFloat(rect.height);
		}
		
		public function readRect():Rectangle 
		{
			var rect:Rectangle = new Rectangle();
			
			rect.x = readFloat();
			rect.y = readFloat();
			rect.width = readFloat();
			rect.height = readFloat();
			
			return rect;		
		}
		
	}

}