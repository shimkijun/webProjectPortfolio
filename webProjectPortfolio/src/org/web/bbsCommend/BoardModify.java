package org.web.bbsCommend;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.BoardDTO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardModify implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//작성후 원래 페이지로 이동
	
		
		int fileSize = 5 * 1024 * 1024;

		String uploadPath = request.getServletContext().getRealPath("/bbsThum");

		MultipartRequest multi = new MultipartRequest
				(request,uploadPath,fileSize,"UTF-8",new DefaultFileRenamePolicy());
		
		HttpSession session = request.getSession();
		int num = Integer.parseInt(multi.getParameter("board_num")); //글번호
		
		String board_nick = multi.getParameter("board_nick"); //닉네임
		String board_pass = multi.getParameter("board_pass"); //비밀번호 매칭
		
		String subject = multi.getParameter("board_subject"); // 기존 글제목
		String content = multi.getParameter("board_content"); //기존 글내용
		String existFile = multi.getParameter("existring_file");//기존 파일
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO boardData = new BoardDTO();

		boardData.setBoard_num(num);
		boardData.setBoard_nick(board_nick);
		boardData.setBoard_pass(board_pass);
		boardData.setBoard_subject(subject);
		boardData.setBoard_content(content);

		Enumeration<String> fileNames = multi.getFileNames();
		if(fileNames.hasMoreElements()) {
			String fileName = fileNames.nextElement();
			String updateFile = multi.getFilesystemName(fileName);
			if(updateFile == null) { //수정시 새로운 파일을 첨부 안했다면 기존파일
				boardData.setBoard_file(existFile);	
			}else { //새로운 파일을 첨부했을 경우
				boardData.setBoard_file(updateFile);	
			}
		}
		int result = dao.boardModify(boardData);
		
		String url = "";
		if(result == 1) {
			url = "boardView.bo?no="+num;
			session.setAttribute("moSuccess", "수정 완료");
		}else {
			url = "boardModifyView.bo?no="+num;
			session.setAttribute("moWarning", "비밀번호가 틀립니다.");
		}
		request.setAttribute("url", url);
	}
}
