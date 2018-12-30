<%@page import="org.web.memberDAO.NormalMemberDAO"%>
<%@page import="org.web.memberDTO.NormalMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NormalMemberDAO dao = NormalMemberDAO.getInstance();
	NormalMemberDTO member = dao.getUserInfo(sessionId);
%>

<style>
	.modify_wrap{
		display:none;
	}
	.modify_form_wrap{
		width:400px;
		border:1px solid #ccc;
		position:fixed;
		left:50%;
		top:20%;
		transform:translateX(-50%);
		background-color:#efefef;
		z-index:1002;
	}
	
	.modify_wrap .form_head{
		background-color:#ff4b25;
		color:#fff;
		padding:10px;
	}
	.modify_wrap .form_head h2{
		display:inline-block;
	}
	.modify_wrap .form-group{
		padding:10px;
	}
	
	#modifyId,
	#modifyEmail,
	#modifyPw1,
	#modifyPw2{
		width:100%;
		padding:15px 10px;
		border:1px solid #ccc;
	}
	
	#modifyPhone1,
	#modifyPhone2,
	#modifyPhone3{
		width:30%;
		padding:10px;
		border:1px solid #ccc;
	}
	
	.subBtn{
		padding:8px 0;
		text-align:center;	
	}
	
	#modifySubBtn{
		border:0;
		cursor:pointer;
		font-size:14px;
		color:#fff;
		background-color:#ff4b25;
		border-radius:5px;
		padding:5px 12px;
	}
	
	.submodify{
		color:#ff4b25;
		margin-top:10px;
		font-size:12px;
	}
	
	.modify_bg{
		background-color:#fefefe;
		width:100%;
		height:100vh;
		position:fixed;
		left:0;
		top:0;
		opacity:0.8;
		z-index:1001;
	}
	
	.modifyClose{
		float:right;
		color:#fff;
		font-weight:700;
		cursor:pointer;
	}

	span.modify_id{
		border:1px solid #ccc;
		background-color:#efefef;
		padding: 15px 10px;
		display:block;
		width:100%;
		cursor:not-allowed;
	}
</style>
<div class="modify_wrap">
	<div class="garo-container">
		<div class="garo-box">
			<div class="modify_bg"></div>
			<div class="modify_form_wrap">
				<div class="form_head">
					<h2>회원 수정 하기</h2>
					<span class="modifyClose">
						X
					</span>
				</div>
				<form name="userForm" id="usermodifyForm" method="POST" action="">
					<div class="form_box">
						<ul>
							<li class="garo">
								<div class="form-group">
									<span class="modify_id"><%=sessionId %></span>
								</div>
							</li>
							<li class="garo idCheck">
								<div class="form-group">
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="text" id="modifyEmail" name="userEmail" maxlength="30" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="password" id="modifyPw1" name="userPw1" placeholder="비밀번호를 입력하세요." maxlength="15" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<input type="password" id="modifyPw2" name="userPw2" placeholder="비밀번호를 확인하세요." maxlength="15" autocomplete="off" />
								</div>
							</li>
							<li class="garo">
								<div class="form-group">
									<select name="userPhone1" id="modifyPhone1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="019">019</option>
										<option value="017">017</option>
										<option value="016">016</option>
									</select>
									-
									<input type="text" id="modifyPhone2" name="userPhone2" value="" maxlength="4" autocomplete="off" />
									-
									<input type="text" id="modifyPhone3" name="userPhone3" value="" maxlength="4" autocomplete="off" />
								</div>
							</li>
						</ul>
					</div>
					<div class="subBtn">
						<button type="button" id="modifySubBtn">회원 정보 수정</button></br>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>

	$(document).ready(function(){		
		$("li.userUpdate").on("click",function(){
			$(".modify_wrap").fadeIn();
		});
		
		$(".modify_bg,.modifyClose").on("click",function(){
			$(".modify_wrap").fadeOut();
		});
		
		$("#modifySubBtn").on("click",function(){
			
			var userEmail = $("#modifyEmail").val();
			var userPw1 = $("#modifyPw1").val();
			var userPw2 = $("#modifyPw2").val();
			var userPhone1 = $("#modifyPhone1").val();
			var userPhone2 = $("#modifyPhone2").val();
			var userPhone3 = $("#modifyPhone3").val();
			if(confirm("회원수정 하시겠습니까?")){
				$.ajax({
					type : "POST",
					url : "memberModify.do",
					data : {sessionId :"<%=sessionId %>" ,userEmail : userEmail,userPw1:userPw1,userPw2:userPw2,userPhone1:userPhone1,userPhone2:userPhone2,userPhone3:userPhone3},
					dataType : "JSON",
					success : function(result){
						if(result == 1){
							alert("회원수정에 성공하셨습니다.");
							location.reload();
						}else if(result == 2){
							alert("모든 내용을 입력해주세요.");
						}else if(result == 3){
							alert("비밀번호가 서로 다릅니다.");
						}else{
							alert("데이터베이스 오류");
						}
					}
				});
			}
		});
		
		$("li.userUpdate").on("click",function(){
			$.ajax({
			    type : 'POST',
			    url : "getMember.do",
			    data : {sessionId:"<%=sessionId %>"},
			    error : function(error) {
			        alert("Error!");
			    },
			    success : function(result) {
			    	
			    	var parseObj = JSON.parse(result);
			    	var result = parseObj.result;
			    	var email = result[0].value;
			    	var phone = result[1].value.split("-");
			    	$("#modifyEmail").val(email);
			    	$("#modifyPhone1").val(phone[0]);
			    	$("#modifyPhone2").val(phone[1]);
					$("#modifyPhone3").val(phone[2]);
			    },
			});

		});
	});
	
</script>