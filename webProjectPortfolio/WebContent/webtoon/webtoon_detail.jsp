<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	ArrayList<String> view_img = (ArrayList<String>)request.getAttribute("view_img");//컨텐츠 이미지
	Elements author = (Elements)request.getAttribute("author");//작가+제목 elements 형태
	String site_title = (String)request.getAttribute("site_title");//사이트 상단 타이틀
	String titleId = (String)request.getParameter("titleId");//작가 고유id
	String weekday = (String)request.getParameter("weekday");//날짜
	String no = (String)request.getParameter("no");//회차 번호
	int num = Integer.parseInt(no);
	String detail_title = (String)request.getAttribute("detail_title");//회차 제목
	String pre = (String)request.getAttribute("pre");//이전
	String next = (String)request.getAttribute("next");//다음
	String date = (String)request.getAttribute("date");//등록일
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset=UTF-8>
<title>교육용 :: <%=site_title %></title>
<link rel="stylesheet" href="../css/reset.css" />
<script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script>
<style>

	
	
	.home_button a{
		position:fixed;
		right:100px;
		bottom:100px;
		font-size:11px;
		color:#fff;
		font-weight:700;
		width:50px;
		line-height:50px;
		border-radius:100%;
		background-color:#a670ea;
	}
	.webtoon_detail{
		position:relative;
		max-width:690px;
		width:100%;
		margin:0 auto;
	}
	.webtoon_detail .content{
	    padding: 20px 0;
    	text-align: center;
    	position:relative;
	}
	.webtoon_detail .content h2 {
	    padding: 30px 15px;
	    text-align: center;
	    font-size: 30px;
	    color: #a670ea;
	}
	.detail_view{
		line-height:0;
	}
	.webtoon_detail .btn_area{
		position:fixed;
		top:50%;
		transform:translateY(-50%);
		max-width:690px;
		width:100%;
	}
	
	.webtoon_detail .btn_area .pre{
		position:absolute;
		left:-100px;
	}
	.webtoon_detail .btn_area .next{
		position:absolute;
		right:-100px;
	}
</style>
</head>

<body>
<div class="webtoon_detail_wrap">
	<div class="webtoon_detail">
		<div class="btn_area">
			<a class="pre" href="detail.nhn?titleId=<%=titleId %>&no=<%=num-1 %>&weekday=<%=weekday %>" ><%=pre %></a>
			<a class="next" href="detail.nhn?titleId=<%=titleId %>&no=<%=num+1 %>&weekday=<%=weekday %>"><%=next %></a>
		</div>
		<div class="content">
			<div class="board_page_title">
				<%=author %>
			</div>
			<div class="webtoon_view">
				<div class="detail_head">
					<div class="head_left">
						<h4><%=detail_title %></h4>
						<span class="bar"></span>
						<span class="date">
							<%=date %>
						</span>
					</div>
				</div>
				<div class="detail_view">
					<% for(String img:view_img ){ %>
						<img src="<%=img %>" />
					<% } %>
				</div>
			</div>
			<div class="home_button">
				<a href="list.nhn?titleId=<%=titleId %>&weekday=<%=weekday %>">뒤로가기</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>