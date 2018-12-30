<%@page import="org.web.adminDAO.ChatDAO"%>
<%@page import="org.web.chatDTO.ChatDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ChatDAO dao = ChatDAO.getInstance();
	ArrayList<ChatDTO> list = (ArrayList<ChatDTO>)request.getAttribute("msg_list");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset=UTF-8>
<script src="../js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<title>실시간 문의사항</title>
</head>
<style>
	.header{
		width:100%;
		height:50px;
		padding:0 20px;
		border-bottom:1px solid #ccc;
		line-height:50px;
		position:relative;
		background-color:#f76a0e;
	}
	.header::after{
		display:block;
		clear:both;
		content:"";
	}
	.header header{
		width:100%;
		height:100%;
	}
	.header .logo{
		height:100%;
		position:absolute;
		left:20px;
		top:0;
	}
	.header .logo h1{
		height: 100%;
	}
	.header .logo h1 a{
		display: block;
		height: 100%;
		color:#fff;
	}
	.header .logo img{
		width: 40px;
		margin-bottom:5px;
		vertical-align: middle;
	}
	.header .nav{
		float:right;
		font-size:14px;
	}
	
	.nav ul{
		float:left;
	}
	.nav ul > li{
		float:left;
	}
	
	.nav .gnb{
		font-size:14px;
		font-weight:700;
	}
	
	.nav .gnb li>a{
		color:#333;
		display:block;
		padding:0 15px;
	}
	.nav .gnb li{
		position:relative;
	}
	.nav .gnb li > span.gnbNew{
		width: 15px;
	    height: 15px;
	    line-height: 13px;
	    color: #fff;
	    text-align: center;
	    background-color: #ff4b25;
	    position: absolute;
	    right: 0;
	    top: 8px;
	    font-size: 10px;
	    display: inline-block;
	    border-radius: 3px;
	}
	.nav .members{
		margin-left:25px;
		position:relative;
	}
	.nav .members >li>a{
		font-size:13px;
		color:#fff;
		padding:0 5px;
		display:block;
	}
	
	.subMenu{
		width:140px;
		text-align:center;
		display:none;
		background-color:#efefef;
		font-size:12px;
		position:absolute;
		left:0;
	}
	
	.subMenu > li{
		width:100%;
		height:30px;
		line-height:30px;
	
	}
	.subMenu > li > a{
		color:#333;
		display:block;
	}
	.subMenu li a:hover{
		background-color:#f76a0e;
		color:#fff;
	}
	
	.userMenu:hover .subMenu{
		display:block;
	}
	
	.admin_side_menu{
		position: fixed;
	    left: 0;
	    width: 250px;
	    height: 100%;
	    border-right:1px solid #ccc;
	}
	
	.admin_side_menu ul{
		width:100%;
	}
	.side_menu{
		width:100%;
	}
	.side_menu > a{
		display:block;
		padding:10px 15px;
		font-size:14px;
		font-weight:700;
		color:#f76a0e;
		border-bottom:1px solid #ccc;
	}
	.sub_side_menu > li a{
		background-color:#efefef;
		display:block;
		padding:10px 15px;
		font-size:14px;
		font-weight:700;
		color:#f76a0e;
		border-bottom:1px solid #ccc;
	}
	
	.arrow{
		float:right;
	}
	.arrow.on{
		transform:rotate(180deg);
	}
	
	.sub_side_menu{
		display:none;
	}
	
	/* content */
	.section_wrap{
		padding-left:250px;
	}
	
	.section_wrap > .content{
		padding:20px;
	}
	.msg_wrap .msg_content{
 		padding:50px 0;
 	}
 	.msg_content ul{
	 	max-width:900px;
	 	width:100%;
 		border:1px solid #f76a0e;
 	}
 	.msg_content ul > li:first-child{
 		color:#fff;
 		font-weight:700;
 		background-color:#f76a0e;
 	}
 	.msg_content ul > li:first-child span{
 		border-right:1px solid #fff;
 		
 	}
 	
 	.msg_content ul > li:last-child{
 		border-bottom:0;
 	}
 	.msg_content ul > li{
 		font-size:14px;
 		width:100%;
 		border-bottom:1px solid #f76a0e;
 		height:36px;
 		position:relative;
 	}
 	
 	.msg_content ul li span{
 	white-space: nowrap; 
	  overflow: hidden;
	  text-overflow: ellipsis;
	  padding:7px;
 	  display:inline-block;
 	  height:100%;
 	  text-align:center;
 	}
 	.msg_content ul > li a >span{
 		border-right:1px solid #f76a0e;
 		font-size:12px;
 	}
 	span.msg_th_num,span.msg_num{
 		width:8%;
 	}
 	span.msg_th_fromId,span.msg_fromId{
 		width:13%;
 	}
 	span.msg_th_txt,span.msg_txt{
 		width:42%;
 	}
 	span.msg_th_time,span.msg_time{
 		width:20%;
 	}
 	span.msg_th_read,span.msg_read,span.msg_th_re,span.msg_re{
 		width:7%;
 	}
 	
 	.msg_content ul > li span:last-child {
		border-right:0 !important;
	}
	
	.msg_content ul li span.chatNew{
		position: absolute;
	    right: -50px;
	    top: 0;
	    font-size: 12px;
	    background-color: #f76a0e;
	    color: #fff;
	    padding: 2px 5px;
	    height: auto;
	    height: 16px;
	    overflow: initial;
	    line-height: 9px;
	    font-weight: 700;
		
	}
	.msg_content ul li span.chatNew::before{
	  display: block;
	    content: "";
	    position: absolute;
	    left: -10px;
	    top: 0px;
	    width: 0px;
	    height: 0px;
	    border-top: 8px solid transparent;
	    border-bottom: 8px solid transparent;
	    border-right: 10px solid #f76a0e;
	    border-left: 0;
	}
	
	.msg_content ul li span.unreadCount{
		float: right;
	    vertical-align: middle;
	    padding: 0;
	    margin: 0;
	    background: #f76a0e;
	    color: #fff;
	    width: 18px;
	    height: 17px;
	    border-radius: 100%;
    }
</style>
<body>
	<div class="admin_wrap">
		<div class="header">
			<header>
				<div class="logo">
					<h1>
						<a href="../index.jsp">
							<img src="../img/logo.jpg">
							LOGO
						</a>
					</h1>
				</div>
				<div class="nav">
					<nav>
						<ul class="members">
							<li class="userMenu">
								<a href="#none">
									관리자페이지 입니다.
								</a>
								<ul class="subMenu">
									<li>
										<a href="../index.jsp">home</a>
									</li>
								</ul>
							</li>
						</ul>
					</nav>
				</div>
			</header>
		</div>
		<div class="admin_side_menu">
			<ul>
				<li class="side_menu">
					<a href="adminChatList.ad">
						실시간문의
						<span class="arrow">
							<i class="fas fa-angle-down"></i>
						</span>
					</a>
				</li>
				<li class="side_menu">
					<a href="#none">
						menu2
						<span class="arrow">
							<i class="fas fa-angle-down"></i>
						</span>
					</a>
					<ul class="sub_side_menu">
						<li>
							<a href="#none">
								menu2 > sub1
							</a>
						</li>
						<li>
							<a href="#none">
								menu2 > sub2
							</a>
						</li>
						<li>
							<a href="#none">
								menu2 > sub3
							</a>
						</li>
					</ul>
				</li>
				<li class="side_menu">
					<a href="#none">
						menu3
						<span class="arrow">
							<i class="fas fa-angle-down"></i>
						</span>
					</a>
					<ul class="sub_side_menu">
						<li>
							<a href="#none">
								menu3 > sub1
							</a>
						</li>
						<li>
							<a href="#none">
								menu3 > sub2
							</a>
						</li>
						<li>
							<a href="#none">
								menu3 > sub3
							</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<div class="section_wrap">
		<div class="content">
			<div class="msg_wrap">
	<div class="msg_box">
		<div class="msg_title">
			<h4>실시간 문의사항</h4>
		</div>
		<div class="msg_content">
			<ul class="msg_list">
				<li>
					<span class="msg_th_num">
						번호
					</span>
					<span class="msg_th_fromId">
						아이디
					</span>
					<span class="msg_th_txt">
						내용
					</span>
					<span class="msg_th_time">
						시간
					</span>
					<span class="msg_th_read">
						읽음
					</span>
					<span class="msg_th_re">
						답변
					</span>
				</li>
			<% for(ChatDTO lili:list){ %>
				<% 
					if(!lili.getFromId().equals("admin")){ 
				%>
				<li>
					<% if(lili.getChatRead() == 0){ %>
						<span class="chatNew">new</span>
					<% } %>
					<a href="adminChatView.ad?fromId=<%=lili.getFromId() %>&toId=admin&chatId=<%=lili.getChatId() %>">
						<span class="msg_num">
							<%=lili.getChatId() %>
						</span>
						<span class="msg_fromId">
							<input type="hidden" value="" name="msg_fromId" />
							<%=lili.getFromId() %>
						</span>
						<span class="msg_txt">
							<%=lili.getChatContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "</br>") %>
							<% 
								int count = dao.getAllUnreadChat(lili.getFromId()); 
									if( count > 0){
								%>
								<span class="unreadCount">
								<%=count %>
								</span>
								<% } %>
						</span>
						<span class="msg_time">
							<%=lili.getChatTime() %>
						</span>
						<span class="msg_read">
							<% if(lili.getChatRead() == 0){ %>
							N
							<% }else{ %>
							Y
							<% } %>
						</span>
						<span class="msg_re">
							<% if(lili.getChatRe() == 0){ %>
							N
							<% }else{ %>
							Y
							<% } %>
						</span>
					</a>
				</li>
				<% }else{ %>
				
				<% } %>
		<% } %>
			</ul>
		</div>

	</div>
	</div>
		</div>
	</div>
<!-- admin_wrap -->
<script>
	$(function(){
		$(".admin_side_menu > ul > li > a:not(:animated)").click(function(){
			
			 var target = $(this).parent().children(".sub_side_menu:not(:animated)");
			 if(target.length > 0){
				$(target).slideToggle();
				$(this).children(".arrow:not(:animated)").toggleClass("on");
			 }
		});
	})
</script>
</body>

</html>