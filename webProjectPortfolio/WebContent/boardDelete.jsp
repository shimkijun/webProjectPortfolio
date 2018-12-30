<%@page import="org.web.bbsDTO.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDTO deleteView = (BoardDTO)request.getAttribute("deleteView");
%>
<%@ include file="header.jsp" %>
<script>
$(".nav .gnb li:eq(1)>a").css({"color":"#f76a0e"});
</script>
<style>
	.board_delete_form{
		max-width:800px;
		width:100%;
		margin:20px auto;
	}
	
	.board_title{
		padding:20px 0;
		font-size:20px;
		color:#ff4b25;
	}
	
	.board_delete_table{
		width:100%;
		padding:0 20px;
		border:1px solid #ccc;
	}
	
	.board_delete_table > ul > li::after{
		display:block;
		clear:both;
		content:"";
	}
	.board_delete_table > ul > li{
		border-bottom:1px solid #ccc;
	}
	.board_delete_table > ul > li > div{
		float:left;
		font-size:14px;
		height:40px;
		line-height:40px;
	}
	
	.board_delete_table .delete_th{
		width:20%;
		color:#ff4b25;
		font-weight:700;
	}
	.board_delete_table .delete_td{
		width:80%;
		
	}
	
	.board_delete_table .delete_nick{
		display:block;
		width:100%;
	}
	
	.board_delete_table .delete_td textarea{
		width:100%;
		height:250px;
		resize: none;
		padding:10px;
		border:1px solid #ccc;
	}
	
	.board_delete_btn{
		text-align:right;
		padding:10px 0;
	}
	
	.board_delete_btn input{
		background-color:#ff4b25;
		color:#fff;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #fff;
		cursor:pointer;
	}
	.board_delete_btn a{
		font-size:14px;
		background-color:#fff;
		color:#ff4b25;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #ff4b25;
		cursor:pointer;
	}

	.board_delete_table .delete_content{
		display:block;
		width:100%;
		height:400px;
		border:1px solid #ccc;
		padding:0 15px;
		overflow-y:scroll;
	}
	.delete_td span{
		display:block;
		padding:0 15px;
	}
	
	.delete_td input[type="password"]{
		margin-left:15px;
		border:1px solid #ccc;
	}
</style>
<div class="board_delete_wrap">
	<div class="board_delete_form">
		<h2 class="board_title">
			글 삭제
		</h2>
		<form action="boardDelete.bo" method="post" name="boardForm">
			<input type="hidden" name="board_num" id="board_num" value="<%=deleteView.getBoard_num() %>"/>
			<div class="board_delete_table">
				<ul>
				<%if(deleteView.getBoard_id() != null){ %>
					<li class="delete_tr">
						<div class="delete_th">
							<label for="board_nick">아이디</label>	
						</div>
						<div class="delete_td">
							<span class="view_nick"><%=deleteView.getBoard_id() %></span>
							<input type="hidden" name="board_nick" id="board_nick" value="<%=deleteView.getBoard_id() %>"/>
						</div>
					</li>
				<% }else{ %>
					<li class="delete_tr">
						<div class="delete_th">
							<label for="board_nick">닉네임</label>
						</div>
						<div class="delete_td">
							<span class="delete_nick"><%=deleteView.getBoard_nick() %></span>
							<input type="hidden" name="board_nick" id="board_nick" value="<%=deleteView.getBoard_nick() %>"/>
						</div>
					</li>
				<% } %>
					<li class="delete_tr">
						<div class="delete_th">
							<label for="board_pass">비밀번호</label>
						</div>
						<div class="delete_td">
							<input type="password" name="board_pass" id="board_pass" maxlength="20" autocomplete="off" />
						</div>
					</li>
					<li class="delete_tr">
						<div class="delete_th">
							<label for="board_subject">제목</label>	
						</div>
						<div class="delete_td">
							<span class="delete_subject"><%=deleteView.getBoard_subject() %></span>
						</div>
					</li>
					<li class="delete_tr">
						<div class="delete_th">
							<label for="board_id">내용</label>
						</div>
						<div class="delete_td" style="height:auto;padding:20px 0;">
							<span class="delete_content"><%=deleteView.getBoard_content() %></span>
						</div>
					</li>
					<li class="delete_tr">
						<div class="delete_th">
							<label for="board_file">첨부파일</label>	
						</div>
						<div class="delete_td">
						<% if(deleteView.getBoard_file() == null){ %>
							없음
						<% }else{ %>
							<span class="delete_file"><a href="bbsUpload/<%=deleteView.getBoard_file() %>" download ><%=deleteView.getBoard_file() %></a></span>
						<% } %>
						</div>
					</li>
				</ul>
				<div class="board_delete_btn">
					<a href="boardList.bo">목록</a>
					<input id="boardDelBtn" type="button" value="삭제" >
					<input type="button" id="deleteBack" value="취소" />
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	$("#boardDelBtn").on("click",function(){
		if(confirm('삭제하시겠습니까?')){
			boardForm.submit();
		}
	});
	$("#deleteBack").on("click",function(){
		window.history.go(-1);
	});
</script>
<% if(session.getAttribute("delWarning") != null){ %>
<script>
	alert("비밀번호가 틀렸습니다.");
</script>
<% }
	session.removeAttribute("delSuccess");
	session.removeAttribute("delWarning");
%>
<%@ include file="footer.jsp" %>