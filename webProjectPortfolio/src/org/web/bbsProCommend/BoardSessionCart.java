package org.web.bbsProCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class BoardSessionCart implements BoardProAction {

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			HttpSession session = request.getSession();
			
			String test = (String)session.getAttribute("test");
			
			if(test != null) {
				response.getWriter().write(test+"");
			}
	}
}
