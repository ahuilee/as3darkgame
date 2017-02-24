package darkjserv;

import java.util.ArrayList;


public class GameCharacterLevelTable 
{
	
	
	
	private ArrayList<LevelSet> _setsDesc = null;
	private ArrayList<LevelSet> _setsAsc = null;
	
	public GameCharacterLevelTable()
	{
		_setsDesc = new ArrayList<LevelSet>();
		_setsAsc = new ArrayList<LevelSet> ();
		
		
		_setLevelExp(0, 10, 128);
		_setLevelExp(10, 20, 256);
		_setLevelExp(20, 30, 512);
		_setLevelExp(30, 40, 1024);
		_setLevelExp(40, 50, 2048);
		_setLevelExp(50, 60, 4096);
		_setLevelExp(60, 70, 8192);
		_setLevelExp(70, 80, 16384);
		_setLevelExp(80, 90, 32767);
		_setLevelExp(90, 100, 65536);
		_setLevelExp(100, 150, 131072);
		_setLevelExp(150, 200, 262144);
		_setLevelExp(200, 250, 524288);
		_setLevelExp(250, 300, 1048576);
		_setLevelExp(300, 350, 2097152);
		_setLevelExp(350, 400, 4194304);
		_setLevelExp(400, 450, 8388608);
		_setLevelExp(450, 500, 16777216);
		_setLevelExp(600, 600, 33554432);
		_setLevelExp(600, 700, 67108864);
		_setLevelExp(700, 800, 134217728);
		_setLevelExp(800, 900, 268435456);
		_setLevelExp(900, 1000, 536870912);
		_setLevelExp(1000, 2000, 1073741824);
		_setLevelExp(1000, 10000, 2147483648L);
		
	}
	
	private long _lastSetExp = 0;
	
	private void _setLevelExp(int levelStart, int levelEnd, long baseExp)
	{
		for(int i=levelStart; i<levelEnd; i++)
		{
			short level = (short)( i + 1);
			long exp = _lastSetExp + baseExp;			
			_lastSetExp = exp;
			
			LevelSet set = new LevelSet();
			set.level = level;
			set.exp = exp;
			
			//System.out.println(set);
			
			_setsAsc.add(set);
			_setsDesc.add(0, set);
			
			
		}
	}
	
	class LevelSet
	{
		public short level = 0;
		public long exp = 0;
		
		public String toString()
		{
			return String.format("<LevelSet level=%d exp=%d >", level, exp);
		}
	}
	
	public int calcExpPercent(long curExp)
	{
		int curLevel = calcCharLevel(curExp);
		
		long curLevelExpStart = calcNextLevelExp(curLevel-1);
		long nextLevelExp = calcNextLevelExp(curLevel);
		
		int expPercent = (int)((curExp-curLevelExpStart) / (double)(nextLevelExp-curLevelExpStart) * 255);
		
		return expPercent;
	}

	public long calcNextLevelExp(int curLevel)
	{
		int idx = curLevel;
		LevelSet set = _setsAsc.get(idx);
		System.out.println(String.format("calcNextLevelExp idx=%d curLevel=%s %s", idx, curLevel, set));
		
		return set.exp;
	}
	
	public int calcCharLevel(long curExp)
	{
		
		for(LevelSet set : _setsDesc)
		{

			if(curExp > set.exp)
			{
				return set.level;
			}
		}
		
		
		return 1;
	}


}
