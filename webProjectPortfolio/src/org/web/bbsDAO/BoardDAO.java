package org.web.bbsDAO;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.web.Connect.DBConnection;
import org.web.bbsDTO.AddDTO;
import org.web.bbsDTO.BoardDTO;

public class BoardDAO {
	
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	private InetAddress local = null;
	

	private static class SingleTon{
		private static final BoardDAO Instance = new BoardDAO();
	}
	
	public static BoardDAO getInstance() {
		return SingleTon.Instance;
	}
	
	public int getNum() {
		int result = 0;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select board_num from memberBoard order by board_num desc limit 1";
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

	public boolean updateReSeq(BoardDTO board) {
		boolean result = false;
		
		int ref = board.getBoard_re_ref(); //원본글 번호(그룹번호);
		int seq = board.getBoard_re_seq();
		
		String sql = "";
		conn = DBConnection.getConnection();
		
		//ref(그룹 번호)와 seq(답글 순서)를 확인하여 원본 글에 다른 답변 글이 있으면,
		//답변 글 중 답변 글보다 상위에 있는 글의 seq 보다 높은글의 seq값을 1 씩 증가 시킨다.
		sql = "UPDATE memberBoard SET board_re_seq = board_re_seq+1 WHERE board_re_ref = ? AND board_re_seq > ? ";
		
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, ref);
			pstm.setInt(2, seq);
			int flag = pstm.executeUpdate();
			if(flag > 0) {
				result = true;
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
	}//댓글
	
	//글작성
	public boolean boardInsert(BoardDTO bbs) {
		boolean result = false;
		String sql = "";
		try {
			local = InetAddress.getLocalHost();
			String ip = local.getHostAddress(); // 아이피 주소
			conn = DBConnection.getConnection();
			sql = "INSERT INTO memberBoard VALUES (NULL,?,?,?,?,?,?,?,?,?,0,now(),?)";
			//시퀀스 값을 글번호와 그룹번호로 사용 = 댓글 작성시 같은 그룹으로 값 으로 설정
			
			pstm = conn.prepareStatement(sql);
			int num = bbs.getBoard_num();
			pstm.setString(1, bbs.getBoard_id());
			pstm.setString(2, bbs.getBoard_nick());
			pstm.setString(3, bbs.getBoard_pass());
			pstm.setString(4, bbs.getBoard_subject());
			pstm.setString(5, bbs.getBoard_content());
			pstm.setString(6, bbs.getBoard_file());
			if(bbs.getBoard_re_seq() == 0) {
				pstm.setInt(7,num);
				//re_seq== 0 이면 댓글이 없는경우 즉 부모글일경우
			}else {
				pstm.setInt(7, bbs.getBoard_re_ref());
			}
			pstm.setInt(8,bbs.getBoard_re_lev());
			pstm.setInt(9,bbs.getBoard_re_seq());
			pstm.setString(10,ip);
			int flag = pstm.executeUpdate();
			if(flag > 0) {
				 result = true; //작성 완료
			}
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
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
	
	//검색 + 게시판 내용 가져오기
	public ArrayList<BoardDTO> getBbsList(HashMap<String, Object> listOpt) {
		ArrayList<BoardDTO> list = new  ArrayList<>();
		String opt = (String)listOpt.get("opt");//param op 검색옵션
		String condition = (String)listOpt.get("condition");//검색 내용
		int start = (Integer)listOpt.get("start"); //게시물 시작번호
		int listCount = (Integer)listOpt.get("listCount"); //게시물 을 몇개씩 보여줄지 정하는 상수
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			if(opt == null) {

			sql = "select * from memberBoard order by board_re_ref desc,board_re_seq asc LIMIT ?,?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, start);
				pstm.setInt(2, listCount); 
			}else if(opt.equals("0")) { //제목 으로 검색
				sql = "select * from memberBoard where board_subject like ? order by board_re_ref desc,board_re_seq asc LIMIT ?,?";
				pstm = conn.prepareStatement(sql);
					pstm.setString(1, "%"+condition+"%");
					pstm.setInt(2, start);
					pstm.setInt(3, listCount);
					
			}else if(opt.equals("1")) { //내용 으로 검색
				sql = "select * from memberBoard where board_content like ? order by board_re_ref desc,board_re_seq asc LIMIT ?,?";
				pstm = conn.prepareStatement(sql);
				
					pstm.setString(1, "%"+condition+"%");
					pstm.setInt(2, start);
					pstm.setInt(3, listCount);
					
			}else if(opt.equals("2")) { //제목 + 내용으로 검색
				sql = "select * from memberBoard where board_subject like ? or board_content like ? order by board_re_ref desc,board_re_seq asc LIMIT ?,?";
				pstm = conn.prepareStatement(sql);
				
					pstm.setString(1, "%"+condition+"%");
					pstm.setString(2, "%"+condition+"%");
					pstm.setInt(3, start);
					pstm.setInt(4, listCount); 
					
			}else if(opt.equals("3")) { //작성자 으로 검색
				sql = "select * from memberBoard where board_id like ? or board_nick like ? order by board_re_ref desc,board_re_seq asc LIMIT ?,?";
				pstm = conn.prepareStatement(sql);
					pstm.setString(1, "%"+condition+"%");
					pstm.setString(2, "%"+condition+"%");
					pstm.setInt(3, start);
					pstm.setInt(4, listCount);
					
			}else if(opt.equals("4")){ //전체검색
				sql = "select * from memberBoard where board_id like ? or board_nick like ? or board_subject like ? or board_content like ? "
						+ "order by board_re_ref desc,board_re_seq asc LIMIT ?,?";
				pstm = conn.prepareStatement(sql);
					pstm.setString(1, "%"+condition+"%");
					pstm.setString(2, "%"+condition+"%");
					pstm.setString(3, "%"+condition+"%");
					pstm.setString(4, "%"+condition+"%");
					pstm.setInt(5, start);
					pstm.setInt(6, listCount);	
			}
			
			rs = pstm.executeQuery();
			while(rs.next()) {
				//DTO 에서 생성자를 생성해서도 가능
				BoardDTO dto = new BoardDTO();
				
				dto.setBoard_num(rs.getInt("board_num"));
				dto.setBoard_id(rs.getString("board_id"));
				dto.setBoard_nick(rs.getString("board_nick"));
				dto.setBoard_pass(rs.getString("board_pass"));
				dto.setBoard_subject(rs.getString("board_subject"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_re_ref(rs.getInt("board_re_ref"));
				dto.setBoard_re_lev(rs.getInt("board_re_lev"));
				dto.setBoard_re_seq(rs.getInt("board_re_seq"));
				dto.setBoard_count(rs.getInt("board_count"));
				dto.setBoard_date(rs.getDate("board_date"));
				dto.setBoard_ip(rs.getString("board_ip"));
				
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
	
	//게시글 개수 가져오기
	public int getListCount(HashMap<String, Object> listOpt) {
		int result = 0;
		String opt = (String)listOpt.get("opt");
		String condition = (String)listOpt.get("condition");
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			if(opt == null ) { //전체 게시물 개수
				sql = "select count(*) from memberBoard";
				pstm = conn.prepareStatement(sql);
			
			}else if(opt.equals("0")) { //제목으로 검색 게시물 개수
				sql = "select count(*) from memberBoard where board_subject like ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, "%"+condition+"%");
				
			}else if(opt.equals("1")) { //내용으로 검색 게시물 개수
				sql = "select count(*) from memberBoard where board_content like ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, "%"+condition+"%");
				
			}else if(opt.equals("2")) { //제목 + 내용 검색 게시물 개수
				sql = "select count(*) from memberBoard where board_subject like ? or board_content like ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, "%"+condition+"%");
				pstm.setString(2, "%"+condition+"%");
				
			}else if(opt.equals("3")) { //작성자 검색 게시물 개수
				sql = "select count(*) from memberBoard where board_id like ? or board_nick like ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, "%"+condition+"%");
				pstm.setString(2, "%"+condition+"%");
				
			}else if(opt.equals("4")) { //전체 검색
				sql = "select count(*) from memberBoard where board_id like ? or board_nick like ? or board_subject like ? or board_content like ?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, "%"+condition+"%");
				pstm.setString(2, "%"+condition+"%");
				pstm.setString(3, "%"+condition+"%");
				pstm.setString(4, "%"+condition+"%");
				
			}
			
			rs = pstm.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( rs != null) rs.close();
				if( pstm != null) pstm.close();		
				if( conn != null) conn.close();	
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
		//게시판 글쓴 내용가져오기
		public BoardDTO getListView(int board_num) {
			BoardDTO dto = new BoardDTO();
			String sql = "";
			try {
				conn = DBConnection.getConnection();
				sql = "select * from memberBoard where board_num = ?";
					pstm = conn.prepareStatement(sql);
					pstm.setInt(1, board_num);
					rs = pstm.executeQuery();
				while(rs.next()) {

					dto.setBoard_num(rs.getInt("board_num"));
					dto.setBoard_id(rs.getString("board_id"));
					dto.setBoard_nick(rs.getString("board_nick"));
					dto.setBoard_pass(rs.getString("board_pass"));
					dto.setBoard_subject(rs.getString("board_subject"));
					dto.setBoard_content(rs.getString("board_content"));
					dto.setBoard_file(rs.getString("board_file"));
					dto.setBoard_re_ref(rs.getInt("board_re_ref"));
					dto.setBoard_re_lev(rs.getInt("board_re_lev"));
					dto.setBoard_re_seq(rs.getInt("board_re_seq"));
					dto.setBoard_count(rs.getInt("board_count"));
					dto.setBoard_date(rs.getDate("board_date"));
					dto.setBoard_ip(rs.getString("board_ip"));
					
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
		}//get list
	
		//조휘수 올리기
		public int getHit(int board_num) {
			int result = 0;
			String sql = "";
			try {
				conn = DBConnection.getConnection();
				sql = " UPDATE memberBoard set board_count = board_count+1 where board_num = ?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, board_num);
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
		}//getSeq
		
		
		//게시판 수정
		public int boardModify(BoardDTO dto) {
			int result = 0;
			String sql = "";
			
			try {
				local = InetAddress.getLocalHost();
				String ip = local.getHostAddress(); // 아이피 주소
				
				conn = DBConnection.getConnection();
				sql = "UPDATE memberBoard SET board_subject = ? , board_content = ?, board_file=? , board_date= now(),board_ip = ? where board_num = ? and board_nick = ? and board_pass = ?";
					pstm = conn.prepareStatement(sql);
					
					pstm.setString(1, dto.getBoard_subject());
					pstm.setString(2, dto.getBoard_content());
					pstm.setString(3, dto.getBoard_file());
					pstm.setString(4, ip);
					pstm.setInt(5, dto.getBoard_num());
					pstm.setString(6, dto.getBoard_nick());
					pstm.setString(7, dto.getBoard_pass());
					
					result = pstm.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
			} catch(UnknownHostException e){
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
	}//board modify
		
	//수정할때 내용 가져오기
	public BoardDTO getModifyView(int board_num) {
		BoardDTO dto = new BoardDTO();
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select * from memberBoard where board_num = ?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, board_num);
				rs = pstm.executeQuery();
			while(rs.next()) {

				dto.setBoard_num(rs.getInt("board_num"));
				dto.setBoard_id(rs.getString("board_id"));
				dto.setBoard_nick(rs.getString("board_nick"));
				dto.setBoard_pass(rs.getString("board_pass"));
				dto.setBoard_subject(rs.getString("board_subject"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_re_ref(rs.getInt("board_re_ref"));
				dto.setBoard_re_lev(rs.getInt("board_re_lev"));
				dto.setBoard_re_seq(rs.getInt("board_re_seq"));
				dto.setBoard_count(rs.getInt("board_count"));
				dto.setBoard_date(rs.getDate("board_date"));
				dto.setBoard_ip(rs.getString("board_ip"));
				
				return dto;
				
			}
			
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
		return dto;
	}//get list
		
	
	//게시판 삭제
	public int boardDelete(int board_num,String board_nick,String board_pass) {
		int result = 0;
		String sql = "";
		
		try {

			conn = DBConnection.getConnection();
			sql = "DELETE FROM memberBoard where board_num = ? AND board_nick = ? AND board_pass = ?";
				pstm = conn.prepareStatement(sql);
				
				pstm.setInt(1, board_num);
				pstm.setString(2, board_nick);
				pstm.setString(3, board_pass);
				
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
	}//delte
	
	public int addInsert(int addNum,String userId,String board_Id) {
		int result = 0;
		String sql = "";
		
		try {

			conn = DBConnection.getConnection();
			sql = "insert into addTest values (?,?,?)";
				pstm = conn.prepareStatement(sql);
				
				pstm.setInt(1, addNum);
				pstm.setString(2, userId);
				pstm.setString(3, board_Id);
				
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
	}//addCart
	
	public AddDTO checkCart(int addNum,String userId,String board_Id) {
		AddDTO dto = null;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select addId,userId,board_Id from addTest where addid=? and userId=? and board_Id=?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, addNum);
				pstm.setString(2, userId);
				pstm.setString(3, board_Id);
				rs = pstm.executeQuery();
				if(rs.next()) {
					dto = new AddDTO();
					dto.setAddId(rs.getInt("addId"));
					dto.setUserId(rs.getString("userId"));
					dto.setBoard_Id(rs.getString("board_Id"));
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

	public int cartCount(String userId) {
		int result = 0;
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select count(*) from addTest where userId=?";
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
	
	public ArrayList<AddDTO> cartList(String userId) {
		ArrayList<AddDTO> cartList = new ArrayList<>();
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select * from addTest where userId=?";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, userId);
				rs = pstm.executeQuery();
				while(rs.next()) {
					AddDTO dto = new AddDTO();
					dto.setAddId(rs.getInt("addId"));
					dto.setUserId(rs.getString("userId"));
					dto.setBoard_Id(rs.getString("board_Id"));
					cartList.add(dto);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( conn != null) conn.close();
				if( pstm != null) pstm.close();
				if( rs != null) rs.close();
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cartList;
	}
	
	public BoardDTO getCartList(HashMap<String, Object> listOpt) {
		BoardDTO dto = null;
		int addId = (Integer)listOpt.get("addId"); //게시물 번호
		String board_Id = (String)listOpt.get("board_Id"); //게시물 작성자
		
		String sql = "";
		try {
			conn = DBConnection.getConnection();
			sql = "select * from memberBoard where board_num = ? and Board_Nick = ?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, addId);
				pstm.setString(2, board_Id); 
			rs = pstm.executeQuery();
			if(rs.next()) {
				//DTO 에서 생성자를 생성해서도 가능
				dto = new BoardDTO();
				//rs.getInt(1);
				dto.setBoard_num(rs.getInt("board_num"));
				dto.setBoard_id(rs.getString("board_id"));
				dto.setBoard_nick(rs.getString("board_nick"));
				dto.setBoard_pass(rs.getString("board_pass"));
				dto.setBoard_subject(rs.getString("board_subject"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_re_ref(rs.getInt("board_re_ref"));
				dto.setBoard_re_lev(rs.getInt("board_re_lev"));
				dto.setBoard_re_seq(rs.getInt("board_re_seq"));
				dto.setBoard_count(rs.getInt("board_count"));
				dto.setBoard_date(rs.getDate("board_date"));
				dto.setBoard_ip(rs.getString("board_ip"));
				return dto;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if( conn != null) conn.close();
				if( pstm != null) pstm.close();
				if( rs != null) rs.close();	
				} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}//get list
	
}
