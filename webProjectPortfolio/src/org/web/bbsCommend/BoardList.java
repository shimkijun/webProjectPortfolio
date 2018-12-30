package org.web.bbsCommend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsDAO.BoardDAO;
import org.web.bbsDTO.BoardDTO;

public class BoardList implements BoardAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//현재 페이지 설정
		int spage = 1;
		String page = request.getParameter("page");
		
		int listCount = 10;//한 페이지에 보여질 게시물 개수(상수)
		
		
		//페이지가 있다면 page 값을 int형으로 형변환
		if(page != null) {
			spage = Integer.parseInt(page);
		}

		//검색 조건과 검색 내용을 가져온다.
		String opt = request.getParameter("opt"); //옵션 ={제목,내용,...}
		String condition = request.getParameter("condition");//검색어={..}
		
		//검색 조건과 내용을 map 값에 담아준다
		HashMap<String, Object> listOpt = new HashMap<String,Object>();
		listOpt.put("opt",opt);
		listOpt.put("condition",condition);
	
		listOpt.put("start",((spage-1)*listCount));
		//현재 보여질 게시물 개수 20
		// start=1 ~ listCount =20; 1부터20까지 의 게시물 출력

		listOpt.put("listCount",listCount);
		BoardDAO dao = BoardDAO.getInstance();
		//모든 게시물 게수 check 
		int boardAllCount = dao.getListCount(listOpt);
		//모든 게시물 출력
		ArrayList<BoardDTO> list = dao.getBbsList(listOpt);
		
		//전체 페이지 수
		int maxPage = (int)boardAllCount/listCount;
		//모든 게시물 % 페이지당 출력 개수 의 나머지값이 0 보다 크면 전체 페이지수를 +1 해준다.
		if(boardAllCount%listCount > 0) {
			maxPage++;
		}
		int startPage = 1;
		int endPage = maxPage;
		
		request.setAttribute("spage", spage); //현재 페이지 번호
		request.setAttribute("maxPage", maxPage); //모든 페이지 개수
		request.setAttribute("startPage", startPage); //시작 페이지
		request.setAttribute("endPage", endPage); //마지막
		request.setAttribute("boardAllCount", boardAllCount); //모든 게시물 개수
		
		String url = "";
		if(list != null) {
			url = "boardList.jsp";
	
		}else {
			url = "index.jsp";
		}
		request.setAttribute("url", url);
		request.setAttribute("list", list);
		
	}

}
