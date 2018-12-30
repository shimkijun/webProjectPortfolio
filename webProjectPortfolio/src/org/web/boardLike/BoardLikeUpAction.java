package org.web.boardLike;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardLikeUpAction implements BoardLikeCommend{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String likeUser = request.getParameter("likeUser"); //회원만 좋아요를 누를수 있으므로 login아이디를 검증하는 값
		int likeNum = Integer.parseInt(request.getParameter("likeNum")); //좋아요 를 눌렀는지 아닌지 확인하는 값 1,null
		int listNum = Integer.parseInt(request.getParameter("listNum"));//게시물 고유 number값
		
		System.out.println(likeUser);
		System.out.println("좋아요 ? = " +likeNum);
		System.out.println("게시판 번호" + listNum);
		
		BoardLikeDAO dao = BoardLikeDAO.getInstance();
		int result = dao.Like(listNum,likeUser,likeNum);
		response.getWriter().write(result+"");
		System.out.println(result);
	}

}
