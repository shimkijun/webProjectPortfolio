package org.web.memberController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.memberCommend.NormalGetMemberInfo;
import org.web.memberCommend.NormalMemberAction;
import org.web.memberCommend.NormalMemberCheck;
import org.web.memberCommend.NormalMemberDelete;
import org.web.memberCommend.NormalMemberLogin;
import org.web.memberCommend.NormalMemberLogout;
import org.web.memberCommend.NormalMemberModify;
import org.web.memberCommend.NormalMemberRegister;


public class MemberController extends HttpServlet {
	
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
		
		NormalMemberAction action;
		String url = "";
		System.out.println(subURI);
		
		if(subURI.equals("normalRegister.do")) {
			action = new NormalMemberRegister();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("normalIdCheck.do")) {
			action = new NormalMemberCheck();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("normalLogin.do")) {
			action = new NormalMemberLogin();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("memberLogout.do")) {
			action = new NormalMemberLogout();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("getMember.do")) {
			action = new NormalGetMemberInfo();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("memberModify.do")) {
			action = new NormalMemberModify();
			action.excuteAction(request, response);
			return;
		}else if(subURI.equals("memberDelete.do")) {
			action = new NormalMemberDelete();
			action.excuteAction(request, response);
			return;
		}

		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}
	
}
