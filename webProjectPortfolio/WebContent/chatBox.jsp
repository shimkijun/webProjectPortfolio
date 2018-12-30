
<%@page import="org.web.chatDAO.ChatDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String chatUser = "";
	if(sessionId != null){
		chatUser = (String)session.getAttribute("sessionId");
	}else{
		chatUser = (String)session.getId();
	}

	ChatDAO chatDao = ChatDAO.getInstance();
	int unreadCount = chatDao.unreadChat(chatUser,"admin");
	Calendar calendar = Calendar.getInstance();
    java.util.Date date = calendar.getTime();
    String today = (new SimpleDateFormat("yyyy년MM월dd일HH시mm분").format(date));
%>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- <script>
  $( function() {
    $( ".chat_box" ).draggable();
  } );
  </script> -->
<style>
	.chatBox{
		border:1px solid #ccc;
		width:300px;
		height:400px;
		overflow:hidden;
		display:none;
	}
	.chat_robot .chatHeading{
		width:100%;
		padding:5px 10px;
		color:#fff;
		font-weight:700;
		color:#ff4b25;
	}
	.chatView{
		width:315px;
		overflow-y:scroll;
		height:320px;
	}
	.chatView ul li{
		padding:7px 0;
	}
	
	.chat_title::after{
		display:block;
		clear:both;
		content:"";
	}
	.chat_title{
		font-size:12px;
		padding-bottom:7px;
	}
	.chat_title .chatUser{
		float:left;
		font-weight:700;
	}
	.chat_title .chatDate{
		float:right;
	}
	.chatView ul{
		padding:0 15px;
		height:100%;
	}
	.chatView ul::after{
		display:block;
		clear:both;
		content:"";
	}
	
	.chatView .toId{
		float:left;
		width:85%;
	}
	.chatView .toId .chat_txt{
		text-align:left;
		background-color:#ff4b25;
		color:#fff;
	}
	
	.chatView .fromId{
		width:85%;
		float:right;
	}
	.chatView .fromId .chat_txt{
		text-align:right;
		background-color:#efefef;
		color:#333;
	}
	.chat_txt{
		border-radius:5px;
		padding:10px;
		font-size:12px;
	}
	
	.chatInput{
		width:100%;
		height:47px;
		padding:0 15px;
		line-height:43px;
	}
	
	.chatInput input{
		border:1px solid #ccc;
		height:30px;
		width:196px;
		padding:0 5px;
	}
	.chatInput button{
		height: 30px;
	    margin: 0;
	    vertical-align: middle;
	    line-height: 27px;
	    border: 0;
	    padding: 0 13px;
	    background-color: #ff4b25;
	    color: #fff;
	    border-radius: 5px;
	    font-weight: 700;
	    cursor: pointer;
    }
    
   .chat_robot{
   	position: fixed;
    right: 50px;
    background: #fff;
    z-index: 1000;
    bottom: 50px;
   }
   .chatBtn{
   	background-color: #ff4b25;
    width: 40px;
    height: 40px;
    border-radius: 100%;
    text-align: center;
    line-height: 40px;
    color: #fff;
    cursor: pointer;
    position: absolute;
    right: 0;
    bottom: 0;
   }
   
   .chatClose{
   	float:right;
   	cursor:pointer;
   }
   
   #chatContent{
    width: 196px;
    vertical-align: middle;
    border: 1px solid #ccc;
    resize: none;
    padding: 5px;
    height: 30px;
    font-size: 12px;
    }
    
    span.unreadCount{
    	font-size: 12px;
	    width: 20px;
	    height: 20px;
	    border-radius: 100%;
	    background-color: #fff;
	    display: block;
	    border: 1px solid #f76a0e;
	    line-height: 20px;
	    color: #f76a0e;
	    position: absolute;
	    right: 0;
	    top: -9px;
    }
</style>
<div class="chat_robot">
	<div class="chatBox">
		<div class="chatList">
			<div class="chatHeading">
				<span>chat_robot</span>
				<span class="chatClose">x</span>
			</div>
			<form action="post" method="" name="chatForm">
				<div class="chatView">
					<ul>
						<li class="toId">
							<div class="chat_title">
								<span class="chatUser">
									admin
								</span>
								<span class="chatDate">
									<%=today %>
								</span>
							</div>
							<div class="chat_txt">
								안녕하세요 무엇이든 질문하세요.
							</div>
						</li>
					</ul>
				</div>
			</form>
		</div>
		<div class="chatInput">
			<textarea name="chatContent" id="chatContent" maxlength="100" placeholder="내용을 입력하세요."></textarea>
			<button type="button" onclick="submitFnc()">보내기</button>
		</div>
	</div>
	<div class="chatBtn">
		<% if(unreadCount > 0){ %>
			<span class="unreadCount">
				<%=unreadCount %>
			</span>
		<% } %>
		★
	</div>
</div>
<script>
	$(".chatBtn").on("click",function(){
		$(".chatBox").fadeIn();
		$(this).hide();
		chatListFnc(lastId);
	});
	
	$(".chatClose").on("click",function(){
		$(".chatBox").hide();
		$(".chatBtn").fadeIn();
	});
	
	function submitFnc(){
		var fromId = "<%=chatUser %>";
		var toId = "admin";
		var chatContent = $("#chatContent").val();
		$.ajax({
			type : "POST",
			url: "submit.ch",
			data : {
				fromId : fromId,
				toId : toId,
				chatContent : chatContent
			},
			success : function(data){
				chatListFnc(lastId);
			}
		});
		$("#chatContent").val("");
	}
	
	var lastId = 0;
	function chatListFnc(lastNum){
		var fromId = "<%=chatUser %>";
		var toId = "admin";
		$.ajax({
			type : "POST",
			url: "chatList.ch",
			data : {
				fromId : encodeURIComponent(fromId),
				toId : encodeURIComponent(toId),
				chatId : lastNum
			},
			success : function(data){
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for(var i = 0;i < result.length; i++){
					if(result[i][0].value == fromId){
						result[i][0].value = '나';
					}
					var chatName = result[i][0].value;
					var chatContent = result[i][2].value;
					var chatTime = result[i][3].value;
					addChat(chatName, chatContent , chatTime);
					lastId = Number(parsed.last);
				}
			}
		});
	}
	
	function addChat(chatName,chatContent,chatTime){
		if(chatName == '나'){
		$(".chatView ul").append("<li class='fromId'>"+		
			"<div class='chat_title'>"+
				"<span class='chatUser'>"+
				chatName +
				"</span>"+
				"<span class='chatDate'>"+
				chatTime+
				"</span>"+
			"</div>"+
			"<div class='chat_txt'>"+
				chatContent +
			"</div>"+
		"</li>");
		}else{
		$(".chatView ul").append("<li class='toId'>"+		
			"<div class='chat_title'>"+
				"<span class='chatUser'>"+
				chatName +
				"</span>"+
				"<span class='chatDate'>"+
				chatTime+
				"</span>"+
			"</div>"+
			"<div class='chat_txt'>"+
				chatContent.replace(/ /gi,"&nbsp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\n/gi,"</br>") +
			"</div>"+
		"</li>");
		}
		$(".chatView").scrollTop($(".chatView")[0].scrollHeight);
	}

</script>