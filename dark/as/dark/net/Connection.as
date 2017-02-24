package dark.net 
{
	
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import dark.AppDelegate;

	/**
	 * ...
	 * @author ahui
	 */
	public class Connection 
	{
		
		public static const PACKET_COMMAND:int = 0x01; 
		public static const PACKET_ANSWER:int = 0x02;
		public static const PACKET_ANSWER_SUCCESS:int = 0x01;
		public static const PACKET_ANSWER_ERROR:int = 0x02;
		
		public var app:AppDelegate = null;		
		public var delegate:IConnectionDelegate = null;		
		private var _sock:Socket = null;
		
		
		public var commandReceiver:CommandReceiveHandler = null;
		
		public function Connection(app:AppDelegate, delegate:IConnectionDelegate) 
		{
			this.app = app;
			this.delegate = delegate;
			
			this.commandReceiver = new CommandReceiveHandler(this);
		}	
		
	
		
		public function answerReceived(packet:Packet):void
		{
			var ask:int = packet.body.readInt();
			var state:int = packet.body.readByte();
			
			//trace("answerReceived ask", ask);
			
			var callback:ICommandCallback = _getCommandCallbackByAsk[ask];
			
			if (callback != null)
			{
				if (state == PACKET_ANSWER_SUCCESS)
				{
					callback.success(ask, packet);
				}
			}
			
		}
		
		public function packetReceived(packet:Packet)
		{
			//trace("packetReceived", packet);
			
			if (packet.type == PACKET_COMMAND)
			{
				commandReceiver.commandReceived(packet);
				
				
			} else if (packet.type == PACKET_ANSWER)
			{
				answerReceived(packet);
				
				
			}
		}
		
		private var _packetRecvState:int = 0;
		
		private var _packetType:int = 0;
		private var _packetQid:int = 0;
		private var _packetLength:int = 0;
		
		public function parsePaket()
		{
			
			//trace("parsePaket");
			
			for (var i:int = 0; i < 4096; i++)
			{
				
				if (i > 100)
				{
					trace("parsePaket loop=", i);
				}
				
				if (_packetRecvState == 0)
				{
					if (_buffer.length < 8) return;
					
					_buffer.position = 0;
					_packetType = _buffer.readByte();
					_packetQid  = _buffer.readShort();
					_packetLength  = _buffer.readUnsignedByte() << 16 | _buffer.readUnsignedShort();
					
					//trace("_packetLength", _packetLength, "_packetType", _packetType);
					
					_buffer.position = 8;
					_packetRecvState = 1;
					
					
				}
				
				if(_packetRecvState == 1)
				{
					if ((_buffer.length - _buffer.position) < _packetLength) return ;
					
					var packetBody:DataByteArray = new DataByteArray();
					_buffer.readBytes(packetBody, 0, _packetLength);
					
					var packet:Packet = new Packet();
					packet.type = _packetType;
					packet.qid = _packetQid;
					packet.body = packetBody;
					
					
					_packetRecvState = 0;
					
					//packetReceived(packet);
					
					app.putWork(new PacketReceivedWork(packet, this));
					
					if (_buffer.position < _buffer.length) {
						
						var newBuffer:ByteArray = new ByteArray();
						_buffer.readBytes(newBuffer, 0, _buffer.length - _buffer.position);
						
						_buffer = newBuffer;
						
					} else
					{
						_buffer.clear();
						
						return;
					}
					
					
				}
				
			}
		}
		
		private var _lastReqId:int = 0;
		private var _lastAsk:int = 0;
		
		public function makeNextQid():int
		{
			_lastReqId = (_lastReqId + 1) % 32767;
			
			return _lastReqId;
		}
		
			
		public function makeAsk():int
		{
			
			return ++_lastAsk;
		}
		
		
		private var _getCommandCallbackByAsk:Dictionary = new Dictionary();	
		
		
		public function writeAnswerSuccess(ask:int, writeback:Function=null):void
		{
			
			var qid:int = makeNextQid();
			var output:ByteArray = new ByteArray();
			
			
			var body:ByteArray = null;
			var packetLength:int = 5;
			
			if (writeback != null)
			{
				body = new ByteArray();
				writeback(body);
				
			}
			
			if (body != null)
			{
				packetLength += body.length;
			}
			
			var header:Array = [0, 0, 0, 0, 0, 0, 0, 0];
			var length:int = 0;
			
			header[length++] = PACKET_ANSWER;
			header[length++] = (qid & 0xff00) >> 8;
			header[length++] = (qid & 0x00ff);
			
			header[length++] = (packetLength & 0xff0000) >>16;
			header[length++] = (packetLength & 0x00ff00) >>8;
			header[length++] = (packetLength & 0x0000ff);
			
			for (var i:int = 0; i < header.length; i++)
			{
				output.writeByte(header[i]);
			}		
			
			//trace(header);
			
			output.writeInt(ask);
			output.writeByte(PACKET_ANSWER_SUCCESS);
			
			if (body != null)
			{
				output.writeBytes(body, 0, body.length);
			}
			
			_sock.writeBytes(output, 0, output.length);
			_sock.flush();
			
			
			//trace("writeAnswerSuccess ask=", ask);
		}
		
		public function writeCommand(command:ICommand, callback:ICommandCallback=null):int
		{
			
			//_sock.flush();
			var qid:int = makeNextQid();
			var ask:int = makeAsk();
			
			var output:DataByteArray = new DataByteArray();
			
			var body:ByteArray = command.getBytes();
			var packetLength:int = body.length + 7;
			
			//trace("writeCommand packetLength =", packetLength);
			
			var header:Array = [0, 0, 0, 0, 0, 0, 0, 0];
			var length:int = 0;
			
			header[length++] = PACKET_COMMAND;
			header[length++] = (qid & 0xff00) >> 8;
			header[length++] = (qid & 0x00ff);
			
			header[length++] = (packetLength & 0xff0000) >>16;
			header[length++] = (packetLength & 0x00ff00) >>8;
			header[length++] = (packetLength & 0x0000ff);
			
			//trace("header", header);
			
			for (var i:int = 0; i < header.length; i++)
			{
				output.writeByte(header[i]);
			}		
			
			//trace(header);
			
			output.writeInt(ask);
			output.writeInt24(command.code);
			output.writeBytes(body, 0, body.length);
			
			_sock.writeBytes(output, 0, output.length);
			_sock.flush();
			
			if (callback != null)	
			{
				_getCommandCallbackByAsk[ask] = callback;
			}
			
			return ask;
			//trace("writeCommand ask=", ask, command);
		}
		
		public function connectTCP(host:String, port:int)
		{
			
			_sock = new Socket();
			
			var policyFileUrl:String = "xmlsocket://" + host + ":" + 16095;
			
			app.debug.debugMessage("policyFileUrl=" + policyFileUrl);
			
			Security.allowDomain("*");
			Security.loadPolicyFile(policyFileUrl);
			
			_sock.addEventListener(Event.CONNECT, _onConnect);
			_sock.addEventListener(IOErrorEvent.IO_ERROR, _onIoError);
			_sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			_sock.addEventListener(ProgressEvent.SOCKET_DATA, _onSockData);
			
			
			_sock.connect(host, port);
			
		}
		
		private function _onSecurityError(e:SecurityErrorEvent)
		{
			app.debug.debugMessage("_onSecurityError:" + e);
		}
		
		private function _onIoError(e:IOErrorEvent)
		{
			app.debug.debugMessage("_onIoError:" + e);
		}
		
		private var _buffer:ByteArray = new ByteArray();
		
		private function _onSockData(e:ProgressEvent)
		{
			while (_sock.bytesAvailable > 0)
			{
				var originLen:int = _buffer.length;
				
				_sock.readBytes(_buffer, _buffer.length, _sock.bytesAvailable);
				
				//trace("sock recv _buffer from", originLen, " >> ", _buffer.length);
				
			}
			
			parsePaket();
			
			
		}
		
		private function _onConnect(e:Event)
		{
			app.debug.debugMessage("onConnectionMade...");
			
			delegate.onConnectionMade();
		}
		
		
	}

}