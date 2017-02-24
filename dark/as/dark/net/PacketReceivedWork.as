package dark.net 
{
	import dark.IWork;
	/**
	 * ...
	 * @author ahui
	 */
	public class PacketReceivedWork implements IWork
	{
		
		public var packet:Packet = null;
		public var conn:Connection = null;
			
		public function PacketReceivedWork(packet:Packet, conn:Connection) 
		{
			this.packet = packet;
			this.conn = conn;
		}
		
		public function run():void 
		{
			//trace("PacketReceivedWork", packet);
			//trace("PacketReceivedWork", packet);
			
			conn.packetReceived(packet);
		}
		
		public function getWorkWeighted():int
		{
			return 10;
		}
		
		public function except(err:Error):void
		{
			trace("PacketReceivedWork err", err.getStackTrace());
		}
		
	}

}