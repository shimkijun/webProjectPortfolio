package org.web.bbsCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.BoardDTO;

public class BoardModifyView implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int board_num = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO modifyView = dao.getModifyView(board_num);
		
		String url = "";
		if(modifyView != null) {
			url = "boardModify.jsp";
		}else {
			url = "boardList.bo";
		}
		request.setAttribute("url", url);
		request.setAttribute("modifyView",modifyView);
		
	}

}
