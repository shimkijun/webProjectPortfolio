package org.web.bbsProDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import org.web.Connect.DBConnection;
import org.web.bbsProDTO.BoardDTO;
import org.web.bbsProDTO.ZzimDTO;

public class BoardProDAO {
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	
	private static class SingleTon{
		private static final BoardProDAO Instance = new BoardProDAO();
	}
	
	public static BoardProDAO getInstance() {
		return SingleTon.Instance;
	}
	
	public int getNum() {
		int result = 0;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select pro_id from proBoard order by pro_id desc limit 1";
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			if(rs.next()) {
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
	
	public int getCount() {
		int result = 0;
		String sql = "";
		conn = DBConnection.getConnection();
		sql = "select count(*) from proBoard";
		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
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
	
	//좌표 + 정보입력
	public int mapInsert(BoardDTO dto) {
		int result = 0;
		
		String sql = "";
		conn = DBConnection.getConnection();
		sql = "insert into proBoard values (?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, dto.getPro_id());
			pstm.setString(2, dto.getPro_userName());
			pstm.setString(3, dto.getBusiness_name());
			pstm.setString(4, dto.getDetail_ex());
			pstm.setInt(5, dto.getPostNum());
			pstm.setString(6, dto.getBusiness_addr());
			pstm.setString(7, dto.getBusiness_addr1());
			pstm.setString(8, dto.getThumbnail_file());
			pstm.setNString(9, dto.getSlide_file());
			pstm.setString(10, dto.getLatY());
			pstm.setString(11, dto.getLngX());
			
			result = pstm.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	
	//좌표값만 출력
	public ArrayList<BoardDTO> getLocation(){
		ArrayList<BoardDTO> locations = new ArrayList<BoardDTO>();
		String sql = "";
		
		conn = DBConnection.getConnection();
		sql = "select pro_id,LatY,LngX from proBoard";
		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPro_id(Integer.parseInt(rs.getString("pro_id")));
				dto.setLatY(rs.getString("LatY"));
				dto.setLngX(rs.getString("LngX"));
				
				locations.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return locations;
	}
	
	public ArrayList<BoardDTO> getBbsList(int start,int last) {
		ArrayList<BoardDTO> list = new  ArrayList<>();
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select * from proBoard limit ?,?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, start);
				pstm.setInt(2, last);
				rs = pstm.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPro_id(rs.getInt("pro_id"));
				dto.setPro_userName(rs.getString("pro_userName"));
				dto.setBusiness_name(rs.getString("business_name").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setDetail_ex(rs.getString("detail_ex").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setPostNum(rs.getInt("postNum"));
				dto.setBusiness_addr(rs.getString("business_addr"));
				dto.setBusiness_addr1(rs.getString("business_addr1"));
				dto.setThumbnail_file(rs.getString("thumbnail_file"));
				dto.setSlide_file(rs.getString("slide_file"));
				dto.setLatY(rs.getString("LatY"));
				dto.setLngX(rs.getString("LngX"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}//get list
	
	public ArrayList<BoardDTO> proView(int pro_id,String business_name) {
		ArrayList<BoardDTO> list = new  ArrayList<>();
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select * from proBoard where pro_id=? and business_name=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, pro_id);
				pstm.setString(2, business_name);

				rs = pstm.executeQuery();
			if(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPro_id(rs.getInt("pro_id"));
				dto.setPro_userName(rs.getString("pro_userName"));
				dto.setBusiness_name(rs.getString("business_name").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setDetail_ex(rs.getString("detail_ex").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setPostNum(rs.getInt("postNum"));
				dto.setBusiness_addr(rs.getString("business_addr"));
				dto.setBusiness_addr1(rs.getString("business_addr1"));
				dto.setThumbnail_file(rs.getString("thumbnail_file"));
				dto.setSlide_file(rs.getString("slide_file"));
				dto.setLatY(rs.getString("LatY"));
				dto.setLngX(rs.getString("LngX"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}//get list

	public int zzimInsert(int id , String userId ,String pro_userName, String agent_name) {
		int result = 0;
		
		String sql = "";
		conn = DBConnection.getConnection();
		sql = "insert into addZzim values (?,?,?,?)";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			pstm.setString(2, userId);
			pstm.setString(3, pro_userName);
			pstm.setString(4, agent_name);
			
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
		}finally {
			try {
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public ArrayList<ZzimDTO> zzimCheck(String userId) {
		ArrayList<ZzimDTO> list = new ArrayList<>();
		
		String sql = "";
		conn = DBConnection.getConnection();
		sql = "select * from addZzim where userId= ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, userId);
			rs = pstm.executeQuery();
			while(rs.next()) {
				ZzimDTO dto = new ZzimDTO();
				dto = new ZzimDTO();
				dto.setId(rs.getInt(1));
				dto.setUserId(rs.getString(2));
				dto.setPro_userName(rs.getString(3));
				dto.setAgent_name(rs.getString(4));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
		}finally {
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
	
	public BoardDTO zzimList(int id,String pro_userName ,String agent_name) {
		BoardDTO dto = null;
		
		String sql = "";
		conn = DBConnection.getConnection();
		sql = "select * from proBoard where pro_id= ? and pro_userName=? and business_name=?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			pstm.setString(2, pro_userName);
			pstm.setString(3, agent_name);
			rs = pstm.executeQuery();
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setPro_id(rs.getInt("pro_id"));
				dto.setPro_userName(rs.getString("pro_userName"));
				dto.setBusiness_name(rs.getString("business_name").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setDetail_ex(rs.getString("detail_ex").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setPostNum(rs.getInt("postNum"));
				dto.setBusiness_addr(rs.getString("business_addr"));
				dto.setBusiness_addr1(rs.getString("business_addr1"));
				dto.setThumbnail_file(rs.getString("thumbnail_file"));
				dto.setSlide_file(rs.getString("slide_file"));
				dto.setLatY(rs.getString("LatY"));
				dto.setLngX(rs.getString("LngX"));
				return dto;
			}
			
		} catch (SQLException e) {
		}finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	public int zzimCount(String userId) {
		int result = 0;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select count(*) from addZzim where userId=?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userId);
				rs = pstm.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
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
	
	public ArrayList<BoardDTO> MainSearch(String q) {
		ArrayList<BoardDTO> list = new ArrayList<>();
		String sql = "";
		conn = DBConnection.getConnection();
		sql = "select * from proBoard where business_addr like ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, "%"+q+"%");
			rs = pstm.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setPro_id(rs.getInt("pro_id"));
				dto.setPro_userName(rs.getString("pro_userName"));
				dto.setBusiness_name(rs.getString("business_name").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setDetail_ex(rs.getString("detail_ex").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>"));
				dto.setPostNum(rs.getInt("postNum"));
				dto.setBusiness_addr(rs.getString("business_addr"));
				dto.setBusiness_addr1(rs.getString("business_addr1"));
				dto.setThumbnail_file(rs.getString("thumbnail_file"));
				dto.setSlide_file(rs.getString("slide_file"));
				dto.setLatY(rs.getString("LatY"));
				dto.setLngX(rs.getString("LngX"));
				list.add(dto);
			}
		} catch (SQLException e) {
		}finally {
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
	
	public ZzimDTO zzimCount(int id,String userId,String agent_name) {
		ZzimDTO dto = null;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select * from addZzim where id = ? and userId=? and agent_name=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, id);
				pstm.setString(2, userId);
				pstm.setString(3, agent_name);
				rs = pstm.executeQuery();
				if(rs.next()) {
					dto = new ZzimDTO();
					dto.setId(rs.getInt("id"));
					dto.setUserId(rs.getString("userId"));
					dto.setPro_userName("pro_userName");
					dto.setAgent_name(rs.getString("agent_name"));
					return dto;
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	public int zzimOut(int id,String userId,String agent_name) {
		int result = 0;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "delete from addZzim where id=? and userId=? and agent_name=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, id);
				pstm.setString(2, userId);
				pstm.setString(3, agent_name);
				result = pstm.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public ZzimDTO zzimCancelChek(int id,String userId,String agent_name) {
		ZzimDTO dto = new ZzimDTO();
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select * from addZzim where id=? and userId=? and agent_name=?";
				pstm = conn.prepareStatement(sql);
				
				pstm.setInt(1, id);
				pstm.setString(2, userId);
				pstm.setString(3, agent_name);
				rs = pstm.executeQuery();
				if(rs.next()) {
					dto.setId(rs.getInt(1));
					dto.setUserId(rs.getString(2));
					dto.setPro_userName(rs.getString(3));
					dto.setAgent_name(rs.getString(4));
					return dto;
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( rs != null) rs.close(); rs = null;
				if( pstm != null) pstm.close();	pstm = null;	
				if( conn != null) conn.close(); conn = null;
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
}
