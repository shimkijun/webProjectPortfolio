package org.web.bbsProCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;
import org.web.bbsProDTO.ZzimDTO;


public class BoardProDetail implements BoardProAction {

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		int item_id = Integer.parseInt(id);
		String agent_name = request.getParameter("agent_name");
		BoardProDAO dao = BoardProDAO.getInstance();
		//찜 한 상태인지 확인
		String userId = (String)session.getAttribute("sessionId");
		ZzimDTO zzimChk = dao.zzimCount(item_id, userId, agent_name);

		
		ArrayList<BoardDTO> view = dao.proView(item_id, agent_name);
		String url = "";
		
		//JSON OBJECT 
		JSONObject JSONob = new JSONObject();
		
		JSONArray itemArr = new JSONArray();
		
		JSONObject itemOb = new JSONObject();
		
		itemOb.put("id", view.get(0).getPro_id());
		itemOb.put("user", view.get(0).getPro_userName());
		itemOb.put("name", view.get(0).getBusiness_name());
		itemOb.put("ex", view.get(0).getDetail_ex());
		itemOb.put("address", view.get(0).getBusiness_addr());
		itemOb.put("img", view.get(0).getThumbnail_file());
		itemArr.add(itemOb);

		String str = itemArr.toJSONString();
		ArrayList<String> sessionList = (ArrayList)session.getAttribute("sessionList");
		if(sessionList == null) {
			sessionList = new ArrayList<>();
			session.setAttribute("sessionList", sessionList);
		}
		sessionList.add(str);
		
		
		String items = "{\"lists\":"+sessionList+"}";
		
			
		if(view != null) {
			url = "boardProView.jsp";
		}else {
			url = "index.jsp";
		}

		request.setAttribute("view",view);
		request.setAttribute("url",url);
		request.setAttribute("zzimChk",zzimChk);
		session.setAttribute("items",items);
		
	}

	
	
}
