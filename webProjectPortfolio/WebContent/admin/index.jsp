<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset=UTF-8>
<script src="../js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<title>관리자페이지</title>
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
			메인페이지
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