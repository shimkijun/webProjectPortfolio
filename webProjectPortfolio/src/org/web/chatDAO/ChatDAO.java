package org.web.chatDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.web.Connect.DBConnection;
import org.web.chatDTO.ChatDTO;

public class ChatDAO {
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	
	private static class SingleTon{
		private static final ChatDAO Instance = new ChatDAO();
	}
	
	public static ChatDAO getInstance() {
		return SingleTon.Instance;
	}
	
	public int submit(String fromId,String toId,String chatContent){
		int result = 0;
		try {
			String sql = "INSERT INTO liveChat values (NULL,?,?,?,now(),0,0)";
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);
			pstm.setString(3, chatContent);
			result = pstm.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e ) {
				e.printStackTrace();
			}
		}
		return result; //데이터베이스 오류
	}
	
	public ArrayList<ChatDTO> getChatListById(String fromId,String toId,String chatId){
		ArrayList<ChatDTO> chatList = null;
		String sql = "select * from liveChat where ((fromId = ? and toId =?) or (fromId = ? and toId =?)) and chatId > ? order by chatTime";
		try {
		
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);
			pstm.setString(3, toId);
			pstm.setString(4, fromId);
			pstm.setInt(5, Integer.parseInt(chatId));
			rs = pstm.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatId(rs.getInt("chatId"));
				chat.setFromId(rs.getString("fromId").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setToId(rs.getString("toId").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setChatTime(rs.getString("chatTime"));
				chatList.add(chat);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	public ArrayList<ChatDTO> getChatListByRow(String fromId,String toId){
		ArrayList<ChatDTO> chatList = null;
		String sql = "select * from liveChat where chatId = (select max(chatId) as chatId from liveChat where (fromId=? and toId=?) or (fromId=? and toId=?))";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);
			pstm.setString(3, toId);
			pstm.setString(4, fromId);
			rs = pstm.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatId(rs.getInt("chatId"));
				chat.setFromId(rs.getString("fromId").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setToId(rs.getString("toId").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setChatTime(rs.getString("chatTime"));
				chatList.add(chat);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	public ArrayList<ChatDTO> getChatListByRecent(String fromId,String toId,int number){
		ArrayList<ChatDTO> chatList = null;
		String sql = "select * from liveChat where ((fromId = ? and toId =?) or (fromId = ? and toId =?)) and chatId > (select max(chatId) - ? from liveChat where(fromId = ? and toId =?) or (fromId=? and toId=?)) order by chatTime";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);
			pstm.setString(3, toId);
			pstm.setString(4, fromId);
			pstm.setInt(5, number);
			pstm.setString(6, fromId);
			pstm.setString(7, toId);
			pstm.setString(8, toId);
			pstm.setString(9, fromId);
			rs = pstm.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatId(rs.getInt("chatId"));
				chat.setFromId(rs.getString("fromId").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setToId(rs.getString("toId").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				/*String timeType = "오전";
				if(chatTime > 12) {
					timeType="오후";
					chatTime -= 12;
				}*/
				chat.setChatTime(rs.getString("chatTime"));
				chatList.add(chat);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	public int readChat(String fromId,String toId) {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "update liveChat set chatRead = 1 where (fromId =? and toId = ?)";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, toId);
			pstm.setString(2, fromId);
			
			return pstm.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	public int unreadChat(String fromId,String toId) {
		conn = DBConnection.getConnection();
		String sql = "select count(chatId) from liveChat where fromId=? and toId=? and chatRead = 0";
		try {

			pstm = conn.prepareStatement(sql);
			pstm.setString(1, toId);
			pstm.setString(2, fromId);
			rs = pstm.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
