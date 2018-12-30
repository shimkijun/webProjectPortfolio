package org.web.bbsCommend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.AddDTO;
import org.web.bbsDTO.BoardDTO;

public class BoardAddList implements BoardAction{
	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String userId = request.getParameter("userId");//담기 기능을 사용하는 유저 아이디
		BoardDAO dao = BoardDAO.getInstance();
		int cartCount = dao.cartCount(userId);
		ArrayList<AddDTO> result = null;
		String url = "";
		if(userId.equals("null")) {
			request.setAttribute("url","index.jsp");
			return;
		}
		result = dao.cartList(userId);
		HashMap<String, Object> listOpt = null;
		ArrayList<BoardDTO> addList = null;
		BoardDTO list = null;
		for(int i = 0; i < result.size(); i++) {
			listOpt =  new HashMap<String,Object>();	
			listOpt.put("addId",result.get(i).getAddId());
			listOpt.put("board_Id",result.get(i).getBoard_Id());
			list =  dao.getCartList(listOpt);
			addList = new ArrayList<BoardDTO>();
		}
		if(result != null) {
			url = "AddList.jsp";
		}else {
			url = "index.jsp";
		}
		
		request.setAttribute("url",url);
		request.setAttribute("cartCount", cartCount);
	}
}
