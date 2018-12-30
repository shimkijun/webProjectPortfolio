package org.web.bbsProCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.ZzimDTO;

public class BoardZzim implements BoardProAction {

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int item_id = Integer.parseInt(request.getParameter("item_id"));
		String agent_name = request.getParameter("agent_name");
		String userId = request.getParameter("loginId");
		String pro_userName = request.getParameter("pro_userName");

		BoardProDAO dao = BoardProDAO.getInstance();
		int result = 0;

		if (userId.equals("null") || userId == null || userId.equals("")) {
			result = -1;
			response.getWriter().write(result + "");
			return;
		}

		ZzimDTO zzimList = dao.zzimCancelChek(item_id, userId, agent_name);

		int zzimId = zzimList.getId();
		String zzimUser = zzimList.getUserId();
		String zzimAgent = zzimList.getAgent_name();

		if (zzimId == item_id) {
			dao.zzimOut(item_id, userId, agent_name);
			response.getWriter().write("0");
			return;
		}

		result = dao.zzimInsert(item_id, userId, pro_userName, agent_name);
		if (result == 1) {
			response.getWriter().write(result + "");
		}

	}

}
