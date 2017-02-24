package dark.ui 
{
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 
	 */
	public class CloseButton extends Sprite
	{
		
		public var delegate:ICloseButtonDelegate = null;
		
		public function CloseButton(delegate:ICloseButtonDelegate) 
		{
			this.delegate = delegate;
			
			draw();
			
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.CLICK, _onPress);
		}
		
		private function _onPress(e:MouseEvent)
		{
			delegate.onCloseButtonPress();
		}
		
		public function draw()
		{
			var g:Graphics = this.graphics;
			
			
			g.beginFill(0x336699, 1);
			g.drawRect(0, 0, 32, 32);
			g.endFill();
			
			g.lineStyle(8, 0xffffff, 1, false, "normal", null, JointStyle.MITER);
			
			var padding:int = 10;
			
			var n2:int = 32 - padding;
			
			g.moveTo(padding, padding);
			
			g.lineTo(n2, n2);
			
			g.moveTo(n2, padding);
			
			g.lineTo(padding, n2);
			
			
		}
		
	}

}