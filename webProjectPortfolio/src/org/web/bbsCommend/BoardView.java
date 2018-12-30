package org.web.bbsCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.BoardDTO;

public class BoardView implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int board_num = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.getHit(board_num);
		BoardDTO listView = dao.getListView(board_num);
		
		String url = "";
		if(listView != null) {
			url = "boardView.jsp";
		}else {
			url = "boardList.bo";
		}
		request.setAttribute("url", url);
		request.setAttribute("listView",listView);
		
	}

}
