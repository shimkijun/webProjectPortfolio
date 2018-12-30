<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//썸네일
	ArrayList<String> mon_images = (ArrayList<String>)request.getAttribute("thumb_mon");
	ArrayList<String> tue_images = (ArrayList<String>)request.getAttribute("thumb_tue");
	ArrayList<String> wed_images = (ArrayList<String>)request.getAttribute("thumb_wed");
	ArrayList<String> thu_images = (ArrayList<String>)request.getAttribute("thumb_thu");
	ArrayList<String> fri_images = (ArrayList<String>)request.getAttribute("thumb_fri");
	ArrayList<String> sat_images = (ArrayList<String>)request.getAttribute("thumb_sat");
	ArrayList<String> sun_images = (ArrayList<String>)request.getAttribute("thumb_sun");

	
	//링크
	ArrayList<String> href_mon = (ArrayList<String>)request.getAttribute("href_mon");
	ArrayList<String> href_tue = (ArrayList<String>)request.getAttribute("href_tue");
	ArrayList<String> href_wed = (ArrayList<String>)request.getAttribute("href_wed");
	ArrayList<String> href_thu = (ArrayList<String>)request.getAttribute("href_thu");
	ArrayList<String> href_fri = (ArrayList<String>)request.getAttribute("href_fri");
	ArrayList<String> href_sat = (ArrayList<String>)request.getAttribute("href_sat");
	ArrayList<String> href_sun = (ArrayList<String>)request.getAttribute("href_sun");
	
	
	//타이틀
	ArrayList<String> title_mon = (ArrayList<String>)request.getAttribute("title_mon");
	ArrayList<String> title_tue = (ArrayList<String>)request.getAttribute("title_tue");
	ArrayList<String> title_wed = (ArrayList<String>)request.getAttribute("title_wed");
	ArrayList<String> title_thu = (ArrayList<String>)request.getAttribute("title_thu");
	ArrayList<String> title_fri = (ArrayList<String>)request.getAttribute("title_fri");
	ArrayList<String> title_sat = (ArrayList<String>)request.getAttribute("title_sat");
	ArrayList<String> title_sun = (ArrayList<String>)request.getAttribute("title_sun");
	
%>
<!DOCTYPE html>
<link rel="stylesheet" href="css/reset.css" />
<html>
<head>
<meta charset="UTF-8">
<title>교육용 웹툰 크롤링</title>
<link rel="stylesheet" href="../css/reset.css" />
<script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script>
<style>
	.list_page_title h2{
		padding:30px 15px;
		text-align:center;
		font-size:30px;
		color:#a670ea;
	}
	
	.list_wrap{
		padding:20px 15px;
		text-align:center;
	}
	.webtoon_day_list{
		display:inline-block;
	}
	.webtoon_day_list h4{
		text-align:center;
		font-size:14px;
		padding:5px 0;
		color:#a670ea;
	}
	.webtoon_day_list div.line.active h4{
		color:#fff;
	}
	.webtoon_day_list::after{
		display:block;
		clear:both;
		content:"";
	}
	.webtoon_day_list div.line{
		float:left;
		padding:5px;
	}
	div.line.active{
		background-color:#333;
	}
	 div.line li{
	 	margin-bottom:5px;
	 }
	div.line p.thumb{
		line-height:0;
	}
	div.line p.title{
		font-size:11px;
		padding:3px 0;
		width:85px;
		white-space: nowrap; 
	    overflow: hidden;
	    text-overflow: ellipsis;
	}
	
	div.line.active p.title{
		color:#fff;
	}
</style>
</head>

<body>
<div class="list_page_title">
	<h2>
		웹툰 보기
	</h2>
</div>
<div class="list_wrap">
	<div class="webtoon_day_list">
		<div class="line">
			<h4>월요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < mon_images.size();i++){ %>
				<li>
					<a href="<%=href_mon.get(i) %>" title="<%=title_mon.get(i) %>">
						<p class="thumb"><img src="<%=mon_images.get(i) %>" /></p>
						<p class="title"><%=title_mon.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
		<div class="line">
			<h4>화요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < tue_images.size();i++){ %>
				<li>
					<a href="<%=href_tue.get(i) %>" title="<%=title_tue.get(i) %>">
						<p class="thumb"><img src="<%=tue_images.get(i) %>" /></p>
						<p class="title"><%=title_tue.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
		<div class="line">
			<h4>수요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < wed_images.size();i++){ %>
				<li>
					<a href="<%=href_wed.get(i) %>" title="<%=title_wed.get(i) %>">
						<p class="thumb"><img src="<%=wed_images.get(i) %>" /></p>
						<p class="title"><%=title_wed.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
		<div class="line">
			<h4>목요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < thu_images.size();i++){ %>
				<li>
					<a href="<%=href_thu.get(i) %>" title="<%=title_thu.get(i) %>">
						<p class="thumb"><img src="<%=thu_images.get(i) %>" /></p>
						<p class="title"><%=title_thu.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
		<div class="line">
			<h4>금요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < fri_images.size();i++){ %>
				<li>
					<a href="<%=href_fri.get(i) %>" title="<%=title_fri.get(i) %>">
						<p class="thumb"><img src="<%=fri_images.get(i) %>" /></p>
						<p class="title"><%=title_fri.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
		<div class="line">
			<h4>토요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < sat_images.size();i++){ %>
				<li>
					<a href="<%=href_sat.get(i) %>" title="<%=title_sat.get(i) %>">
						<p class="thumb"><img src="<%=sat_images.get(i) %>" /></p>
						<p class="title"><%=title_sat.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
		<div class="line">
			<h4>일요웹툰</h4>
			<ul>
			<% for(int i = 0 ;i < sun_images.size();i++){ %>
				<li>
					<a href="<%=href_sun.get(i) %>" title="<%=title_sun.get(i) %>">
						<p class="thumb"><img src="<%=sun_images.get(i) %>" /></p>
						<p class="title"><%=title_sun.get(i) %></p>
					</a>
				</li>
			<% } %>
			</ul>
		</div>
	</div>
</div>
<script>
var d = new Date();
var n = d.getDay();
//getDay() method == 0~6; 0=월 ~ 6=토 
var week = ["일","월","화","수","목","금","토"];

if(n == 1){
	$(".webtoon_day_list > div").eq(0).addClass("active");
}else if(n == 2){
	$(".webtoon_day_list > div").eq(1).addClass("active");
}else if(n == 3){
	$(".webtoon_day_list > div").eq(2).addClass("active");
}else if(n == 4){
	$(".webtoon_day_list > div").eq(3).addClass("active");
}else if(n == 5){
	$(".webtoon_day_list > div").eq(4).addClass("active");
}else if(n == 6){
	$(".webtoon_day_list > div").eq(5).addClass("active");
}else if(n == 0){
	$(".webtoon_day_list > div").eq(6).addClass("active");
}

</script>
</body>
</html>