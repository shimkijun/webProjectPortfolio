package org.web.adminCommend;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.adminDAO.ChatDAO;
import org.web.chatDTO.ChatDTO;

public class AdminLiveChatBox implements AdminAction {
	
	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ChatDAO dao = ChatDAO.getInstance();
		ArrayList<ChatDTO> list = dao.getList();
	
		request.setAttribute("msg_list",list);
		request.setAttribute("url","msg_box.jsp");
		
	}
	
}
