package org.web.adminDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.web.Connect.DBConnection;
import org.web.chatDTO.ChatDTO;

public class ChatDAO {

	Connection conn = null;
	PreparedStatement pstm = null;
	ResultSet rs = null;

	private static class SingleTon {
		private static final ChatDAO Instance = new ChatDAO();
	}

	public static ChatDAO getInstance() {
		return SingleTon.Instance;
	}

	public int getChatId(String fromId) {
		int result = 0;
		String sql = "";
		sql = "select chatId from liveChat where fromId=? order by chatId desc limit 1";
		conn = DBConnection.getConnection();
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			rs = pstm.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
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
		return result;
	}
	//**
	public ArrayList<ChatDTO> getList() {
		ArrayList<ChatDTO> list = new ArrayList<ChatDTO>();
		String sql = "";
		try {
			conn = DBConnection.getConnection();

			sql = "SELECT a.* FROM liveChat a INNER JOIN (SELECT b.*, MAX(chatTime) AS MaxDateTime FROM liveChat b GROUP BY b.fromId) groupeda ON a.chatTime = groupeda.MaxDateTime order by chatTime desc";
			pstm = conn.prepareStatement(sql);
			rs =pstm.executeQuery();
			while(rs.next()) {
				ChatDTO dto = new ChatDTO();
				dto.setChatId(rs.getInt(1));
				dto.setFromId(rs.getString(2));
				dto.setToId(rs.getString(3));
				dto.setChatContent(rs.getString(4));
				dto.setChatTime(rs.getString(5));
				dto.setChatRead(rs.getInt(6));
				dto.setChatRe(rs.getInt(7));
				list.add(dto);
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

		return list;
	}

	
	//**
	public ArrayList<ChatDTO> getChatListById(String fromId, String toId) {
		ArrayList<ChatDTO> chatList = null;
		conn = DBConnection.getConnection();
		String sql = "select * from liveChat where ((fromId = ? and toId =?) or (fromId = ? and toId =?)) order by chatTime desc";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);
			pstm.setString(3, toId);
			pstm.setString(4, fromId);
			rs = pstm.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while (rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatId(rs.getInt("chatId"));
				chat.setFromId(rs.getString("fromId").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "</br>"));
				chat.setToId(rs.getString("toId").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "</br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "</br>"));
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

	
	//**
	public int submit(String fromId, String toId, String chatContent) {

		conn = DBConnection.getConnection();
		String sql = "insert into liveChat values (null,?,?,?,now(),0,0)";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);
			pstm.setString(3, chatContent);

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
		return -1; // 데이터베이스 오류
	}

	//**
	public int readChat(String fromId, String toId) {
		conn = DBConnection.getConnection();
		String sql = "update liveChat set chatRead = 1 where (fromId =? and toId = ?)";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fromId);
			pstm.setString(2, toId);

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
	
	//**
	public int reChat(String fromId, String toId) {
		conn = DBConnection.getConnection();
		String sql = "update liveChat set chatRe = 1 where (fromId =? and toId = ?)";
		try {
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

	public int getAllUnreadChat(String userId) {
		conn = DBConnection.getConnection();
		String sql = "select count(chatId) from liveChat where fromId =? and chatRead = 0";
		try {

			pstm = conn.prepareStatement(sql);
			pstm.setString(1, userId);
			rs = pstm.executeQuery();
			if (rs.next()) {
				return rs.getInt("count(chatId)");
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
