package darkjserv.net;


import darkjserv.*;
import darkjserv.commandhandlers.*;
import darkjserv.net.commands.*;
import darkjserv.syncs.SyncCharPosition;

import java.awt.Rectangle;
import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;



public class Connection extends ConnectionBase
{
	
	public boolean lockChangeXY  = false;
	
	
	public Rectangle viewStageRect;
	
	public Connection(int id ,Socket sock, Server server)
	{
		super(id, sock, server);
		
		viewStageRect = new Rectangle(0, 0, 640, 480);
			
	} 
	

	public void setViewBoundSize(int width, int height)
	{
		viewStageRect.width = width;
		viewStageRect.height = height;
		if(player != null)
		{			
			
			player.setViewBoundSize(width, height);
		}
	}

	
	public void connectionLost(String reason)
	{
		if(status != CONNECTION_LOST)
		{
			status = CONNECTION_LOST;
			System.out.println(String.format("connectionLost %s", reason));
			
			this.server.factory.removeGameObj(player);
			
			player.isReleased = true;
			
			List<GamePlayer> inViewPlayers1 = server.factory.hitPlayerViews(player.getMapId(), player.getX(), player.getY());
			
			if(inViewPlayers1.size() > 0)
			{
				
				List<Long> removePks = new ArrayList<Long>();
				removePks.add(player.getObjId());
				
				
				for(GamePlayer p : inViewPlayers1)
				{
					try {
			
						RemoveObjCommand syncCmd = new RemoveObjCommand(removePks);
				
						p.conn.writeCommand(syncCmd);
					} catch(Exception ex)
					{
						
					}
				}
			}
		}
	}
	
	

	
	public CItemFactory getItemFactory()
	{
		return CItemFactory.getInstance();
	}
	
	
	public void commandReceived(Packet packet) throws Exception
	{
		
		DataReader rd = new DataReader(new ByteArrayInputStream(packet.data));
		
		int ask = rd.readInt();
		int code = rd.readInt24();
		
		//System.out.println(String.format("commandReceived code=%d", code));
		
		switch(code)
		{
		
			case CommandCode.PLAYER_STAND:
				new PlayerStandCommandHandler(this).handle(ask, rd);
				break;
		
			case CommandCode.PLAYER_POSITION_CHANGE:
				new PlayerPositionChangeHandler(this).handle(ask, rd);
			
				break;
			case CommandCode.PLAYER_POSITION_SYNC:
				handlePlayerPositionSync(ask, rd);
				break;
				
			case CommandCode.PLAYER_TELEPORT_DONE:
				new PlayerTeleportDoneHandler(this).handle(ask, rd);
				break;
				
				
			case CommandCode.MAP_CHUNK_LOAD:
				new MapChunkLoadHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.GAME_SET_STAGESIZE:
				new SetStageSizeHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.GAME_START:
				new PlayerGameStart(this).handle(ask, rd);
				
				break;
			
			case CommandCode.GAME_INIT:
				new GameInitHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.GAME_INIT_DONE:
				new GameInitDoneHandler(this).handle(ask, rd);
				break;

			case CommandCode.GAME_ASSET_GETINFO:
				new GameAssetGetInfoHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.GET_OBJINFO:
				new GetObjInfoHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.GET_OBJNAME:
				new GetObjNameHandler(this).handle(ask, rd);
				
				break;
				
			case CommandCode.PLAYER_WALKTO:
				new PlayerWalkToHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_ATTACK:
				new PlayerAttackHandler(this).handle(ask, rd);
				
				break;
							
				
			case CommandCode.PLAYER_ITEM_LIST:
				new PlayerItemListHandler(this).handle(ask, rd);
				//handlePlayerItemList(ask, rd);
				break;
				
			case CommandCode.PLAYER_ITEM_INFO:
				new PlayerItemInfoHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_ITEM_USE:
				new PlayerItemUseHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_ITEM_DROP:
				new PlayerItemDropHandler(this).handle(ask, rd);
				break;	
				
			case CommandCode.PLAYER_CHARACTER_INFO:
				new PlayerCharacterInfoHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_TALK_WRITELINE:
				new PlayerTalkWriteLineHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_SKILL_LIST:
				new PlayerSkillListHandler(this).handle(ask, rd);
				break;
			case CommandCode.PLAYER_SKILL_USE:
				new PlayerSkillUseHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.SHOP_ITEM_LIST:
				new ShopItemListHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_GET_SHORTCUT_INFO:
				new PlayerGetShortcutInfoHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_SHORTCUT_SET:
				new PlayerShortcutSetItemHandler(this).handle(ask, rd);
				break;
				
			case CommandCode.PLAYER_CITEM_TAKE:
				new PlayerCItemTakeHandler(this).handle(ask, rd);
				break;
				
				
			case CommandCode.GAME_LOGIN:
				new GameLoginHandler(this).handle(ask, rd);
				break;
		}
	}
	
	
	
	
	

	
	public GamePlayer player = null;
	
	
	public void handlePlayerPositionSync(int ask, DataInputStream rd)  throws Exception
	{
		int x2 = rd.readInt();
		int y2 = rd.readInt();
		byte dir = rd.readByte();
		
		player.setPosition(x2, y2);
	
		player.direction = dir;
		
		
		
		Rectangle viewRect = player.viewRect;
				
		List<GamePlayer> allPlayers = server.factory.hitPlayerViewsByRect(player.getMapId(), viewRect);
		
		//System.out.println(String.format("handlePlayerPositionSync players=%d", allPlayers.size()));
				
		SyncCharPosition syncNode = new SyncCharPosition(player);
				
		for(GamePlayer p : allPlayers)
		{
				
			if(p == player) continue;
			
			p.conn.syncQueue.put(player, syncNode);					
		}
		
		updateViewObjsInfo();
	}
	
	

	
	public void updateViewObjsInfo() throws Exception
	{
		
		
		List<IGameObj> objs = server.factory.hitGameObjs(player.getMapId(), player.viewRect);
		
		//System.out.println(String.format("updateViewObjsInfo %d", objs.size()));
		
		
		for(IGameObj obj : objs)
		{
			if(obj == player) continue;		

			syncQueue.put(obj, null);
		}
			
	
			
	}
	
	public void updateCurrentPositionToPlayers(List<GamePlayer> players)
	{

		if(players.size() > 0)
		{
			
			SyncCharPosition syncNode = new SyncCharPosition(player);
			
			
			for(GamePlayer p : players)
			{
				if(p == player) continue;
				
				try {	
			
					p.conn.syncQueue.put(player, syncNode);
				} catch(Exception ex)
				{
					
				}
			}
		}
		
	}
	
	
	
	
	
	
	private short _lastQid = 0;
	public short makeQid()
	{
		return ++_lastQid;
	}
	
	
	public void writeAnswer(AnswerSuccessResponse response) throws Exception
	{
		synchronized(syncWriteObj)
		{
			short qid = makeQid();
			byte[] header = new byte[8];
			int length = 0;
			
			response.w.flush();
			byte[] body = response.outputStream.toByteArray();		
			
			header[length++] = Packet.ANSWER;
			
			header[length++] = (byte)((qid & 0xff00) >> 8);
			header[length++] = (byte)(qid & 0x00ff);
			
			header[length++] = (byte)((body.length & 0xff0000) >> 16);
			header[length++] = (byte)((body.length & 0x00ff00) >> 8);
			header[length++] = (byte)(body.length & 0x0000ff);
			
			write(header);
			write(body);
			writeFlush();
		}
	}
	
	
	
	
	
	

}
