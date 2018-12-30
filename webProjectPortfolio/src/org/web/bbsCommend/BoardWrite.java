package org.web.bbsCommend;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.BoardDTO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardWrite implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int fileSize = 5 * 1024 * 1024;
		String uploadPath = request.getServletContext().getRealPath("/bbsUpload");

		MultipartRequest multi = new MultipartRequest
				(request,uploadPath,fileSize,"UTF-8",new DefaultFileRenamePolicy());
		
		String fileName = "";
		Enumeration<String> names = multi.getFileNames();
		if(names.hasMoreElements()) {
			String name = names.nextElement();
			fileName = multi.getFilesystemName(name);
		}
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO boardData = new BoardDTO();
		
		boardData.setBoard_num(dao.getNum()+1);
		boardData.setBoard_id(multi.getParameter("board_id"));//로그인 일시 아이디 값
		boardData.setBoard_nick(multi.getParameter("board_nick"));
		boardData.setBoard_pass(multi.getParameter("board_pass"));
		boardData.setBoard_subject(multi.getParameter("board_subject"));
		boardData.setBoard_content(multi.getParameter("board_content"));
		boardData.setBoard_file(fileName);
		
		boolean result = dao.boardInsert(boardData);
		
		String url = "";
		if(result) {
			url = "boardList.bo";
			System.out.println("성공");
		}else {
			url = "index.jsp";
			System.out.println("실패");
		}
		request.setAttribute("url", url);		
	}
}
