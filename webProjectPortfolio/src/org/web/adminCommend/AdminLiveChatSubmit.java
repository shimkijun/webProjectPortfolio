package org.web.adminCommend;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.adminDAO.ChatDAO;



public class AdminLiveChatSubmit implements AdminAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String fromId = request.getParameter("fromId");
		String toId = request.getParameter("toId");
		String chatContent = request.getParameter("chatContent");
		PrintWriter json = response.getWriter();
		
		if(chatContent.equals("") || chatContent == null) {
			json.write("-2");
			return;
		}
		
		ChatDAO dao = ChatDAO.getInstance();
		
		dao.reChat(fromId, toId);
		int result = dao.submit(fromId, toId, chatContent);
		if(result == 1) {
			json.write(result+"");
		}else {
			json.write(result+"");
		}

	}	

}
