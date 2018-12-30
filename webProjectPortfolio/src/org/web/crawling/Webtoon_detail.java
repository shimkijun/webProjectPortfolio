package org.web.crawling;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
@WebServlet("/webtoon/detail.nhn")
public class Webtoon_detail extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf8");
		

		doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf8");
		String titleId = (String)request.getParameter("titleId");//작가id
		String weekday = (String)request.getParameter("weekday");//요일
		String no = (String)request.getParameter("no");//회차

        String url ="https://comic.naver.com/webtoon/detail.nhn?titleId="+titleId+"&no="+no+"&weekday="+weekday;
        Document doc = null;
         
        try {
            doc = Jsoup.connect(url).ignoreContentType(true).get();
        	String location = "webtoon_detail.jsp";
        	String site_title = doc.select("title").text(); //사이트 타이틀
        	Elements author = doc.select(".detail h2");//제목 + 작가
        	String detail_title = doc.select(".view h3").text();//회차 제목
        	String pre = doc.select(".btn_area .pre").text(); //이전
        	String next = doc.select(".btn_area .next").text(); //다음
        	String date = doc.select(".vote_lst dl.rt dd.date").text();//등록일
        	Elements images = doc.select(".view_area .wt_viewer img");
        	ArrayList<String> view_img = new ArrayList<>();
        	for(int i = 0; i < images.size(); i++ ) {
        		String img_src = images.get(i).attr("src");
        		view_img.add(img_src);

        	}
        	
        	request.setAttribute("view_img", view_img);//이미지 컨텐츠
        	request.setAttribute("author", author);//제목 + 작가
        	request.setAttribute("site_title", site_title);//사이트 타이틀
        	request.setAttribute("detail_title", detail_title);//회차 제목
        	request.setAttribute("pre", pre);//이전
        	request.setAttribute("next", next);//다음
        	request.setAttribute("date", date);//등록일
   
        	RequestDispatcher dis = request.getRequestDispatcher(location);
        	dis.forward(request,response);
        	
        } catch (IOException e) {
            e.printStackTrace();
        }
        
	}

}
