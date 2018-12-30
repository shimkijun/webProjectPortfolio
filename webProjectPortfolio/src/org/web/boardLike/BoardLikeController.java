package org.web.boardLike;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.li")
public class BoardLikeController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf8");
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
		
		BoardLikeCommend action;
		if(subURI.equals("likeUpDown.li")) {
			action = new BoardLikeUpAction();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("likeView.li")) {
			action = new BoardLikeConuntAction();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
