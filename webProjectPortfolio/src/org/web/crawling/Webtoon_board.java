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
@WebServlet("/webtoon/list.nhn")
public class Webtoon_board extends HttpServlet{
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
		String titleId = (String)request.getParameter("titleId");
		String weekday = (String)request.getParameter("weekday");
		String num = (String)request.getParameter("page");
		
        String url = "https://comic.naver.com/webtoon/list.nhn?titleId="+titleId+"&weekday="+weekday+"&page="+num;
        Document doc = null;
        try {
            doc = Jsoup.connect(url).ignoreContentType(true).get();
        	String location = "webtoon_board.jsp";
        	String site_title = doc.select("title").text(); //사이트 타이틀
        	
        	Elements links = doc.select(".viewList tbody td.title a"); //상세 링크
        	Elements images = doc.select(".viewList tbody a img[title]");//title 값이 포함된 img src
        	Elements author = doc.select(".detail h2"); //제목 + 작가
        	Elements dates = doc.select("tbody td.num"); //작성일

        	
        	ArrayList<String> thumb_arr = new ArrayList<>();
        	ArrayList<String> title_arr = new ArrayList<>();
        	ArrayList<String> link_arr = new ArrayList<>();
        	ArrayList<String> date_arr = new ArrayList<>();
        	for(int i = 0; i < images.size(); i++ ) {
        		String img_src = images.get(i).attr("src");
        		String title = images.get(i).attr("title");
        		String a_link = links.get(i).attr("href");
        		String date = dates.get(i).text();
        		
        		thumb_arr.add(img_src);
        		title_arr.add(title);
        		link_arr.add(a_link);
        		date_arr.add(date);
        		
        	}
        	
        	Elements num_page = doc.select(".num_page"); //페이징 넘버
        	ArrayList<String> page_arr = new ArrayList<>();
        	for(int i = 0; i < num_page.size(); i++) {
        		String numbers = num_page.get(i).text();
        		page_arr.add(numbers);
        	}

        	request.setAttribute("thumb_arr", thumb_arr);//이미지+썸네일
        	request.setAttribute("title_arr", title_arr);//타이틀 + 회차
        	request.setAttribute("link_arr", link_arr);//회차 상세내용 이미지 링크
        	request.setAttribute("author", author);//웹툰 제목+작가
        	request.setAttribute("site_title", site_title);//사이트 타이틀
        	request.setAttribute("date_arr", date_arr);//작성일
        	request.setAttribute("page_arr", page_arr);//페이징 넘버


        	
        	RequestDispatcher dis = request.getRequestDispatcher(location);
        	dis.forward(request,response);
        	
        } catch (IOException e) {
            e.printStackTrace();
        }
        
	}

}
