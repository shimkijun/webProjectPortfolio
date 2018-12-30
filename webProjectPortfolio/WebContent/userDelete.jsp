<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.delete_wrap{
		display:none;
	}
	.delete_form_wrap{
		width:400px;
		border:1px solid #ccc;
		position:fixed;
		left:50%;
		top:20%;
		transform:translateX(-50%);
		background-color:#efefef;
		z-index:1002;
	}
	
	.delete_wrap .form_head{
		background-color:#ff4b25;
		color:#fff;
		padding:10px;
	}
	.delete_wrap .form_head h2{
		display:inline-block;
	}
	.delete_wrap .form-group{
		padding:10px;
	}
	
	#deleteId,
	#deletePw{
		width:100%;
		padding:15px 10px;
		border:1px solid #ccc;
	}
	
	.subBtn{
		padding:8px 0;
		text-align:center;	
	}
	
	#deleteSubBtn{
		border:0;
		cursor:pointer;
		font-size:14px;
		color:#fff;
		background-color:#ff4b25;
		border-radius:5px;
		padding:5px 12px;
	}
	
	.delete_bg{
		background-color:#fefefe;
		width:100%;
		height:100vh;
		position:fixed;
		left:0;
		top:0;
		opacity:0.8;
		z-index:1001;
	}
	
	.deleteClose{
		float:right;
		color:#fff;
		font-weight:700;
		cursor:pointer;
	}
</style>
<div class="delete_wrap">
	<div class="garo-container">
		<div class="garo-box">
			<div class="delete_bg"></div>
			<div class="delete_form_wrap">
				<div class="form_head">
					<h2>회원 탈퇴</h2>
					<span class="deleteClose">
						X
					</span>
				</div>
				<form name="userForm" id="userdeleteForm" method="POST" action="#">
					<div class="form_box">
						<ul>
							<li class="garo">
								<div class="form-group">
									<input type="text" id="deleteId" name="userId" placeholder="아이디를 입력하세요." maxlength="12" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="password" id="deletePw" name="userPw" placeholder="비밀번호를 입력하세요" maxlength="15" autocomplete="off" />
								</div>
							</li>
							
						</ul>
					</div>
					<div class="subBtn">
						<button type="button" id="deleteSubBtn">회원탈퇴</button></br>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".members li.userDelete").on("click",function(){
			$(".delete_wrap").fadeIn();
		});
		
		$(".delete_bg,.deleteClose").on("click",function(){
			$(".delete_wrap").fadeOut();
		});
		
			$("#deleteSubBtn").on("click",function(){
				var deleteId = $("#deleteId").val();
				var deletePw = $("#deletePw").val();
				if(confirm("회원탈퇴 하시겠습니까?")){
					$.ajax({
						type : "POST",
						url : "memberDelete.do",
						data : {userId :deleteId,userPw:deletePw},
						success : function(result){
							if(deleteId == null || deleteId == ""){
								alert("아이디를 입력하세요");
								deleteId.focus();
								return false;
							}else if(deletePw == null || deletePw == ""){
								alert("비밀번호를 입력하세요");
								userPw.focus();
								return false;
							}else if(result == 2){
								alert("비밀번호가 틀립니다.");
							}else if(result == 1){
								alert("회원 탈퇴 완료");
								location.reload();
							}else{
								alert("아이디가 없습니다.");
							}
						}
					});
				}
			});

	});
</script>