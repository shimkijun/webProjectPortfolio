package org.web.memberCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.memberDAO.NormalMemberDAO;
import org.web.memberDTO.NormalMemberDTO;

public class NormalMemberModify implements NormalMemberAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("sessionId");
		String userPw1 = request.getParameter("userPw1");
		String userPw2 = request.getParameter("userPw2");
		String userPw ="";
		String userEmail = request.getParameter("userEmail");
		String userPhone1 = request.getParameter("userPhone1");
		String userPhone2 = request.getParameter("userPhone2");
		String userPhone3 = request.getParameter("userPhone3");
		String userPhone = userPhone1+"-"+userPhone2+"-"+userPhone3;
		
		int result = -1;
		
		if(userPw1.equals(userPw2)) {
			userPw = userPw1;
			
		}else {
			result = 3;
			response.getWriter().write(result+""); //비밀번호 다름
			return;
		}
		
		String url = "";
		
		if(userPw1 == null || userPw1.equals("") || userPw2 == null || userPw2.equals("")
				|| userEmail == null || userEmail.equals("") || userPhone1 == null || userPhone1.equals("")
				|| userPhone2 == null || userPhone2.equals("") || userPhone3 == null || userPhone3.equals("")) {
		
			result = 2;
			response.getWriter().write(result+""); //내용을 입력해주세요
			return;
		}
		NormalMemberDAO dao = NormalMemberDAO.getInstance();
		
		result = dao.memberModify(userId, userPw, userEmail, userPhone);

		if(result == 1) {
			response.getWriter().write("1"); //회원 수정 완료
		}else {
			response.getWriter().write("-1"); //회원 수정 실패
		}
		
	}

}
