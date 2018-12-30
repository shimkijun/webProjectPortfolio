<%@page import="org.web.bbsDTO.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDTO boardView = (BoardDTO)request.getAttribute("listView");
%>
<%@ include file="header.jsp" %>
<script>
$(".nav .gnb li:eq(1)>a").css({"color":"#f76a0e"});
</script>
<style>
	.board_view_form{
		max-width:800px;
		width:100%;
		margin:20px auto;
	}
	
	.board_title{
		padding:20px 0;
		font-size:20px;
		color:#ff4b25;
	}
	
	.board_view_table{
		width:100%;
		padding:0 20px;
		border:1px solid #ccc;
	}
	
	.board_view_table > ul > li::after{
		display:block;
		clear:both;
		content:"";
	}
	.board_view_table > ul > li{
		border-bottom:1px solid #ccc;
	}
	.board_view_table > ul > li > div{
		float:left;
		font-size:14px;
		height:40px;
		line-height:40px;
	}
	
	.board_view_table .view_th{
		width:20%;
		color:#ff4b25;
		font-weight:700;
	}
	.board_view_table .view_td{
		width:80%;
		
	}
	
	.board_view_table .view_nick{
		display:block;
		width:100%;
	}
	
	.board_view_table .view_td textarea{
		width:100%;
		height:250px;
		resize: none;
		padding:10px;
		border:1px solid #ccc;
	}
	
	.board_view_btn{
		text-align:right;
		padding:10px 0;
	}
	
	.board_view_btn input{
		background-color:#ff4b25;
		color:#fff;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #fff;
		cursor:pointer;
	}
	.board_view_btn a{
		font-size:14px;
		background-color:#fff;
		color:#ff4b25;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #ff4b25;
		cursor:pointer;
	}

	.board_view_table .view_content{
		display:block;
		width:100%;
		height:400px;
		border:1px solid #ccc;
		padding:0 15px;
		overflow-y:scroll;
	}
	.view_td span{
		display:block;
		padding:0 15px;
	}
</style>
<input type="hidden" namd="addId" id="addId" value="<%=sessionId %>">
<input type="hidden" namd="addNum" id="addNum" value="<%=boardView.getBoard_num() %>">
<input type="hidden" namd="board_Id" id="board_Id" value="<%=boardView.getBoard_nick() %>">
<div class="board_view_wrap">
	<div class="board_view_form">
		<h2 class="board_title">
			글 보기
		</h2>
			<div class="board_view_table">
				<ul>
				<%if(boardView.getBoard_id() != null){ %>
					<li class="view_tr">
						<div class="view_th">
							<label for="board_nick">아이디</label>	
						</div>
						<div class="view_td">
							<span class="view_nick"><%=boardView.getBoard_id() %></span>
						</div>
					</li>
				<% }else{ %>
					<li class="view_tr">
						<div class="view_th">
							<label for="board_nick">닉네임</label>	
						</div>
						<div class="view_td">
							<span class="view_nick"><%=boardView.getBoard_nick() %></span>
						</div>
					</li>
				<% } %>
					<li class="view_tr">
						<div class="view_th">
							<label for="board_subject">제목</label>	
						</div>
						<div class="view_td">
							<span class="view_subject"><%=boardView.getBoard_subject().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %></span>
						</div>
					</li>
					<li class="view_tr">
						<div class="view_th">
							<label for="board_id">내용</label>
						</div>
						<div class="view_td" style="height:auto;padding:20px 0;">
							<span class="view_content"><%=boardView.getBoard_content().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %></span>
						</div>
					</li>
					<li class="view_tr">
						<div class="view_th">
							<label for="board_file">첨부파일</label>	
						</div>
						<div class="write_td">
						<% if(boardView.getBoard_file() == null){ %>
							없음
							<input type="hidden" name="board_file" value="<%=boardView.getBoard_file() %>" />
						<% }else{ %>
							<input type="hidden" name="board_file" value="<%=boardView.getBoard_file() %>" />
							<span class="view_file"><a href="bbsUpload/<%=boardView.getBoard_file() %>" download ><%=boardView.getBoard_file() %></a></span>
						<% } %>
						</div>
					</li>
				</ul>
				<div class="board_view_btn">
					<a href="boardList.bo">목록</a>
					<a href="boardDeleteView.bo?no=<%=boardView.getBoard_num() %>">삭제</a>
					<a href="boardModifyView.bo?no=<%=boardView.getBoard_num() %>" >수정</a>
					<a href="boardReplyView.bo?no=<%=boardView.getBoard_num() %>" >답변</a>
					<% if(sessionId != null){ %>
					<a id="addBoard" href="#none">담기</a>
					<% } %>
				</div>
			</div>
	</div>
</div>
<script>
	$("#addBoard").on("click",function(){

		var addId = $("#addId").val();
		var addNum = $("#addNum").val();
		var board_Id = $("#board_Id").val();
		if(confirm("담을래요?")){
			$.ajax({
				type : "POST",
				url : "boardAdd.bo",
				data : {
					addId :addId,
					addNum:addNum,
					board_Id:board_Id
					},
				dataType : "JSON",
				success : function(result){
					if(result == 1){
						alert("담기 완료");
						location.reload();
					}else if(result == -1){
						alert("중복해서 담을수 없습니다.");
					}else{
						alert("담기 실패");
					}
				}
			});
		}
	});

</script>
<% if(session.getAttribute("moSuccess") != null){ %>
<script>
	alert("수정 완료");
</script>
<% }
	session.removeAttribute("moSuccess");
%>
<%@ include file="footer.jsp" %>