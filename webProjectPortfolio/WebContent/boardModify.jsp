<%@page import="org.web.bbsDTO.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<% 
	BoardDTO modifyView = (BoardDTO)request.getAttribute("modifyView"); 
%>
<script>
$(".nav .gnb li:eq(1)>a").css({"color":"#f76a0e"});
</script>
<style>
	.board_modify_form{
		max-width:800px;
		width:100%;
		margin:20px auto;
	}
	
	.board_title{
		padding:20px 0;
		font-size:20px;
		color:#ff4b25;
	}
	
	.board_modify_table{
		width:100%;
		padding:0 20px;
		border:1px solid #ccc;
	}
	
	.board_modify_table > ul > li::after{
		display:block;
		clear:both;
		content:"";
	}
	.board_modify_table > ul > li{
		border-bottom:1px solid #ccc;
	}
	.board_modify_table > ul > li > div{
		float:left;
		padding:15px;
		font-size:14px;
	}
	
	.board_modify_table .modify_th{
		width:20%;
		color:#ff4b25;
		font-weight:700;
	}
	.board_modify_table .modify_td{
		width:80%;
		
	}
	
	.board_modify_table .modify_td input[type="text"]{
		border:none;
		padding:0 10px;
		height:25px;
		width:100%;
		border:1px solid #ccc;
	}
	
	.board_modify_table .modify_td textarea{
		width:100%;
		height:250px;
		resize: none;
		padding:10px;
		border:1px solid #ccc;
	}
	
	.board_modify_btn{
		text-align:right;
		padding:10px 15px;
	}
	
	.board_modify_btn input{
		background-color:#ff4b25;
		color:#fff;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #fff;
		cursor:pointer;
	}
	.board_modify_btn a{
		font-size:14px;
		background-color:#fff;
		color:#ff4b25;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #ff4b25;
		cursor:pointer;
	}
	
	#board_nick,
	#board_pass{
		max-width:30%;
		width:100%;
		padding: 0 10px;
    	height: 25px;
    	border:1px solid #ccc;
	}
</style>
<div class="board_modify_wrap">
	<div class="board_modify_form">
		<h2 class="board_title">
			게시판 수정하기
		</h2>
		<form action="boardModify.bo" method="post" name="boardForm" enctype="multipart/form-data">
			<div class="board_modify_table">
				<input type="hidden" name="board_num" id="board_num" value="<%=modifyView.getBoard_num() %>"/>
				<ul>
				<% if(modifyView.getBoard_id() != null){ %>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_id">아이디</label>	
						</div>
						<div class="modify_td">
							<span><%=modifyView.getBoard_id() %></span>
							<input type="hidden" name="board_nick" id="board_nick" value="<%=sessionId %>" />
						</div>
					</li>
				<% }else{ %>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_nick">닉네임</label>
						</div>
						<div class="modify_td">
							<span><%=modifyView.getBoard_nick() %></span>
							<input type="hidden" name="board_nick" id="board_nick" maxlength="12" autocomplete="off" value="<%=modifyView.getBoard_nick() %>"/>
						</div>
					</li>
				<% } %>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_pass">비밀번호</label>
						</div>
						<div class="modify_td">
							<input type="password" name="board_pass" id="board_pass" maxlength="20" autocomplete="off" />
						</div>
					</li>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_subject">제목</label>	
						</div>
						<div class="modify_td">
							<input type="text" name="board_subject" id="board_subject" maxlength="100" autocomplete="off" value="<%=modifyView.getBoard_subject() %>" />
						</div>
					</li>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_id">내용</label>	
						</div>
						<div class="modify_td">
							<textarea id="board_content" name="board_content" maxlength="2048"><%=modifyView.getBoard_content() %></textarea>
						</div>
					</li>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_file">기존파일</label>	
						</div>
						<div class="modify_td">
						<%if(modifyView.getBoard_file() != null){ %>
							<span class="modify_file"><a href="bbsUpload/<%=modifyView.getBoard_file() %>" download ><%=modifyView.getBoard_file() %></a></span>
						<% }else{ %>
							없음
						<% } %>
						</div>
					</li>
					<li class="modify_tr">
						<div class="modify_th">
							<label for="board_file">첨부파일</label>	
						</div>
						<div class="modify_td">
							<input type="file" id="board_file" name="board_file" />
						</div>
					</li>
				</ul>
				<div class="board_modify_btn">
					<input type="submit" id="modifyBtn" value="수정하기" />
					<input type="button" id="modifyBack" value="취소" />
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	$("#modifyBack").on("click",function(){
		window.history.go(-1);
	});
	
</script>
<% if(session.getAttribute("moSuccess") != null){ %>
<script>
	alert("수정 완료");
	location.href="boardList.bo";
</script>
<% }else if(session.getAttribute("moWarning") != null){ %>
<script>
	alert("비밀번호가 틀렸습니다.");
</script>
<% }
	session.removeAttribute("moSuccess");
	session.removeAttribute("moWarning");
%>
<%@ include file="footer.jsp" %>