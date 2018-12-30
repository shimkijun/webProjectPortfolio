<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.join_wrap{
		display:none;
	}
	.join_form_wrap{
		width:400px;
		border:1px solid #ccc;
		position:fixed;
		left:50%;
		top:20%;
		transform:translateX(-50%);
		background-color:#efefef;
		z-index:1002;
	}
	
	.join_wrap .form_head{
		background-color:#ff4b25;
		color:#fff;
		padding:10px;
	}
	.join_wrap .form_head h2{
		display:inline-block;
	}
	.join_wrap .form-group{
		padding:10px;
	}
	
	#joinId,
	#userEmail,
	#userPw1,
	#userPw2{
		width:100%;
		padding:15px 10px;
		border:1px solid #ccc;
	}
	
	#userPhone1,
	#userPhone2,
	#userPhone3{
		width:30%;
		padding:10px;
		border:1px solid #ccc;
	}
	
	.subBtn{
		padding:8px 0;
		text-align:center;	
	}
	
	#joinSubBtn{
		border:0;
		cursor:pointer;
		font-size:14px;
		color:#fff;
		background-color:#ff4b25;
		border-radius:5px;
		padding:5px 12px;
	}
	
	.subLogin{
		color:#ff4b25;
		margin-top:10px;
		font-size:12px;
	}
	
	.join_bg{
		background-color:#fefefe;
		width:100%;
		height:100vh;
		position:fixed;
		left:0;
		top:0;
		opacity:0.8;
		z-index:1001;
	}
	
	.joinClose{
		float:right;
		color:#fff;
		font-weight:700;
		cursor:pointer;
	}
	.idCheck{
		font-size:12px;
		font-weight:700;
		display:none;
	}
	.idCheck.normal{
		display:block;
		color:#46ca9a;
		
	}
	.idCheck.warning{
		display:block;
		color:#ff4b25;
	}
	.idCheck.success{
		display:block;
		color:#4369fd;
	}
	
	#userPw1.warning,
	#userPw2.warning{
		border:2px solid #ff4b25;
	}
	
	#userPw1.success,
	#userPw2.success{
		border:2px solid #4369fd;
	}
</style>
<div class="join_wrap">
	<div class="garo-container">
		<div class="garo-box">
			<div class="join_bg"></div>
			<div class="join_form_wrap">
				<div class="form_head">
					<h2>회원가입</h2>
					<span class="joinClose">
						X
					</span>
				</div>
				<form name="userForm" id="userJoinForm" method="POST" action="">
					<div class="form_box">
						<ul>
							<li class="garo">
								<div class="form-group">
									<input type="text" id="joinId" name="userId" placeholder="아이디를 입력하세요." maxlength="12" autocomplete="off"/>
								</div>
							</li>
							<li class="garo idCheck">
								<div class="form-group">
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="text" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요." maxlength="30" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="password" id="userPw1" name="userPw1" placeholder="비밀번호를 입력하세요." maxlength="15" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="password" id="userPw2" name="userPw2" placeholder="비밀번호를 확인하세요." maxlength="15" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<select name="userPhone1" id="userPhone1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="019">019</option>
										<option value="017">017</option>
										<option value="016">016</option>
									</select>
									-
									<input type="text" id="userPhone2" name="userPhone2" maxlength="4" autocomplete="off" />
									-
									<input type="text" id="userPhone3" name="userPhone3" maxlength="4" autocomplete="off" />
								</div>
							</li>
						</ul>
					</div>
					<div class="subBtn">
						<button type="button" id="joinSubBtn">회원가입</button></br>
						<a href="#none" class="subLogin">Login</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>

	$(document).ready(function(){		
		
		$(".members li.userJoin").on("click",function(){
			$(".join_wrap").fadeIn();
		});
		
		$(".join_bg,.joinClose").on("click",function(){
			$(".join_wrap").fadeOut();
		});
		
		$(".subLogin").on("click",function(){
			$(".join_wrap").fadeOut();
			$(".login_wrap").fadeIn();
		});
		
		$("#joinSubBtn").on("click",function(){
			var joinId = $("#joinId").val();
			var userEmail = $("#userEmail").val();
			var userPw1 = $("#userPw1").val();
			var userPw2 = $("#userPw2").val();
			var userPhone1 = $("#userPhone1").val();
			var userPhone2 = $("#userPhone2").val();
			var userPhone3 = $("#userPhone3").val();
			if(confirm("회원가입 하시겠습니까?")){
			$.ajax({
				type : "POST",
				url : "normalRegister.do",
				data : {userId : joinId ,userEmail : userEmail,userPw1:userPw1,userPw2:userPw2,userPhone1:userPhone1,userPhone2:userPhone2,userPhone3:userPhone3},
				dataType : "JSON",
				success : function(result){
					if(result == 1){
						alert("회원가입에 성공 하셨습니다.");
						location.reload();
					}else if(result == 2){
						alert("모든 내용을 입력해주세요.");
					}else if(result == 3){
						alert("비밀번호가 서로 다릅니다.");
					}else{
						alert("다시한번 확인해 주세요.");
					}
				}
			});
			}
		});
		
		$("#joinId").on("keyup",function(){
			var joinId = $(this).val();
			$.ajax({
				type : "POST",
				url : "normalIdCheck.do",
				data : {userId :joinId},
				success : function(result){
					if(joinId == null || joinId == ""){
						$(".idCheck").addClass("normal").removeClass("warning").removeClass("success");
						$(".idCheck .form-group").text("아이디를 입력하세요");
					}else if(result == 1){
						$(".idCheck").addClass("warning").removeClass("success").removeClass("normal");
						$(".idCheck .form-group").text("사용 할 수 없는 아이디입니다..");
					}else{
						$(".idCheck").addClass("success").removeClass("warning").removeClass("normal");
						$(".idCheck .form-group").text("사용 가능한 아이디 입니다..");
					}
				}
			});
		});
	});
	
</script>
