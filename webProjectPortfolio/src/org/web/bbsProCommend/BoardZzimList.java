package org.web.bbsProCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;
import org.web.bbsProDTO.ZzimDTO;

public class BoardZzimList implements BoardProAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userId = request.getParameter("zzimId");
		
		BoardProDAO dao = BoardProDAO.getInstance();
		
		ArrayList<ZzimDTO> dto = dao.zzimCheck(userId);
		
	}

}
