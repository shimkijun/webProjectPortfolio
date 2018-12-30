package org.web.memberCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.memberDAO.NormalMemberDAO;

public class NormalMemberDelete implements NormalMemberAction{
	
	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			int result = -1;
			HttpSession session = request.getSession();
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");

			
			NormalMemberDAO dao = NormalMemberDAO.getInstance();
			result = dao.memberDelete(userId, userPw);

			if(result == 1) {
				session.invalidate();
				response.getWriter().write(result+"");
			}else if(result == 2){
				response.getWriter().write(result+"");
			}else {
				response.getWriter().write(result+"");
			}

			
		}
}
