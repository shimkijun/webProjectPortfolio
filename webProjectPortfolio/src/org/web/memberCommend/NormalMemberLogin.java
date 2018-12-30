package org.web.memberCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.memberDAO.NormalMemberDAO;

public class NormalMemberLogin implements NormalMemberAction{
	
	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			int result = -1;
			HttpSession session = request.getSession();
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			
			if(userId == null || userId.equals("") || userPw == null || userPw.equals("")) {
				result = 3;
				response.getWriter().write(result+"");
			}
			
			
			
			NormalMemberDAO dao = NormalMemberDAO.getInstance();
			result = dao.memberLogin(userId, userPw);
			
			if(result == 1) {
				session.setAttribute("sessionId", userId);
				response.getWriter().write(result+"");
				session.removeAttribute("items");
				session.removeAttribute("sessionList");
				if(userId.equals("admin")) {
					session.setAttribute("sessionId", "admin");
				}
			}else if(result == 2){
				response.getWriter().write(result+"");
			}else {
				response.getWriter().write(result+"");
			}
			
			
		}
}
