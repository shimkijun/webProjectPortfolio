package org.web.bbsProCommend;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardProInsert implements BoardProAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url = "";
		int fileSize = 5 * 1024 * 1024;
		String uploadPath = request.getServletContext().getRealPath("/bbsThum");
		BoardDTO dto = new BoardDTO();
		MultipartRequest multi = new MultipartRequest
				(request,uploadPath,fileSize,"UTF-8",new DefaultFileRenamePolicy());

		String thumbnail_file = "";
		Enumeration<String> names = multi.getFileNames();
		if(names.hasMoreElements()) {
			String name = names.nextElement();
			thumbnail_file = multi.getFilesystemName(name);
		}
	
		BoardProDAO dao = BoardProDAO.getInstance();
		String pro_userName = (String)multi.getParameter("pro_userName");
		String business_name = (String)multi.getParameter("business_name");
		String detail_ex = (String)multi.getParameter("detail_ex");
		String postNumSrt = (String)multi.getParameter("postNum");
		int postNum = Integer.parseInt(postNumSrt);
		String business_addr = (String)multi.getParameter("business_addr");
		String business_addr1 = (String)multi.getParameter("business_addr1");
		String latY = (String)multi.getParameter("LatY");
		String lngX = (String)multi.getParameter("LngX");
		
		if(thumbnail_file == null) {
			thumbnail_file = "noImg.gif";
		}
		
		
		System.out.println(dao.getNum());
		dto.setPro_id(dao.getNum()+1);
		dto.setPro_userName(pro_userName);
		dto.setBusiness_name(business_name);
		dto.setPostNum(postNum);
		dto.setBusiness_addr(business_addr);
		dto.setBusiness_addr1(business_addr1);
		dto.setDetail_ex(detail_ex);
		dto.setThumbnail_file(thumbnail_file);
		dto.setLatY(latY);
		dto.setLngX(lngX);
		
		int result = dao.mapInsert(dto);
		if(result == 1) {
			System.out.println("성공");
			url = "index.jsp";
		}else {
			System.out.println("실패");
			url = "index.jsp";
		}
		
		request.setAttribute("url", url);
		
	}

}
