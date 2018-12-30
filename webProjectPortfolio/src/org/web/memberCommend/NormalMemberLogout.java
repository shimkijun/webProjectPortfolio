package org.web.memberCommend;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NormalMemberLogout implements NormalMemberAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("sessionId");
		PrintWriter out = response.getWriter();
		String url = "";
		if(sessionId != null) {
			session.invalidate();
			out.write("1");
		}else {
			session.setAttribute("sessionId", sessionId);
		}
	}

}
