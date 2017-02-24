package dark.net.commands 
{
	
	import flash.utils.ByteArray;
	import dark.net.CommandCode;
	import dark.net.ICommand;	
	
	public class PlayerAnimationCommand implements ICommand
	{
		
		public function get code():int
		{
			return CommandCode.PLAYER_ANIMATION;
		}
		
		public var bytes:ByteArray = new ByteArray();
		
		public var animationId:int = 0;
		public var frameIndex:int = 0;
		public var direction:int = 0;
		
		public function PlayerAnimationCommand(animationId:int, frameIndex:int, direction:int)
		{
			this.animationId = animationId;
			this.frameIndex = frameIndex;
			this.direction = direction;
			
			bytes.writeShort(animationId);
			bytes.writeShort(frameIndex);
			bytes.writeByte(direction);
		}
		
		public function getBytes():ByteArray
		{
			return bytes;
		}
		
		public function toString():String
		{
			return "<PlayerAnimationCommand animationId=" + animationId + " frameIndex=" + frameIndex + ">";
		}
		
	}

}