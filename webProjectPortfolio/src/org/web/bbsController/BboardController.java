package org.web.bbsController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsCommend.BoardAction;
import org.web.bbsCommend.BoardAdd;
import org.web.bbsCommend.BoardAddList;
import org.web.bbsCommend.BoardDelete;
import org.web.bbsCommend.BoardDeleteView;
import org.web.bbsCommend.BoardList;
import org.web.bbsCommend.BoardModify;
import org.web.bbsCommend.BoardModifyView;
import org.web.bbsCommend.BoardReplyView;
import org.web.bbsCommend.BoardReplyWrite;
import org.web.bbsCommend.BoardView;
import org.web.bbsCommend.BoardWrite;

public class BboardController extends HttpServlet{

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
		BoardAction action;
		if(subURI.equals("boardWrite.bo")) {
			action = new BoardWrite();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardList.bo")) {
			action = new BoardList();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardView.bo")) {
			action = new BoardView();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardModifyView.bo")) {
			action = new BoardModifyView();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardModify.bo")) {
			action = new BoardModify();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardDeleteView.bo")) {
			action = new BoardDeleteView();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardDelete.bo")) {
			action = new BoardDelete();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardReplyView.bo")) {
			action = new BoardReplyView();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardReply.bo")) {
			action = new BoardReplyWrite();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("boardAdd.bo")) {
			action = new BoardAdd();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("addList.bo")) {
			action = new BoardAddList();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
