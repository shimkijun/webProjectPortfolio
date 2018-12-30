package org.web.bbsCommend;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.BoardDTO;

public class BoardReplyWrite implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int num = Integer.parseInt(request.getParameter("board_num")); //글번호
		
		String board_id = request.getParameter("board_id");
		String board_nick = request.getParameter("board_nick");
		String board_pass = request.getParameter("board_pass"); 
		String subject = request.getParameter("board_subject");
		String content = request.getParameter("board_content");

		int ref = Integer.parseInt(request.getParameter("board_re_ref"));
		int lev = Integer.parseInt(request.getParameter("board_re_lev"));
		int seq = Integer.parseInt(request.getParameter("board_re_seq"));

	
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO boardData = new BoardDTO();
		
		boardData.setBoard_re_ref(ref);
		boardData.setBoard_re_seq(seq);
		
		boolean ok = dao.updateReSeq(boardData);
		boardData.setBoard_id(board_id);//로그인하였을경우 id
		boardData.setBoard_nick(board_nick);//비로그인은 닉네임
		boardData.setBoard_pass(board_pass);
		boardData.setBoard_subject(subject);
		boardData.setBoard_content(content);
		boardData.setBoard_re_ref(ref);
		boardData.setBoard_re_lev(lev+1);
		boardData.setBoard_re_seq(seq+1);
		
		boolean result = dao.boardInsert(boardData);

		String url = "";
		if(result) {
			url = "boardList.bo";
			session.setAttribute("reSuccess", "댓글 작성 완료");
		}else {
			url = "boardModifyView.bo?no="+num;
			System.out.println("실패");
		}
		request.setAttribute("url", url);
	}
}
