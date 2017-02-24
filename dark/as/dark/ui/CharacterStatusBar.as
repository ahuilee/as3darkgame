package dark.ui 
{
	import dark.Game;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ahui
	 */
	public class CharacterStatusBar extends Sprite
	{
		
		public var game:Game = null;
		
		public var hpBar:ValueBar = null;
		public var mpBar:ValueBar = null;
		
		private var txtHp:TextField = null;
		private var txtMp:TextField = null;
		
		public function CharacterStatusBar(game:Game) 
		{
			this.game = game;
			
			hpBar = new ValueBar(game);
			hpBar.color = 0xff0000;
			hpBar.x = 0;
			
			mpBar = new ValueBar(game);
			mpBar.color = 0x0000ff;
			mpBar.x = 380;
			mpBar.y = 0;
			
			txtHp =  new TextField();
			txtHp.textColor = 0xffffff;
			txtHp.selectable = false;
			txtHp.text = "HP";
			txtHp.autoSize = TextFieldAutoSize.CENTER;
			txtHp.filters = [new GlowFilter(0x000000, 1, 3, 3, 2)];
			txtHp.x = 30;
			txtHp.y = 5;// hpBar.height / 2 - txtHp.height / 2;
			
			txtMp =  new TextField();
			txtMp.textColor = 0xffffff;
			txtMp.selectable = false;
			txtMp.text = "MP";
			txtMp.autoSize = TextFieldAutoSize.CENTER;
			txtMp.filters = [new GlowFilter(0x000000, 1, 3, 3, 2)];
			txtMp.x = 410;
			txtMp.y = 5;// mpBar.height / 2 - txtMp.height / 2;	
			
			
			addChild(hpBar);
			addChild(mpBar);
			
			addChild(txtHp);
			addChild(txtMp);
		}
		
		public function setValueMax(hpMax:int, mpMax:int):void
		{
			hpBar.maxValue = hpMax;
			mpBar.maxValue = mpMax;
		}
		
		public function setValue(hp:int, mp:int):void
		{
			hpBar.value = hp;
			mpBar.value = mp
		}
		
		public function draw():void
		{
			hpBar.draw();
			mpBar.draw();
		}
		
	}

}