package org.web.bbsProCommend;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;

public class BoardJsonLocation implements BoardProAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//json 객체 생성
		JSONObject jobj = new JSONObject();
		
		BoardProDAO dao = BoardProDAO.getInstance();
		
		ArrayList<BoardDTO> locations = dao.getLocation();
		
		//좌표의 객채를 담아줄 arry 생성
		JSONArray locArray = new JSONArray();

		for(int i = 0;i < locations.size();i++) {
			JSONObject latlng = new JSONObject();
			latlng.put("lat",locations.get(i).getLatY());
			latlng.put("lng",locations.get(i).getLngX());
			latlng.put("item_id",locations.get(i).getPro_id());
			locArray.add(latlng);
		}
		jobj.put("positions", locArray);
		
		String info = jobj.toJSONString();
		String uploadPath = request.getServletContext().getRealPath("/json");
		String path = uploadPath+"/location.json";
		FileWriter file = new FileWriter(path);
		file.write(jobj.toJSONString());
		file.flush();
		file.close();
		
		String url = "";
		if(locations != null) {
			url = "boardProList.jsp";
		}else {
			System.out.println("no");
		}
		request.setAttribute("url", url);
	}


}
