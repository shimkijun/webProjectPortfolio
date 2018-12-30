package org.web.memberCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.memberDAO.NormalMemberDAO;

public class NormalMemberCheck implements NormalMemberAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	String userId = request.getParameter("userId");
			
			NormalMemberDAO dao = NormalMemberDAO.getInstance();
			int result = dao.memberIdCheck(userId);
			
			if(result == 1) {
				response.getWriter().write(result+"");
			}else {
				response.getWriter().write(result+"");
			}
		}

}
