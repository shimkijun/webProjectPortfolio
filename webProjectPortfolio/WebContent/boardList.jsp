<%@page import="java.io.PrintWriter"%>
<%@page import="org.web.bbsDTO.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<BoardDTO> boardList = (ArrayList<BoardDTO>)request.getAttribute("list");
	int spage = (int)request.getAttribute("spage");
	int maxPage = (int)request.getAttribute("maxPage");
	int startPage = (int)request.getAttribute("startPage");
	int endPage = (int)request.getAttribute("endPage");
	int boardAllCount = (int)request.getAttribute("boardAllCount");
	
	String opt = (String)request.getParameter("opt");
	String condition = (String)request.getParameter("condition");
	
	PrintWriter script = response.getWriter();
	
	if(boardAllCount == 0){
		spage = 1;
		maxPage = 1;
	}
	
	//게시물이 전혀 없을때 보여주는 페이징 번호
	if(spage < startPage || spage > maxPage){
		script.write("<script>");
		script.write("alert('잘못된 경로 입니다.');");
		script.write("window.history.go(-1);");
		script.write("</script>");
	}
	
	//게시판의 > 버튼을 클릭시 10개의 게시판을 넘어가는 상수 값
	int blockCount = 10;
	int startBlock =((spage-1) / blockCount) * blockCount + 1;
	int endBlock = startBlock + blockCount -1;
	
	if(endBlock > maxPage){
		endBlock = maxPage;
		
	}
%>
<%@ include file="header.jsp" %>

<style>
	.board_list{
		max-width:800px;
		width:100%;
		margin:0 auto;
	}
	.board_title{
		padding:20px 0;
		font-size:20px;
		color:#f76a0e;
	}
	
	.board_list_table{
		border:1px solid #efefef;
		width:100%;
		font-size:14px;
	}
	.board_list_table ul > li{
		border-bottom:1px solid #efefef;
	}
	.list_head > li{
		background-color:#f76a0e;
		color:#fff;
		font-weight:700;
	}
	
	.list_head > li > div{
		border-right:1px solid #fff;
	}
	
	.board_list_table ul > li::after{
		display:block;
		clear:both;
		content:"";
	}
	.board_list_table ul > li > div{
		float:left;
		
		width:20%;
		text-align:center;
		padding:5px;
		 white-space: nowrap; 
	    overflow: hidden;
	    text-overflow: ellipsis;
	}
	.board_list_table ul > li > div:first-child{
		width:10%;
	}
	.board_list_table ul > li > div:nth-child(2){
		width:15%;
	}
	.board_list_table ul > li > div:nth-child(3){
		width:50%;
		text-align:left;
	}
	.board_list_table ul > li > div:nth-child(4){
		width:15%;
	}
	.board_list_table ul > li > div:last-child{
		border-right:0;
		width:10%;
	}
	
	.list_file{
		width:17px;
		color:#ccc;
	}
	
	.pagingBtn{
		padding:20px 0;
		text-align:center;
		font-size:14px;
		font-weight:700;
	}
	
	.listNum{
		font-size:12px;
		color:#888;
		font-weight:700;
		text-align:right;
	}
	.listNum span{
		color:#f76a0e;
	}
	
	.searchBox{
		max-width:310px;
		width:100%;
		margin:10px auto;
		height:30px;
		border:2px solid #f76a0e;
		position:relative;
		font-weight:700;
	}
	
	.searchBox select{
		width:100px;
		height:100%;
		border:none;
		border-right:2px solid #f76a0e;
		font-size:12px;
		display:inline-block;
	}
	.searchBox input{
		width:200px;
		vertical-align:middel;
		padding:4px;
		border:none;
	}
	
	.searchBox button{
		position:absolute;
		right:0;
		top:0;
		width:30px;
		height:26px;
		background:transparent;
		color:#aaa;
		border:none;
	}
	
	.list_btn{
		text-align:right
	}
	
	.list_btn a{
		display:inline-block;
		padding:5px 20px;
		font-size:14px;
		font-weight:700;
		color:#f76a0e;
		border:1px solid #f76a0e;
		margin-top:10px;
	}
	
	.pNum.on a{
		color:#f76a0e;
	}
</style>
<div class="board_list_wrap">
	<div class="board_list">
		<h2 class="board_title">
			공지사항
		</h2>
		<div class="listNum">총 <span class="listCount"><%=boardAllCount %></span>개</div>
		<div class="board_list_table">
			<ul class="list_head">
				<li class="list_head_tr">
					<div class="list_head_th">
						번호
					</div>
					<div class="list_head_th">
						작성자
					</div>
					<div class="list_head_th">
						제목
					</div>
					<div class="list_head_th">
						작성일
					</div>
					<div class="list_head_th">
						조회수
					</div>
				</li>
			</ul>
			<% if(boardAllCount < 1){ %>
				<div class="noneList">
					<h2>게시물이 없습니다.</h2>
				</div>
			<% }else{ %>
			<ul class="list_body">
			<% 
				
				for(BoardDTO list:boardList){ 
				boardAllCount--;
			%>
				<li class="list_body_tr">
					<div class="list_body_td">
						<%=boardAllCount+1 %>
					</div>
					<div class="list_body_td">
						<%=list.getBoard_nick() %>
					</div>
					<div class="list_body_td">
						<a href="boardView.bo?no=<%=list.getBoard_num() %>">
							<% if(list.getBoard_re_lev() > 0){ %>
								<% for(int i=0;i < list.getBoard_re_lev(); i++){ %>
									&nbsp;&nbsp;
								<% } %>
								<i class="fab fa-replyd" style="vertical-align:middle;color:#ccc;font-size:20px;"></i>
							<% } %>
							<span style="vertical-align:middle;"><%=list.getBoard_subject().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %></span>
							<% if(list.getBoard_file() != null){ %>
								<span class="list_file"><i class="fas fa-file-upload"></i></span>
							<% } %>
						</a>
					</div>
					<div class="list_body_td">
						<%=list.getBoard_date() %>
					</div>
					<div class="list_body_td">
						<%=list.getBoard_count() %>
					</div>
				</li>
				<% } %>
			</ul>
			<% } %>
		</div>
		<div class="list_btn">
			<a href="boardWrite.jsp">글쓰기</a>
		</div>
	</div>
	
</div>
<div class="pagingBox">

	<div class="pagingBtn">
		<span><a href="boardList.bo?page=<%=startPage %>">처음</a></span>
		<%if(spage > blockCount){ %>
		<span><a href="boardList.bo?page=<%=startBlock-blockCount %>"><i class="fas fa-angle-double-left"></i></a></span>
		<% }%>
		<% if(spage != startPage){ %>
		<span><a href="boardList.bo?page=<%=spage-1 %>"><i class="fas fa-angle-left"></i></a></span>
		<% } %>
		<% 
			for(int i = startBlock; i <= endBlock ;i++ ){ 
				if(i == spage){
		%>
		
			<span class="pNum on">
				<a href="javascript:pageFnc(<%=i %>)">
					<%=i %>
				</a>
			</span>
		<% }else{ %>
			<span class="pNum">
				<a href="javascript:pageFnc(<%=i %>)">
					<%=i %>
				</a>
			</span>
		<% } %>
		<% } if(spage < maxPage){ %>
		<span><a href="boardList.bo?page=<%=spage+1 %>"><i class="fas fa-angle-right"></i></a></span>
		<% }
		//페이지 개수가 10개 이상일 경우
		if(endBlock % blockCount == 0 ){ 
		%>
		<span><a href="boardList.bo?page=<%=endBlock+1 %>"><i class="fas fa-angle-double-right"></i></a></span>
		<% } %>
		<span><a href="boardList.bo?page=<%=maxPage %>">끝</a></span>
	</div>
</div>
<div class="boardListSearch">
	<form method="get" action="" name="listSearch">
		<div class="searchBox">
			<select name="opt" id="opt">
				<option value="4">전체</option>
				<option value="0">제목</option>
				<option value="1">내용</option>
				<option value="2">제목+내용</option>
				<option value="3">작성자</option>
			</select>
			<% if(condition == null){ %>
			<input type="text" name="condition" id="condition" value="" />
			<% }else{ %>
			<input type="text" name="condition" id="condition" value="<%=condition %>" />
			<% } %>
			<button type="submit"><i class="fas fa-search"></i></button>
		</div>
	</form>
</div>
<script>
	$(document).ready(function(){
	  $("#opt option").each(function(){
	    if($(this).val()== <%=opt %>){
	      $(this).attr("selected","selected"); 
	    }
	  });
	
	  $(".nav .gnb li:eq(1)>a").css({"color":"#f76a0e"});
	});
	function pageFnc(pageNum){
		var opt=document.getElementById("opt"); 
		var condition=document.getElementById("condition");
		var data="&opt="+opt.value+"&condition="+condition.value;
		location.href="boardList.bo?page="+pageNum+data;
	}
	
</script>
<% if(session.getAttribute("delSuccess") != null){ %>
<script>
	alert("삭제 완료");
</script>
<% }else if(session.getAttribute("reSuccess") != null){ %>
<script>
	alert("댓글 완료");
	location.href="boardList.bo";
</script>
<% } 
	session.removeAttribute("reSuccess");
	session.removeAttribute("delSuccess");
	session.removeAttribute("delWarning");
%>
<%@ include file="footer.jsp" %>