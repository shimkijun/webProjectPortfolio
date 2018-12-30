package org.web.bbsCommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.AddDTO;


public class BoardAdd implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int addNum = Integer.parseInt(request.getParameter("addNum"));//해당 게시물 번호
		String userId = request.getParameter("addId");//담기 기능을 사용하는 유저 아이디
		String board_Id = request.getParameter("board_Id");//게시물의 작성자 아이디

		BoardDAO dao = BoardDAO.getInstance();
		AddDTO dto = dao.checkCart(addNum,userId,board_Id);
		int cartCount = dao.cartCount(userId);
		int result = 0;
			if(dto != null) {
				int checkNum = dto.getAddId();
				String checkUser = dto.getUserId();
				if(checkUser.equals(userId) || checkNum == addNum) {
					result = -1;
					response.getWriter().write(result+"");
					return;
				}
			}
			
		result = dao.addInsert(addNum, userId,board_Id);
		
		if(result == 1) {
			response.getWriter().write(result+"");
		}else {
			response.getWriter().write(result+"");
		}
		
		
	}

}
