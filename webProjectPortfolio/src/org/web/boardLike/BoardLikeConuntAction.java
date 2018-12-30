package org.web.boardLike;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardLikeConuntAction implements BoardLikeCommend{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		BoardLikeDAO dao = BoardLikeDAO.getInstance();
		
		
		int likeCount = dao.likeCount();
		System.out.println(likeCount);
		request.setAttribute("url","boardProView.jsp");
		request.setAttribute("likeCount",likeCount);
		
	}

	
	
}
