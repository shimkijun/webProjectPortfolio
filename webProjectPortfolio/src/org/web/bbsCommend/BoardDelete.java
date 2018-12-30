package org.web.bbsCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.bbsDAO.BoardDAO;


public class BoardDelete implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		int num = Integer.parseInt(request.getParameter("board_num")); //글번호
		String board_nick = request.getParameter("board_nick"); //닉네임
		String board_pass = request.getParameter("board_pass"); //비밀번호 매칭
		
		BoardDAO dao = BoardDAO.getInstance();
		
		int result = dao.boardDelete(num, board_nick, board_pass);
		
		String url = "";
		if(result == 1) {
			url = "boardList.bo";
			session.setAttribute("delSuccess", "삭제 완료");
			
		}else {
			session.setAttribute("delWarning", "비밀번호가 틀립니다.");
			url = "boardDeleteView.bo?no="+num;
		}
		
		request.setAttribute("url", url);
	}
}
