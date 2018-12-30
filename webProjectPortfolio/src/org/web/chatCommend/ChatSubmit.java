package org.web.chatCommend;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.chatDAO.ChatDAO;


public class ChatSubmit implements ChatAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String fromId = request.getParameter("fromId");
		String toId = request.getParameter("toId");
		String chatContent = request.getParameter("chatContent");
	
		ChatDAO dao = ChatDAO.getInstance();
		PrintWriter json = response.getWriter();
		int result = dao.submit(fromId, toId, chatContent);
		if(result == 1) {
			json.write(result+"");
		}else {
			json.write(result+"");
		}

	}	

}
