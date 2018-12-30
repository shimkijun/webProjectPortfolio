<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset=UTF-8>
<title>포트폴리오</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous">
<link rel="stylesheet" href="<%=path %>/css/reset.css" />
<link rel="stylesheet" href="<%=path %>/css/header.css" />
<link rel="stylesheet" href="<%=path %>/css/boardProView.css" />
<script src="<%=path %>/js/jquery-3.3.1.js"></script>
</head>
<body>
<% if(sessionId == null){ %>
	<input type="hidden" name="guestUser" value="<%=guest %>" />
<% }else if(sessionId != null){ %>
	<input type="hidden" name="guestUser" value="<%=sessionId %>" />
<% } %>
<%@ include file="userJoin.jsp" %>
<%@ include file="userLogin.jsp" %>
<%@ include file="userModify.jsp" %>
<%@ include file="userDelete.jsp" %>
<div class="wrap">
<%@ include file="chatBox.jsp" %>
<style>
	.subMenu{
		width:140px;
		text-align:center;
		display:none;
		background-color:#efefef;
		font-size:12px;
		position:absolute;
		left:0;
		z-index:1000;
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
		background-color:#ff4b25;
		color:#fff;
	}
	
	.userMenu:hover .subMenu{
		display:block;
	}
	
	.footer{
    		max-width:1200px;
    		width:100%;
    		margin:0 auto;
    		padding:70px 0;
    		font-size:12px;
    		font-weight:700;
    	}
</style>
<div class="header">
	<header>
		<div class="logo">
			<h1>
				<a href="index.jsp">
					<img src="img/logo.jpg" />
					LOGO
				</a>
			</h1>
		</div>
		<div class="nav">
			<nav>
				<ul class="gnb">
					<li class="webtoon">
						<a href="weekday.nhn" target="_balnk" style="color:#f76a0e;">웹툰보러가기</a>
						
					</li>
					<li class="notice">
						<a href="boardList.bo">공지사항</a>
						
					</li>
					<li>
						<a href="location.mp">찾기</a>
						
					</li>
					
					<% if(sessionId != null){ %>
					<li>
						<a href="addList.bo?userId=<%=sessionId %>">담은게시판보기</a>
					</li>
					<% } %>
					<li>
						<a href="admin/index.jsp">관리자페이지</a>
					</li>
					<li>
						<a href="boardProWrite.jsp">지도입력</a>
					</li>
				</ul>
				<ul class="members">
				<% if(sessionId == null){ %>
					<li class="userJoin">
						<a href="#none">
							회원가입
						</a>
					</li>
					<li class="userLogin">
						<a href="#none">
							로그인
						</a>
					</li>
				<% }else{ %>
					<li class="userMenu">
						<a href="#none">
							<%=sessionId %>님 환영합니다.
						</a>
						<ul class="subMenu">
							
							<li class="userUpdate">
								<a href="#none">회원정보 수정</a>
							</li>
							<li class="userDelete">
								<a href="#none">회원 탈퇴</a>
							</li>
							<li class="userLogout">
								<a href="#none">로그아웃</a>
							</li>
						</ul>
					</li>
				<% } %>
				</ul>
			</nav>
		</div>
	</header>
</div>
<script>
	$(".userLogout").on("click",function(){
		if(confirm("로그아웃 하시겠습니까?")){
			$.ajax({
				type : "POST",
				url : "memberLogout.do",
				success : function(result){
					if(result == 1){
						alert("로그아웃 완료");
						location.href="index.jsp";
					}
	
				}
			});
		}
	});
</script>

<!-- header-fixed -->