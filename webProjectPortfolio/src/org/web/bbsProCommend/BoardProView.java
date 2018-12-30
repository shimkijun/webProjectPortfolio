package org.web.bbsProCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;

public class BoardProView implements BoardProAction {

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int item_id = Integer.parseInt(request.getParameter("item_id"));
		String agent_name = request.getParameter("agent_name");
		BoardProDAO dao = BoardProDAO.getInstance();
		ArrayList<BoardDTO> result = dao.proView(item_id, agent_name);
	
		
		if(result != null) {
			response.getWriter().write("1");
		}else {
			response.getWriter().write("0");
		}
	
		
	}	
}
