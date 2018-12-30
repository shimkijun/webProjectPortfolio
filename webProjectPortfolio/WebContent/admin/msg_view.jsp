<%@page import="org.web.chatDTO.ChatDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	ArrayList<ChatDTO> chatView = (ArrayList<ChatDTO>)request.getAttribute("chatView");
 	String fromId = (String)request.getParameter("fromId");
 %>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset=UTF-8>
<script src="../js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<title>상담글 상세보기</title>
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
	
	.msg_content{
		max-width:900px;
		width:100%;
		background-color:#efefef;
		margin-top:20px;
		padding:10px;
		height: 700px;
		overflow-y: scroll;
	}

	.msg_view li::after,.msg_view::after{
		display:block;
		clear:both;
		content:"";
	}
	.msg_view li{
		margin-bottom:25px;
		font-size:14px;
	}
	.msg_view li > p{
		padding:5px;
	}
	.msg_view li.fromId{
		float:left;
		width:85%;
		
	}
	.msg_view li.toId{
		float:right;
		width:85%;
		
	}
	
	.msg_view li.fromId .view_list_text,.msg_view li.toId .view_list_text{
		width:100%;
		padding:10px;
		background-color:#fff;
		border-radius:25px;
		border:1px solid #ccc;
		font-weight:700;
	}
	.msg_view li.fromId .view_list_text{
		background-color:#f76a0e;
		color:#fff;
	}
	.msg_view li.toId .view_list_text{
		text-align:right;
	}
	.msg_view li.fromId .view_time,.msg_view li.toId .view_time{
		float:right;	
	}
	
	.msg_submit{
		max-width:900px;
		border:1px solid #999;
		padding:10px;
	}
	
	.msg_submit textarea{
		width:80%;
		height:50px;
		padding:15px;
		border:1px solid #ccc;
		resize: none;
		vertical-align: middle;
	}
	
	.msg_submit button{
	    width: 19%;
	    height: 50px;
	    border: 1px solid #ccc;
	    background-color: #f76a0e;
	    color: #fff;
	    font-weight: 700;
	    vertical-align: middle;
	   	cursor:pointer;
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
		<div class="msg_view">
			<div class="msg_title">
				<h4>상담보기</h4>
			</div>
			<div class="msg_content">
				<ul class="msg_view">
				<% 
					for(ChatDTO list:chatView){ 
						if(list.getFromId().equals("admin")){
				%>
					<li class="line toId">
						<p class="view_list_name">
							<span>
								<b>ID : </b><span class="getFromId"><%=list.getFromId() %></span>
							</span>
							<span class="view_time">
								<b>보낸날짜 : </b><%=list.getChatTime() %>
							</span>
						</p>
						<p class="view_list_text">
							<%=list.getChatContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "</br>") %>
						</p>
					</li>
				<% }else{ %>
					<li class="line fromId">
						<p class="view_list_name">
							<span>
								<b>ID : </b><span class="getFromId"><%=list.getFromId() %></span>
							</span>
							<span class="view_time">
								<b>보낸날짜 : </b><%=list.getChatTime() %>
							</span>
						</p>
						<p class="view_list_text">
							<%=list.getChatContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "</br>") %>
						</p>
					</li>
				<% 	
						}
					}
					%>
				</ul>
			</div>
			<div class="msg_submit">
					<textarea id="admin_submit" name="msg_submit"></textarea>
					<button id="admin_btn" type="button" onclick="submitFnc()">
						보내기
					</button>
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
	});
	function submitFnc(){
		var fromId = "admin";
		var toId = "<%=fromId %>";
		var chatContent = $("#admin_submit").val();
		$.ajax({
			type : "POST",
			url: "submit.ad",
			data : {
				fromId : fromId,
				toId : toId,
				chatContent : chatContent
			},
			success : function(result){
				if(result == 1){
					location.reload();
				}else if(result == -2){
					alert("내용을 입력하세요.");
				}
			}
			
		});
		$("#chatContent").val("");
	}
</script>
</body>

</html>