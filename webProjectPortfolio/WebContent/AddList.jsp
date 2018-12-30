<%@page import="org.web.bbsDTO.AddDTO"%>
<%@page import="org.web.bbsDAO.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.web.bbsDTO.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String cartId = (String)request.getParameter("userId");
	ArrayList<AddDTO> result = null;
	BoardDAO dao1 = BoardDAO.getInstance();
	result = dao1.cartList(cartId);
	int cartCount = dao1.cartCount(cartId);
	HashMap<String, Object> listOpt = null;
	BoardDTO list = null;
%>
<script>
$(".nav .gnb li:eq(3) > a").css({"color":"#f76a0e"});
</script>
<style>
	.board_list{
		max-width:850px;
		width:100%;
		margin:0 auto;
	}
	.board_title{
		padding:20px 0;
		font-size:20px;
		color:#ff4b25;
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
		background-color:#ff4b25;
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
	.board_list_table ul > li > div:nth-child(5){
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
		color:#ff4b25;
	}
	
	.searchBox{
		max-width:310px;
		width:100%;
		margin:10px auto;
		height:30px;
		border:2px solid #ff4b25;
		position:relative;
		font-weight:700;
	}
	
	.searchBox select{
		width:100px;
		height:100%;
		border:none;
		border-right:2px solid #ff4b25;
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
		color:#ff4b25;
		border:1px solid #ff4b25;
		margin-top:10px;
	}
</style>
<div class="board_list_wrap">
	<div class="board_list">
		<h2 class="board_title">
			게시글 담기
		</h2>
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
			<ul class="list_body">
		<%	
		for(int i = 0; i < result.size(); i++) {
			listOpt =  new HashMap<String,Object>();	
			listOpt.put("addId",result.get(i).getAddId());
			listOpt.put("board_Id",result.get(i).getBoard_Id());
			list =  dao1.getCartList(listOpt);
		%>
				<li class="list_body_tr">
					<div class="list_body_td">
						<%=list.getBoard_num() %>
					</div>
					<div class="list_body_td">
						<%=list.getBoard_nick() %>
					</div>
					<div class="list_body_td">
						<a href="boardView.bo?no=<%=list.getBoard_num() %>">
							<% if(list.getBoard_re_lev() > 0){ %>
								<% for(int j=0;j < list.getBoard_re_lev(); j++){ %>
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
		</div>
	</div>
</div>

<%@ include file="footer.jsp" %>