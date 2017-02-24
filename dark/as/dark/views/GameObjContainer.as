package dark.views 
{
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GameObjContainer extends Sprite
	{
		
		public function GameObjContainer() 
		{
			
		}
		
		public function clearChildren():void
		{			
			var cNumChildren:int = numChildren;
			
			for (var i:int = 0; i < cNumChildren; i++)
			{
				removeChildAt(0);
			}
		}
		
		
		public function sortGameObjDepth():int
		{
			try
			{
				return _sortGameObjDepth(); 
			}catch (err:Error)
			{
				trace("sortGameObjDepth err", err);
			}
			
			return 0;
		}
		
		private function _sortGameObjDepth():int
		{
			//trace("sortGameObjDepth", container.numChildren);
			
			if (numChildren < 2) return 0;
			
			if (stage == null) return 0;
			
			var objs:Array = [];
			var obj:DisplayObject = null;
			var obj2:DisplayObject = null;
			var i:int = 0;
			var j:int = 0;
			
			var cNumChildren:int = numChildren;
			
			var stageRect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			var pt1:Point = new Point();
			var pt2:Point = new Point();
			
			for (i = 0; i < cNumChildren; i++)
			{
				obj = getChildAt(i);
				if (obj != null)
				{
					pt1.x = obj.x;
					pt1.y = obj.y;
					
					pt2 = localToGlobal(pt1);
					
					if (stageRect.contains(pt2.x, pt2.y))
					{					
						objs.push(obj);		
					}
				}
			}			
			
			_qsort(objs, 0, objs.length - 1);
			
			//var ylist:Array = [];
			
			
			for (i = 0; i < objs.length; i++)
			{
				obj = objs[i];
				addChild(obj);
				//ylist.push(obj.y);
			}
			
			return objs.length;
			//trace("sort", objs.length);
			
		}
		
		private function _qsort(array:Array, startIdx:int, endIdx:int):void
		{
			if (startIdx < endIdx)
			{
				var pivot:int = _qsort_find_pivot(array, startIdx, endIdx);
				
				_qsort(array, startIdx, pivot - 1);
				_qsort(array, pivot + 1, endIdx);				
			}
		}
		
		private function _qsort_find_pivot(array:Array, startIdx:int, endIdx:int):int
		{
			var leftIdx:int = startIdx + 1;
			var rightIdx:int = endIdx;			
			
			var obj:DisplayObject = array[startIdx];
			var y1:Number = obj.y;	
			
			
			for (var i:int = 0; i < endIdx; i++)
			{
				while (leftIdx <= rightIdx && (array[leftIdx] as DisplayObject).y <= y1)
				{
					leftIdx++;
				}
				
				while (rightIdx >= leftIdx && (array[rightIdx] as DisplayObject).y >= y1)
				{
					rightIdx--;
				}
				
				if (rightIdx < leftIdx)
				{
					break;
				}
				
				obj = array[leftIdx];
				array[leftIdx] = array[rightIdx];
				array[rightIdx] = obj;				
			}
			
			obj = array[startIdx];
			array[startIdx] = array[rightIdx];
			array[rightIdx] = obj;
			
			return rightIdx;			
		}
		
	}

}