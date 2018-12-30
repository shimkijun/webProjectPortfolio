<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.login_wrap{
		display:none;
	}
	.login_form_wrap{
		width:400px;
		border:1px solid #ccc;
		position:fixed;
		left:50%;
		top:20%;
		transform:translateX(-50%);
		background-color:#efefef;
		z-index:1002;
	}
	
	.login_wrap .form_head{
		background-color:#ff4b25;
		color:#fff;
		padding:10px;
	}
	.login_wrap .form_head h2{
		display:inline-block;
	}
	.login_wrap .form-group{
		padding:10px;
	}
	
	#loginId,
	#loginPw{
		width:100%;
		padding:15px 10px;
		border:1px solid #ccc;
	}
	
	.subBtn{
		padding:8px 0;
		text-align:center;	
	}
	
	#loginSubBtn{
		border:0;
		cursor:pointer;
		font-size:14px;
		color:#fff;
		background-color:#ff4b25;
		border-radius:5px;
		padding:5px 12px;
	}
	
	.subJoin{
		color:#ff4b25;
		margin-top:10px;
		font-size:12px;
	}
	
	.login_bg{
		background-color:#fefefe;
		width:100%;
		height:100vh;
		position:fixed;
		left:0;
		top:0;
		opacity:0.8;
		z-index:1001;
	}
	
	.loginClose{
		float:right;
		color:#fff;
		font-weight:700;
		cursor:pointer;
	}
</style>
<div class="login_wrap">
	<div class="garo-container">
		<div class="garo-box">
			<div class="login_bg"></div>
			<div class="login_form_wrap">
				<div class="form_head">
					<h2>로그인</h2>
					<span class="loginClose">
						X
					</span>
				</div>
				<form name="userForm" id="userLoginForm" method="POST" action="#">
					<div class="form_box">
						<ul>
							<li class="garo">
								<div class="form-group">
									<input type="text" id="loginId" name="userId" placeholder="아이디를 입력하세요." maxlength="12" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="password" id="loginPw" name="userPw" placeholder="비밀번호를 입력하세요" maxlength="15" autocomplete="off" />
								</div>
							</li>
							
						</ul>
					</div>
					<div class="subBtn">
						<button type="button" id="loginSubBtn">로그인</button></br>
						<a href="#none" class="subJoin">Register</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".members li.userLogin").on("click",function(){
			$(".login_wrap").fadeIn();
		});
		
		$(".login_bg,.loginClose").on("click",function(){
			$(".login_wrap").fadeOut();
		});
		
		$(".subJoin").on("click",function(){
			$(".join_wrap").fadeIn();
			$(".login_wrap").fadeOut();
		});
		
		$("#loginSubBtn").on("click",function(){
			var loginId = $("#loginId").val();
			var loginPw = $("#loginPw").val();
			$.ajax({
				type : "POST",
				url : "normalLogin.do",
				data : {userId :loginId,userPw:loginPw},
				success : function(result){
					if(loginId == null || loginId == ""){
						alert("아이디를 입력하세요");
						loginId.focus();
						return false;
					}else if(loginPw == null || loginPw == ""){
						alert("비밀번호를 입력하세요");
						loginPw.focus();
						return false;
					}else if(result == 3){
						alert("모든 내용을 입력하세요");
						return false;
					}else if(result == 2){
						alert("비밀번호가 틀립니다.");
					}else if(result == 1){
						alert("로그인 완료");
						location.reload();
					}else{
						alert("아이디가 없습니다.");
					}
				}
			});
		});
	});
</script>