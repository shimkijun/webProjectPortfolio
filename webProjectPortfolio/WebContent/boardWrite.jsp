<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<script>
$(".nav .gnb li:eq(1)>a").css({"color":"#f76a0e"});
</script>
<style>
	.board_write_form{
		max-width:800px;
		width:100%;
		margin:20px auto;
	}
	
	.board_title{
		padding:20px 0;
		font-size:20px;
		color:#ff4b25;
	}
	
	.board_write_table{
		width:100%;
		padding:0 20px;
		border:1px solid #ccc;
	}
	
	.board_write_table > ul > li::after{
		display:block;
		clear:both;
		content:"";
	}
	.board_write_table > ul > li{
		border-bottom:1px solid #ccc;
	}
	.board_write_table > ul > li > div{
		float:left;
		padding:15px;
		font-size:14px;
	}
	
	.board_write_table .write_th{
		width:20%;
		color:#ff4b25;
		font-weight:700;
	}
	.board_write_table .write_td{
		width:80%;
	}
	
	.board_write_table .write_td input[type="text"]{
		border:none;
		padding:0 10px;
		height:25px;
		width:100%;
		border:1px solid #ccc;
	}
	
	.board_write_table .write_td textarea{
		width:100%;
		height:250px;
		resize: none;
		padding:10px;
		border:1px solid #ccc;
	}
	
	.board_write_btn{
		text-align:right;
		padding:10px 15px;
	}
	
	.board_write_btn input{
		background-color:#ff4b25;
		color:#fff;
		font-weight:700;
		padding:5px 15px;
		border:1px solid #fff;
		cursor:pointer;
	}
	.board_write_btn a{
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
<div class="board_write_wrap">
	<div class="board_write_form">
		<h2 class="board_title">
			게시판 작성
		</h2>
		<form action="boardWrite.bo" method="post" name="boardForm" enctype="multipart/form-data">
			<div class="board_write_table">
				<ul>
				<% if(sessionId != null){ %>
					<li class="write_tr">
						<div class="write_th">
							<label for="board_id">아이디</label>	
						</div>
						<div class="write_td">
							<span><%=sessionId %></span>
							<input type="hidden" name="board_id" id="board_id" value="<%=sessionId %>" />
							<input type="hidden" name="board_nick" id="" value="<%=sessionId %>" />
						</div>
					</li>
				<% }else{ %>
					<li class="write_tr">
						<div class="write_th">
							<label for="board_nick">닉네임</label>
						</div>
						<div class="write_td">
							<input type="text" name="board_nick" id="board_nick" maxlength="12" autocomplete="off"/>
						</div>
					</li>

				<% } %>
					<li class="write_tr">
						<div class="write_th">
							<label for="board_pass">비밀번호</label>	
						</div>
						<div class="write_td">
							<input type="password" name="board_pass" id="board_pass" maxlength="20" autocomplete="off" />
						</div>
					</li>
					<li class="write_tr">
						<div class="write_th">
							<label for="board_subject">제목</label>	
						</div>
						<div class="write_td">
							<input type="text" name="board_subject" id="board_subject" maxlength="100" autocomplete="off" />
						</div>
					</li>
					<li class="write_tr">
						<div class="write_th">
							<label for="board_id">내용</label>	
						</div>
						<div class="write_td">
							<textarea id="board_content" name="board_content" maxlength="2048"></textarea>
						</div>
					</li>
					<li class="write_tr">
						<div class="write_th">
							<label for="board_file">첨부파일</label>	
						</div>
						<div class="write_td">
							<input type="file" id="board_file" name="board_file" />
						</div>
					</li>
				</ul>
				<div class="board_write_btn">
					<a href="boardList.bo">목록</a>
					<input type="submit" value="작성하기" />
				</div>
			</div>
			
		</form>
	</div>
</div>

<%@ include file="footer.jsp" %>