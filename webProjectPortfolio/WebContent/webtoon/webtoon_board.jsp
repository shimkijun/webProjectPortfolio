<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<String> thumb_arr = (ArrayList<String>)request.getAttribute("thumb_arr");
	ArrayList<String> title_arr = (ArrayList<String>)request.getAttribute("title_arr");
	ArrayList<String> link_arr = (ArrayList<String>)request.getAttribute("link_arr");
	ArrayList<String> date_arr = (ArrayList<String>)request.getAttribute("date_arr");
	ArrayList<String> page_arr = (ArrayList<String>)request.getAttribute("page_arr");

	Elements author = (Elements)request.getAttribute("author");
	String site_title = (String)request.getAttribute("site_title");
	String titleId = (String)request.getParameter("titleId");
	String weekday = (String)request.getParameter("weekday");
	String page_num = (String)request.getParameter("page");
	
	if(page_num == null){
		page_num = "1";
	}
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
	.webtoon_board{
		width:500px;
		margin:0 auto;
	}
	.webtoon_board .content{
	    padding: 20px 15px;
    	text-align: center;
    	position:relative;
	}
	.webtoon_board h2 {
	    padding: 30px 15px;
	    text-align: center;
	    font-size: 30px;
	    color: #a670ea;
	}
	.webtoon_board ul{
		width:100%;
		padding:10px;
	}
	.webtoon_board ul::after{
		display:block;
		clear:both;
		content:"";
	}
	.webtoon_board ul li {
		width:50%;
		float:left;
		margin-bottom: 15px;
	}
	
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
	
	
	.paging_wrap a.active{
		color:#a670ea;
		font-weight:700;
		font-size:50px;
	}
</style>
</head>

<body>

<div class="webtoon_board_wrap">
	<div class="webtoon_board">
		<div class="board_page_title">
			<a href="webtoon/list.nhn?titleId=<%=titleId %>&weekday=<%=weekday %>" >
				<%=author %>
			</a>
		</div>
		
		<div class="content">
			<div class="paging_wrap">
				<% 
					for(int i = 0 ;i < page_arr.size();i++){
						if(page_arr.get(i).equals(page_num)){
				%>
					<a class="active" href="webtoon/list.nhn?titleId=<%=titleId %>&weekday=<%=weekday %>&page=<%=page_arr.get(i) %>"><%=page_arr.get(i) %></a>
				<% }else{ %>
					<a href="webtoon/list.nhn?titleId=<%=titleId %>&weekday=<%=weekday %>&page=<%=page_arr.get(i) %>"><%=page_arr.get(i) %></a>
				<%	
						}
					}
				%>
			</div>
			<ul>
			<%
				for(int i = 0;i < thumb_arr.size(); i++){
			%>
			<li>
				<a href="<%=link_arr.get(i) %>" title="<%=title_arr.get(i) %>">
					<p class="thumb">
						<img src="<%=thumb_arr.get(i) %>" />
					</p>
					<p class="title">
						<%=title_arr.get(i) %>
					</p>
					<p class="date">
						<strong>등록일</strong> : <%=date_arr.get(i) %>
					</p>
				</a>
			</li>
			<%
				}
			%>
			</ul>
			<div class="home_button">
				<a href="../weekday.nhn">뒤로가기</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>