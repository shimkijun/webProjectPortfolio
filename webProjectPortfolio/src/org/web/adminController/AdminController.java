package org.web.adminController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.adminCommend.AdminAction;
import org.web.adminCommend.AdminLiveChatBox;
import org.web.adminCommend.AdminLiveChatSubmit;
import org.web.adminCommend.AdminLiveChatView;


@WebServlet("*.ad")
public class AdminController extends HttpServlet{

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
		System.out.println(subURI);
		AdminAction action;
		if(subURI.equals("admin/adminChatList.ad")) {
			action = new AdminLiveChatBox();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("admin/adminChatView.ad")) {
			action = new AdminLiveChatView();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("admin/submit.ad")) {
			action = new AdminLiveChatSubmit();
			action.excuteAction(request, response);
			return;
		}
		
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
