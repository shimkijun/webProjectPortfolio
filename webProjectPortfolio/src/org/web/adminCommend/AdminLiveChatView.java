package org.web.adminCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.adminDAO.ChatDAO;
import org.web.chatDTO.ChatDTO;


public class AdminLiveChatView implements AdminAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fromId = request.getParameter("fromId");
		String toId = request.getParameter("toId");
		
		ChatDAO dao = ChatDAO.getInstance();
		dao.readChat(fromId, toId);
		ArrayList<ChatDTO> chatView = dao.getChatListById(fromId, toId);

		String url = "";
		if(chatView != null) {
			url = "msg_view.jsp";
			
		}else {
			url="index.jsp";
		}
		
		request.setAttribute("url",url);
		request.setAttribute("chatView", chatView);
		
		
		
	}
	
	

}
