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


public class Webtoon_list extends HttpServlet{
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
		 // Jsoup를 이용해서 네이버 스포츠 크롤링
        String url = "https://comic.naver.com/webtoon/weekday.nhn";
        Document doc = null;
         
        try {
            doc = Jsoup.connect(url).ignoreContentType(true).get();
        	
        	//월요일
        	Elements day_mon = doc.select(".col_inner h4.mon").next();
        	Elements mon_images = day_mon.select(".thumb a img[title]");
        	Elements mon_aLinks = day_mon.select(".thumb a");
        	ArrayList<String> thumb_mon = new ArrayList<>();
        	ArrayList<String> href_mon = new ArrayList<>();
        	ArrayList<String> title_mon = new ArrayList<>();
        	for(int i = 0; i < mon_images.size();i++) {
        		String img_src = mon_images.get(i).attr("src");
        		String a_title = mon_images.get(i).attr("title");
        		String aTag_link = mon_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_mon.add(img_src);//이미지
        			title_mon.add(a_title);//타이틀
        			href_mon.add(aTag_link);//하이퍼링크
        		}
        	}
        	
        	//화요일
        	Elements day_tue = doc.select(".col_inner h4.tue").next();
        	Elements tue_images = day_tue.select(".thumb a img[title]");
        	Elements tue_aLinks = day_tue.select(".thumb a");
        	ArrayList<String> thumb_tue = new ArrayList<>();
        	ArrayList<String> title_tue = new ArrayList<>();
        	ArrayList<String> href_tue = new ArrayList<>();
        	for(int i = 0; i < tue_images.size();i++) {
        		String img_src = tue_images.get(i).attr("src");
        		String a_title = tue_images.get(i).attr("title");
        		String aTag_link = tue_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_tue.add(img_src);//이미지
        			title_tue.add(a_title);//타이틀
        			href_tue.add(aTag_link);//하이퍼링크
        		}
        	}

        	//수요일
        	Elements day_wed = doc.select(".col_inner h4.wed").next();
        	Elements wed_images = day_wed.select(".thumb a img[title]");
        	Elements wed_aLinks = day_wed.select(".thumb a");
        	ArrayList<String> thumb_wed = new ArrayList<>();
        	ArrayList<String> title_wed = new ArrayList<>();
        	ArrayList<String> href_wed = new ArrayList<>();
        	for(int i = 0; i < wed_images.size();i++) {
        		String img_src = wed_images.get(i).attr("src");
        		String a_title = wed_images.get(i).attr("title");
        		String aTag_link = wed_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_wed.add(img_src);
        			title_wed.add(a_title);//타이틀
        			href_wed.add(aTag_link);//하이퍼링크
        		}
        	}
        	
        	//목요일
        	Elements day_thu = doc.select(".col_inner h4.thu").next();
        	Elements thu_images = day_thu.select(".thumb a img[title]");
        	Elements thu_aLinks = day_thu.select(".thumb a");
        	ArrayList<String> thumb_thu = new ArrayList<>();
        	ArrayList<String> title_thu = new ArrayList<>();
        	ArrayList<String> href_thu = new ArrayList<>();
        	for(int i = 0; i < thu_images.size();i++) {
        		String img_src = thu_images.get(i).attr("src");
        		String a_title = thu_images.get(i).attr("title");
        		String aTag_link = thu_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_thu.add(img_src);
        			title_thu.add(a_title);//타이틀
        			href_thu.add(aTag_link);//하이퍼링크
        		}
        	}
        	
        	//금요일
        	Elements day_fri = doc.select(".col_inner h4.fri").next();
        	Elements fri_images = day_fri.select(".thumb a img[title]");
        	Elements fri_aLinks = day_fri.select(".thumb a");
        	ArrayList<String> thumb_fri = new ArrayList<>();
        	ArrayList<String> title_fri = new ArrayList<>();
        	ArrayList<String> href_fri = new ArrayList<>();
        	for(int i = 0; i < fri_images.size();i++) {
        		String img_src = fri_images.get(i).attr("src");
        		String a_title = fri_images.get(i).attr("title");
        		String aTag_link = fri_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_fri.add(img_src);
        			title_fri.add(a_title);//타이틀
        			href_fri.add(aTag_link);//하이퍼링크
        		}
        	}
        	
        	//토요일
        	Elements day_sat = doc.select(".col_inner h4.sat").next();
        	Elements sat_images = day_sat.select(".thumb a img[title]");
        	Elements sat_aLinks = day_sat.select(".thumb a");
        	ArrayList<String> thumb_sat = new ArrayList<>();
        	ArrayList<String> title_sat = new ArrayList<>();
        	ArrayList<String> href_sat = new ArrayList<>();
        	for(int i = 0; i < sat_images.size();i++) {
        		String img_src = sat_images.get(i).attr("src");
        		String a_title = sat_images.get(i).attr("title");
        		String aTag_link = sat_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_sat.add(img_src);
        			title_sat.add(a_title);//타이틀
        			href_sat.add(aTag_link);//하이퍼링크
        		}
        	}
        	
        	//일요일
        	Elements day_sun = doc.select(".col_inner h4.sun").next();
        	Elements sun_images = day_sun.select(".thumb a img[title]");
        	Elements sun_aLinks = day_sun.select(".thumb a");
        	ArrayList<String> thumb_sun = new ArrayList<>();
        	ArrayList<String> title_sun = new ArrayList<>();
        	ArrayList<String> href_sun = new ArrayList<>();
        	for(int i = 0; i < sun_images.size();i++) {
        		String img_src = sun_images.get(i).attr("src");
        		String a_title = sun_images.get(i).attr("title");
        		String aTag_link = sun_aLinks.get(i).attr("href");
        		if(img_src.contains("thumbnail")) {
        			thumb_sun.add(img_src);
        			title_sun.add(a_title);//타이틀
        			href_sun.add(aTag_link);//하이퍼링크
        		}
        	}
        	
        	String location = "webtoon_list.jsp";

        	//썸네일
        	request.setAttribute("thumb_mon", thumb_mon);//월
        	request.setAttribute("thumb_tue", thumb_tue);//화        	
        	request.setAttribute("thumb_wed", thumb_wed);//수       	
        	request.setAttribute("thumb_thu", thumb_thu);//목       	
        	request.setAttribute("thumb_fri", thumb_fri);//금       	
        	request.setAttribute("thumb_sat", thumb_sat);//토        	
        	request.setAttribute("thumb_sun", thumb_sun);//일    
        	
        	//링크
        	request.setAttribute("href_mon", href_mon);//월
        	request.setAttribute("href_tue", href_tue);
        	request.setAttribute("href_wed", href_wed);
        	request.setAttribute("href_thu", href_thu);
        	request.setAttribute("href_fri", href_fri);
        	request.setAttribute("href_sat", href_sat);
        	request.setAttribute("href_sun", href_sun);
        	//타이틀
        	request.setAttribute("title_mon", title_mon);//월
        	request.setAttribute("title_tue", title_tue);
        	request.setAttribute("title_wed", title_wed);
        	request.setAttribute("title_thu", title_thu);
        	request.setAttribute("title_fri", title_fri);
        	request.setAttribute("title_sat", title_sat);
        	request.setAttribute("title_sun", title_sun);
        	
        	RequestDispatcher dis = request.getRequestDispatcher(location);
        	dis.forward(request,response);
        	
        } catch (IOException e) {
            e.printStackTrace();
        }
        
	}

}
