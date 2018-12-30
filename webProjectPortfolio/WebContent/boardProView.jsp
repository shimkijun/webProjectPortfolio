<%@page import="org.web.bbsProDTO.ZzimDTO"%>
<%@page import="org.web.bbsProDTO.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<%
	ArrayList<BoardDTO> view = (ArrayList<BoardDTO>)request.getAttribute("view");
	ZzimDTO zzimChk = (ZzimDTO)request.getAttribute("zzimChk");
%>
<script>
$(".nav .gnb li:eq(2) > a").css({"color":"#f76a0e"});
</script>

<style>
	body{
		background-color:#f6f6f6;
	}
	.bx-wrapper{
		margin-bottom:0;
	}
	
	#zzim.on{
		background-color:#f76a0e;
		color:#fff;
		font-weight:700;
	}
</style>
<input type="hidden" name="loginId" value="<%=sessionId %>" />
<input type="hidden" name="item_id" value="<%=view.get(0).getPro_id() %>" />
<input type="hidden" name="pro_userName" value="<%=view.get(0).getPro_userName() %>" />
<div class="boardProView_wrap">
	<div class="proView">
		<div class="container">
			<div class="proView-left-wrap">
				<div class="proView-slider-box">
					<ul class="slider">
					  <li><a href="#none"><img src="/bbsThum/<%=view.get(0).getThumbnail_file() %>" /></a></li>
					</ul>
					<div class="bx-pager">
						<a data-slide-index="0" href=""><img src="/bbsThum/<%=view.get(0).getThumbnail_file() %>" /></a>
					</div>
				</div>
				<div class="proViewInfo">
					<h2>
						<%=view.get(0).getBusiness_name().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %>
					</h2>
					<div class="proViewTable">
						<ul>
							<li class="line bigLine">
								<div class="line_th">
									<p>보증금</p>
									<p>월세</p>
									<p>등록번호</p>
								</div>
								<div class="line_td">
									<p><span>1억1,000</span> 만원</p>
									<p><span>0</span>만원</p>
									<p><strong>13241234</strong></p>
								</div>
								<div class="line_th">
									<p>방구조</p>
									<p>건물형태</p>
									<p>층/건물층수</p>
								</div>
								<div class="line_td">
									<p>투룸(방2,거실1)</p>
									<p>다세대/다가구</p>
									<p>반지하/4층</p>
								</div>
							</li>
							<li class="line bigLine">
								<div class="line_th">
									<p>관리비</p>
									<p>관리비 포함항목</p>
									<p>크기</p>
								</div>
								<div class="line_td">
									<p>1 만원</p>
									<p>-</p>
									<p>전용면적 52.89m2 (16p)</p>
								</div>
								<div class="line_th">
									<p>주차</p>
									<p>엘레베이터</p>
									
								</div>
								<div class="line_td">
									<p>불가능</p>
									<p>없음</p>
								</div>
							</li>
							<li class="line">
								<div class="line_th">
									<p>옵션</p>
								</div>
								<div class="line_td">
									<p>-</p>
								</div>
							</li>
							<li class="line">
								<div class="line_th">
									<p>상세 설명</p>
								</div>
								<div class="line_td">
									<p>
										<%=view.get(0).getDetail_ex().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","</br>") %>
									</p>
								</div>
							</li>
							<li class="line">
								<div class="line_th">
									<p>주소</p>
									<p>인근전철역</p>
								</div>
								<div class="line_td">
									<p><%=view.get(0).getBusiness_addr() %></p>
									<p><%=view.get(0).getBusiness_addr1() %></p>
								</div>
							</li>
							<li class="line info">
								<div class="line_th">
									<p>등록자 정보</p>
								</div>
								<div class="line_td">
									<p><strong>삼성공인중개사</strong></p>
									<p>서울시 성북구 안암동3가</p>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="proViewMap">
					<div id="map"></div>
				</div>
				<%-- <div class="proViewLike">
					<input type="hidden" name="likeUser" id="likeUser" value="<%=sessionId %>" />
					<input type="hidden" name="listNum" id="listNum" value="2" />
					<input type="checkbox" name="likeNum" id="likeNum" value=""/>
					<label for="likeNum" class="likeUp" >
						좋아요
						<br/>
						 <%=likeCount %>
					</label>
				</div> --%>
			</div>
			<div class="proView-right-wrap">
				<div class="proView-box box1">
					<div class="proView-line">
						안심충개사 가 등록한 방입니다.
					</div>
					<div class="proView-line">
						<button type="button" id="zzim" class="<% if(zzimChk != null) out.print("on"); %>">
							<% if(zzimChk != null) out.print("찜 취소"); else out.print("찜 하기"); %>
						</button>
					</div>
				</div>
				<!-- <div class="proView-box box2">
					<div class="proView-line">
						<div class="proViewUserInfo">
							<p>
								이미지
							</p>
							<p>
								중개보조원 이경희
							</p>
						</div>
						<div class="viewUserTel">
							<button type="button">연락처보기</button>
						</div>
					</div>
				</div> -->
				<!-- <div class="proView-box box3">
					<div class="proView-line">
						<div class="proInfoMsg">
							<h4>
								간편하게 문의 요청하기
							</h4>
							<p class="msgText">
								<strong>
									[문자보내기]를 사용하면 원하는 시간에<br/>
									상담을 받으실 수 있습니다.
								</strong>
							</p>
							<p><img src="img/img_msge2cut.png" /></p>
						</div>
						<div class="proInfoForm">
							<form>
								<div class="form_line">
									<p>
										<label for="proViewPhone">연락처</label>
									</p>
									<p>
										<input type="tel" name="proViewPhone" id="proViewPhone" placeholder="휴대폰 번호만 남기실 수 있습니다">
									</p>
									<p>
										<input type="checkbox" name="proViewAgree" id="proViewAgree">
										<label for="proViewAgree">
											개인정보수집 이용동의[약관보기]
										</label>
									</p>
								</div>
								<div class="form_line">
									<p>
										<label for="proViewComment">문의 사항</label>
									</p>
									<p>
										<textarea name="proViewComment" id="proViewComment" placeholder="궁금한점 문의합니다."></textarea>
									</p>
								</div>
								<div class="form_line">
									<button type="button">문자보내기</button>
								</div>
							</form>
						</div>
					</div> -->
				</div> 
			</div>
		</div>
	</div>
</div>
<script>
$(".likeUp").on("click",function(){
	var  likeUser = $("#likeUser").val(); //게시판 좋아요 누른 id
	var listNum = $("#listNum").val(); //게시판 번호
	var likeNum = "1"; //좋아요를 눌렀으면 1 아니면 0
	$.ajax({
		type : "POST",
		url : "likeUpDown.li",
		data : {
				likeUser : likeUser,
				listNum : listNum,
				likeNum : likeNum,					
			},
		success : function(result){
			if(result == -1){
				alert("회원만 이용 가능합니다.");
			}else if(result == 1){
				alert("좋아요");
				$(".proViewLike label").addClass("likeDown").removeClass("likeUp");
			}
		}
	});
});

$("#zzim").on("click",function(){
	var loginId = $("input[name='loginId']").val();
	var item_id = $("input[name='item_id']").val();
	var pro_userName = $("input[name='pro_userName']").val();
	var agent_name = $(".proViewInfo h2").text().trim();

	$.ajax({
		type : "POST",
		url : "zzim.mp",
		data : {
				loginId : loginId,
				item_id : item_id,
				agent_name : agent_name,					
				pro_userName : pro_userName,
			},
		success : function(result){
			if(loginId == null || loginId == "null" || result == -1){
				alert("회원만 사용 가능합니다.");
				return;
			}else if(result == 1){
				alert("찜 완료");	
				location.reload();
			}else if(result == 0){
				alert("찜 삭제");
				location.reload();
			}
		}
	});
});

</script>
<script>
    $(document).ready(function(){
      $('.slider').bxSlider({
    	  mode : 'horizontal',
    	  speed:500,
    	  pager:true,
    	  moveSlides:1,
    	  autoHover:true,
    	  adaptiveHeight: true,
    	  pagerCustom: '.bx-pager'
      });
      
      var container = document.getElementById('map');
	  	var options = {
	  		center: new daum.maps.LatLng(33.450701, 126.570667),
	  		level: 3
	  	};

  		var map = new daum.maps.Map(container, options);
      
    });
  </script>
  
 <script>
	
</script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0133dcaed0bd462fc689ea050efdfaa9"></script>
<%@ include file="footer.jsp" %>
