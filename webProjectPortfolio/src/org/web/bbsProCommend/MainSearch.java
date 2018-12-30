package org.web.bbsProCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;


public class MainSearch implements BoardProAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String q = request.getParameter("q");
		
		BoardProDAO dao = BoardProDAO.getInstance();
		ArrayList<BoardDTO> result = dao.MainSearch(q);

		if(result.size() > 0) {
			response.getWriter().write(getList(q)+"");
		}else {
			response.getWriter().write("0");
		}
		
		
		
	}
	public String getList(String q) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		BoardProDAO dao = BoardProDAO.getInstance();
		ArrayList<BoardDTO> search =  dao.MainSearch(q);
		if(search.size() == 0) return "";
		for(int i = 0 ; i < search.size(); i++) {
			result.append("[{\"value\": \""+search.get(i).getPro_id() + "\"},");
			result.append("{\"value\": \""+search.get(i).getBusiness_name() + "\"}]");
			if(i != search.size() - 1) result.append(",");
		}
		result.append("]}"); 
		return result.toString();
	}
}
