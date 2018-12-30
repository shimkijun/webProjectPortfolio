package org.web.memberDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.web.Connect.DBConnection;
import org.web.memberDTO.NormalMemberDTO;

public class NormalMemberDAO {

		private static class SingleTon{
			private static final NormalMemberDAO Instance = new NormalMemberDAO();
		}
		
		public static NormalMemberDAO getInstance() {
			return SingleTon.Instance;
		}
		
		//회원 가입
		public int memberRegister(NormalMemberDTO member) {
			int result = 0;
			
			Connection conn = null;
			PreparedStatement pstm = null;
			String sql = "";
			
			try {
				conn = DBConnection.getConnection();
				sql = "INSERT INTO normalMember values (? , ? , ? , ?,1)";
				pstm = conn.prepareStatement(sql);

				pstm.setString(1, member.getUserId());
				pstm.setString(2, member.getUserPw());
				pstm.setString(3, member.getUserEmail());
				pstm.setString(4, member.getUserPhone());
				
				result = pstm.executeUpdate();
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
			
			return result;
		}
		
		//아이디 체크
		public int memberIdCheck(String userId) {
			int result = 0;
			
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				conn = DBConnection.getConnection();
				sql = "select * from normalMember where userId = ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userId);
				rs = pstm.executeQuery();
				if(rs.next()) {
					String memberInfo = rs.getString(1);
					memberInfo = "1";
					result = Integer.parseInt(memberInfo);
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
		
		//로그인
		public int memberLogin(String userId,String userPw) {
			int result = 0;
			
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				conn = DBConnection.getConnection();
				sql = "select userPw from normalMember where userId = ? and ifNull = 1";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userId);
				
				rs = pstm.executeQuery();
				if(rs.next()) {
					if(rs.getString("userPw").equals(userPw)) {
						result = 1; //로그인 완료
					}else {
						result = 2; // 비밀번호가 다릅니다.
					}
					
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
		
		
		//일반 회원 정보가져오기
		public NormalMemberDTO getUserInfo(String userId) {
			NormalMemberDTO userInfo = null;
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				conn = DBConnection.getConnection();
				sql = "select * from normalMember where userId = ? and ifNull = 1";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userId);
				rs = pstm.executeQuery();
				if(rs.next()) {
					userInfo = new NormalMemberDTO();
					userInfo.setUserId(rs.getString(1));
					userInfo.setUserPw(rs.getString(2));
					userInfo.setUserEmail(rs.getString(3));
					userInfo.setUserPhone(rs.getString(4));
					userInfo.setIfNull(rs.getByte(5));
					
					return userInfo;
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
			return userInfo;
		}
		
		//회원 수정
		public int memberModify(String userId,String userPw,String userEmail,String userPhone) {
			int result = 0;
			
			Connection conn = null;
			PreparedStatement pstm = null;
			String sql = "";
			
			try {
				conn = DBConnection.getConnection();
				sql = "UPDATE normalMember SET userPw=?,userEmail=?,userPhone=? where userId = ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userPw);
				pstm.setString(2, userEmail);
				pstm.setString(3, userPhone);
				pstm.setString(4, userId);
				
				
				result = pstm.executeUpdate();
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
			
			return result;
		}
		
		
		//회원 정보 삭제
		public int memberDelete(String userId,String userPw) {
			int result = 0;
			
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				conn = DBConnection.getConnection();
				sql = "select userPw from normalMember where userId = ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userId);
				rs = pstm.executeQuery();
				if(rs.next()) {
					if(rs.getString("userPw").equals(userPw)) {
						sql = "DELETE FROM normalMember WHERE userId=?";
						pstm = conn.prepareStatement(sql);
						pstm.setString(1, userId);
						result = pstm.executeUpdate();
						//삭제 완료
					}else {
						result = 2; // 비밀번호를 잘못입력하였습니다.
					}
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
			
			return result; //데이터베이스 오류
		}
		
}
