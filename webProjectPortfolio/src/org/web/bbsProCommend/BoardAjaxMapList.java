package org.web.bbsProCommend;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.web.bbsProDAO.BoardProDAO;
import org.web.bbsProDTO.BoardDTO;

public class BoardAjaxMapList implements BoardProAction{

	@Override
	public void excuteAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

			BoardProDAO dao = BoardProDAO.getInstance();
			response.getWriter().write(getJSON(0,100)+"");
		}
		
		public String getJSON(int start,int last){
			StringBuffer result = new StringBuffer("");
			result.append("{\"items\":[");
			BoardProDAO dao = BoardProDAO.getInstance();
			ArrayList<BoardDTO> lists = dao.getBbsList(start,last);
			for(int i = 0; i < lists.size(); i++) {
				
				result.append("[{\"item_id\":\""+lists.get(i).getPro_id()+"\"},"); //고유번호
				result.append("{\"agent_user\":\""+lists.get(i).getPro_userName()+"\"},"); //기업대표
				result.append("{\"agent_name\":\""+lists.get(i).getBusiness_name()+"\"},"); //기업이름
				result.append("{\"agent_comment\":\""+lists.get(i).getDetail_ex()+"\"},");//상세설명
				result.append("{\"agent_post\":\""+lists.get(i).getPostNum()+"\"},"); //기업우편번호
				result.append("{\"agent_address\":\""+lists.get(i).getBusiness_addr()+"\"},"); //기업주소
				result.append("{\"agent_address1\":\""+lists.get(i).getBusiness_addr1()+"\"},");//상세주소
				result.append("{\"agent_img\":\""+lists.get(i).getThumbnail_file()+"\"},"); //기업 썸네일이미지
				result.append("{\"agent_latY\":\""+lists.get(i).getLatY()+"\"},"); //기업 좌표y
				result.append("{\"agent_lntX\":\""+lists.get(i).getLngX()+"\"}]"); //x
					if(i != lists.size() - 1) result.append(",");
			}
			result.append("]}");
			return result.toString();
		}
		
	
}

