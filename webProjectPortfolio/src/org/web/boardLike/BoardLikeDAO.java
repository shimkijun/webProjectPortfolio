package org.web.boardLike;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.web.Connect.DBConnection;



public class BoardLikeDAO {
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	
	private static class SingleTon{
		private static final BoardLikeDAO Instance = new BoardLikeDAO();
	}
	
	public static BoardLikeDAO getInstance() {
		return SingleTon.Instance;
	}
	public int likeCount() {
		int result = 0;
		String sql = "";
		conn = DBConnection.getConnection();
		try {
			sql = "select count(listNum) from likeUp where listNum = ? and likeNum = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, 2);
			pstm.setInt(2, 1);
			rs = pstm.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	public int Like(int listNum ,String userId,int likeNum) {
		int result = 0;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			if(userId.equals("null")) {
				result = -1;//아이디가 null 회원가입
				return result;
			}else if(!userId.equals("null") || likeNum == 1) {
				sql = "insert into likeUp values (?,?,?)";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1,listNum);
				pstm.setString(2,userId);
				pstm.setInt(3,likeNum);
				return result = pstm.executeUpdate();
			}else if(!userId.equals("null") || likeNum == 0) {
				sql = "delete from likeUp where listNum =? and userId = ? and likeNum = ? ";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1,listNum);
				pstm.setString(2,userId);
				pstm.setInt(3,likeNum);
				return result = pstm.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}
	public void close(){
		try {
			if( conn != null) conn.close();
			if( pstm != null) pstm.close();
			if( rs != null) rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
