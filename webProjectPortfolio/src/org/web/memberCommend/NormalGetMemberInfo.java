package org.web.memberCommend;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.memberDAO.NormalMemberDAO;
import org.web.memberDTO.NormalMemberDTO;

public class NormalGetMemberInfo implements NormalMemberAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			HttpSession session = request.getSession();
		
			String userId = (String)session.getAttribute("sessionId");
			if(userId == null) {
				response.sendRedirect("index.jsp");
			}else {
				PrintWriter out = response.getWriter();
				out.write(getJSON(userId)+"");
			}
		}
	
		public String getJSON(String userId) {
			if(userId == null) userId="";
			NormalMemberDAO dao = NormalMemberDAO.getInstance();
			NormalMemberDTO member = dao.getUserInfo(userId);
			StringBuffer result = new StringBuffer();
			result.append("{\"result\":[");
					result.append("{\"value\":\""+member.getUserEmail()+"\"},");
					result.append("{\"value\":\""+member.getUserPhone()+"\"}");
			result.append("]}");
			return result.toString();
		}
}
