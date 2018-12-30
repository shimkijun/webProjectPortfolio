package org.web.chatController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.chatCommend.ChatAction;
import org.web.chatCommend.ChatList;
import org.web.chatCommend.ChatSubmit;



public class ChatController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doPost(request, response);
	
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf8");
		
		String URI = request.getRequestURI();
		String path = request.getContextPath();
		String subURI = URI.substring(path.length()+1,URI.length());
		String url = "";
		
		ChatAction action;
		if(subURI.equals("submit.ch")) {
			action = new ChatSubmit();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("chatList.ch")) {
			action = new ChatList();
			action.excuteAction(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
