<%@page import="java.util.ArrayList"%>
<%@page import="org.web.bbsProDTO.BoardDTO"%>
<%@page import="org.web.bbsProDAO.BoardProDAO"%>
<%@page import="org.web.bbsProDTO.ZzimDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	
	String item = (String)session.getAttribute("items");
	session.setAttribute("test", item);
%>
<style>
	.index_wrap .garo-box{
		max-width:1200px;
		width:100%;
		margin:0 auto;
	}
	
	.index_wrap .section{
		border-bottom:1px solid #ccc;
	}
	/* section1 */
	.index_wrap .garo-box .section{
		padding:50px 0;
	}
	
	.index_wrap .sec1{
		text-align:center;
/* 		border-bottom:1px solid #ccc; */
	}
	.index_wrap .sec1 .title{
		font-weight:400;
		font-size:34px;
		padding:30px 0;
	}
	.index_wrap .sec1 .title span{
		display:block;
	}
	
	.index_wrap .sec1 .title span b{
		color:#f76a0e;
	}
	
	.index_wrap .sBox{
		max-width:800px;
		width:100%;
		border:1px solid #ccc;
		margin:30px auto;
		padding:5px;
	}
	.index_wrap .sBox::after{
		display:block;
		clear:both;
		content:"";
	}
	.index_wrap .searchImg{
		width: 50px;
	    height: 30px;
	    margin-top: 3px;
	    display: block;
	    float: left;
	    text-align:center;
	    line-height:30px;
	    border-right:1px solid #ccc;
	}
	.index_wrap .sBox button{
		float:right;
		background-color:#f76a0e;
		width:120px;
		height:35px;
		color:#fff;
		border:none;
		cursor:pointer;
		font-weight:700;
	}
	.index_wrap .sBox #mainSearch{
		width:77%;
		height:35px;
		border:0;
		padding:3px;
		
	}
	
	/* section2 */
	
	.index_wrap .sec2 .title{
		text-align:center;
	}
	.index_wrap .sec2 .title strong{
		display:block;
	}
	.index_wrap .sec2 .title span{
		font-size:14px;
		font-weight:400;
	}
	
	/* section3 viewBox */
	.index_wrap .viewBox{
		padding:30px 0;
	}
	
	.index_wrap .viewBox .title{
		font-size:30px;
	}
	.index_wrap .viewBox .tInfo strong{
		padding-right:10px;
	}
	.index_wrap .viewBox .tInfo span{
		color:#aaa;
	}
	
	.index_wrap .viewBox .ex{
		padding:10px 0;
		font-size:14px;
		font-weight:400;
	}
	.index_wrap .viewRoom{
		padding-top:40px;
		height:269px;
		overflow:hidden;
	}
	.index_wrap .viewRoom ul::after{
		display:block;
		clear:both;
		content:"";
	}
	.index_wrap .viewRoom ul li{
		width:25%;
		float:left;
		
	}
	.index_wrap .viewRoom ul li > span{
		display:block;
		width:98%;
		border:1px solid #ccc;
		background-color:#dfdfdf;
		border-radius:20px;
		text-align:center;
		height:175px;
		line-height:175px;
		margin:0 1%;
		font-size:12px;
		color:#333;
	}
	
	.index_wrap .viewRoom ul li > a{
		display:block;
		width:98%;
	}
	.index_wrap .viewRoom ul li > a > .zzimImg{
		display:block;
		width:100%;
		height:175px;
		
	}
	.index_wrap .viewRoom ul li > a > .zzimImg img{
		width:100%;
		height:100%;
		border:1px solid #ccc;
	}
	.index_wrap .viewRoom ul li > a p{
		font-size:14px;
	 	white-space: nowrap; 
	    overflow: hidden;
	    text-overflow: ellipsis;
    }
    
    #searchTxt{
    	text-align:center;
    }
    #searchTxt > p{
    	padding:35px 10px;
    }
    #searchTxt > a{
    	font-size:12px;
    	padding:35px 10px;
    	display:inline-block;
    }
</style>

<div class="index_wrap">
	<div class="garo-container">
		<div class="garo-box">
			<div class="section sec1">
				<h2 class="title">
					<span>
						<b>어떤 동네,어떤 방</b>으로
					</span>
					<span>
						가고 싶으신가요?
					</span>
				</h2>
				 <div class="mainSearch">
					<div class="sBox">
						<span class="searchImg"><i class="fas fa-search"></i></span>
						<input type="text" id="mainSearch" name="mainSearch" placeholder="지역을 입력해 주세요.">
						<button type="button">방찾기</button>
					</div>
				</div>
			</div>
			<!-- section1 -->
			 <div class="section sec2">
				<h2 class="title">
					<strong>쉬운 방 찾기</strong>
					<span class="ex">방을 쉽게 확인하기 위한 이미지</span>
				</h2>
				<div id="searchTxt">
						
				</div>
			</div>
			<!-- section1 -->
			<div class="section sec3">
				<div class="viewBox">
					<h2 class="title">
						<div class="tInfo">
							<strong>최근 본방</strong>
						</div>
						<div class="ex">
							<span>방을 쉽게 확인하기 위한 이미지</span>
						</div>
						
					</h2>
					<div class="viewRoom sessionList">
						<ul>
						<% if(item != null){ %>
						
						<% }else{ %>
							<li>
								<span>
									아직 못 본 더 많은 방이 있어요.
								</span>	
							</li>
							<li>
								<span>
									아직 못 본 더 많은 방이 있어요.
								</span>	
							</li>
							<li>
								<span>
									아직 못 본 더 많은 방이 있어요.
								</span>	
							</li>
							<li>
								<span>
									아직 못 본 더 많은 방이 있어요.
								</span>	
							</li>
							<% } %>
						</ul>
					</div>
				</div>
<%
					
					
%>
				<!-- viewRoom1 -->
				<div class="viewBox">
					<h2 class="title">
						<div class="tInfo">
							<span>
								찜한 방
							</span>
						</div>
						<div class="ex">
							<span>방을 쉽게 확인하기 위한 이미지</span>
						</div>
					</h2>
					<div class="viewRoom <% if(sessionId != null) out.println("zzimList");%>">
						<ul>
						<%
						BoardProDAO zzimDao = BoardProDAO.getInstance();
						ArrayList<ZzimDTO> zzimCheck = zzimDao.zzimCheck(sessionId);
						int zSize = zzimCheck.size()-1;
							if(sessionId != null){
								for(int i=zSize; i >= 0 ;i--){
									BoardDTO zlist = zzimDao.zzimList(zzimCheck.get(i).getId(), zzimCheck.get(i).getPro_userName(), zzimCheck.get(i).getAgent_name());
						%>
							<li data="<%=i %>">
								<a href="proDetail.mp?id=<%=zzimCheck.get(i).getId() %>&agent_name=<%=zzimCheck.get(i).getAgent_name() %>" >
									<span class="zzimImg">
										<img src="bbsThum/<%=zlist.getThumbnail_file() %>" />
									</span>
									<p class="zzimTitle">
										상호명 : <strong><%=zlist.getBusiness_name().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %></strong>
									</p>
									<p class="zzimEx">
										내용 : <%=zlist.getDetail_ex().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %>
									</p>
									<p class="zzimAddr">
										주소 : <%=zlist.getBusiness_addr() %>
									</p>
								</a>
							</li>
						<% 
								}
							}else{ 
						%>
							<li>
								<span>
									찜한방이 없습니다.
								</span>	
							</li>
							<li>
								<span>
									찜한방이 없습니다.
								</span>	
							</li>
							<li>
								<span>
									찜한방이 없습니다.
								</span>	
							</li>
							<li>
								<span>
									찜한방이 없습니다.
								</span>	
							</li>
						<% } %>
						</ul>
					</div> 
				</div>
				<!-- viewRoom1 -->
			</div>
			<!-- section1 -->
		</div>
	</div>
</div>
<script>
/* 	liSort();
	function liSort(){
	    var li = $('.zzimList ul').find(li); //리스트의 자식엘리먼트를 가져와 변수에 저장
	    var num1 =$(".zzimList ul li:eq(0)").attr("data");
	    var num2 = li.length;
	    li.sort(function(a,b){ 
	          return num1 - num2;
	     });
	     $.each(li,function(index,row){ 
	          $('.zzimList ul').append(row);
	     });
	
	} */

	$("input[name='mainSearch']").on("keyup",mainSearch);
	
	function mainSearch(){
		var s = $("input[name='mainSearch']").val();
		var txt = document.getElementById("searchTxt");
		txt.innerHTML = "";
		$.ajax({
			type : "get",
			url : "mainSearch.mp",
			data : {q : s},
			success : function(result){
				if(result == 0){
					txt.innerHTML = "<p>찾으시는 지역의 정보가 없습니다.</p>";
				}else{
				var par = JSON.parse(result);
				var result = par.result;
				
				for(var i = 0 ; i < result.length;i++){
					var at = document.createElement("a");
					at.setAttribute("href","proDetail.mp?id="+result[i][0].value+"&agent_name="+result[i][1].value);
					var span = document.createElement("span"); //tr 태그 생성
					txt.appendChild(at);
					at.appendChild(span);
					span.innerHTML = "[ <strong>상호명 : </strong>"+result[i][1].value+" ]";
				}
				
				}
				
				if(s==""){
					txt.innerHTML = " ";
				}
			}	
		});
		
	}

	sessionList(); 

 	function sessionList(){
 		var guestId = $("input[name='guestUser']").val();
		
		$.ajax({
			type : "POST",
			url : "sessionList.mp",
			success : function(data){
				var par = JSON.parse(data);
				var list = par.lists;
				var lastSize = 4;
				for(var i = 0 ;i < list.length;i++){
					 addJson(list[i][0].id,list[i][0].img,list[i][0].name,list[i][0].ex,list[i][0].address);
					}
				var liSize = $(".sessionList li").length;
				var sizeSum = liSize; 
				var sizeSum = lastSize-liSize;
				for(var i = 0; i< sizeSum;i++){
					$(".sessionList ul").append("<li><span>최근본 방이 없습니다.</span></li>");
				}
			}	
		});
	}
	function addJson(id,img,name,ex,address){
		$(".sessionList ul").prepend("<li>"+
				"<a href='proDetail.mp?id="+id+"&agent_name="+name.replace(/ /gi,"&nbsp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\n/gi,"</br>")+"' >"+
						"<span class='zzimImg'>"+
							"<img src='bbsThum/"+img+"' />"+
						"</span>"+
						"<p class='zzimTitle'>상호명 : "+name.replace(/ /gi,"&nbsp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\n/gi,"</br>")+"</p>"+
						"<p class='zzimEx'>내용 : "+ex.replace(/ /gi,"&nbsp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\n/gi,"</br>")+"</p>"+
						"<p class='zzimAddr'>주소 : "+address+"</p>"+
				"</a>"+
		"</li>");
	}
	
	function zzimAdd(){
		var liSize = $(".zzimList li").length;
		var lastSize = 4;
		var sizeSum = lastSize-liSize;
		for(var i = 0; i< sizeSum;i++){
			$(".zzimList ul").append("<li><span>찜한방이 없습니다.</span></li>");
		}
		
	}
	zzimAdd();
</script>
<%@ include file="footer.jsp" %>