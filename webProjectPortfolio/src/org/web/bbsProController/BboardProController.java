package org.web.bbsProController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProCommend.BoardAjaxMapList;
import org.web.bbsProCommend.BoardJsonLocation;
import org.web.bbsProCommend.BoardProAction;
import org.web.bbsProCommend.BoardProDetail;
import org.web.bbsProCommend.BoardProInsert;
import org.web.bbsProCommend.BoardProView;
import org.web.bbsProCommend.BoardSessionCart;
import org.web.bbsProCommend.BoardZzim;
import org.web.bbsProCommend.MainSearch;

@WebServlet("*.mp")
public class BboardProController extends HttpServlet{

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
		
		BoardProAction action;
		if(subURI.equals("mapInsert.mp")) {
			action = new BoardProInsert();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("location.mp")) {
			action = new BoardJsonLocation();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("scroll.mp")) {
			action = new BoardAjaxMapList();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("proView.mp")) {
			action = new BoardProView();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("proDetail.mp")) {
			action = new BoardProDetail();
			action.excuteAction(request, response);
			url = (String)request.getAttribute("url");
		}else if(subURI.equals("zzim.mp")) {
			action = new BoardZzim();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("sessionList.mp")) {
			action = new BoardSessionCart();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("mainSearch.mp")) {
			action = new MainSearch();
			action.excuteAction(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request,response);
	}
	
}
