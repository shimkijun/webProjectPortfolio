<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0133dcaed0bd462fc689ea050efdfaa9&libraries=services"></script>
<script>
	$(".nav .gnb li:last > a").css({"color":"#f76a0e"});
</script>
<style>
	.container{
		width:650px;
		margin:0 auto;
	}
	.proWrite_title h2{
		padding: 20px 0;
	    font-size: 20px;
	    color: #ff4b25;
	}
	
	.proWrite_table{
		border:1px solid #ccc;
		padding:15px;
	}
	.proWrite_table ul li::after{
		display:block;
		clear:both;
		content:"";
	}
	.proWrite_table ul > li{
		padding:10px;
	}
	.proWrite_table ul li > div{
		float:left;
		font-size:12px;
	}

	
	.proWrite_table div.write_th{
		font-weight:700;
		color:#333;
		width:15%;
	}
	.proWrite_table div.write_td{
		width:85%;
	}
	.proWrite_table div.write_td input{
		border:1px solid #ccc;
		padding:3px;
		margin:0;
		height:30px;
	}
	.proWrite_table ul > li.map_box{
		padding:0;
	}
	.addr_box{
		padding-bottom:5px;
	}
	#postNum{
		width:140px;
	}
	#sample5_address{
		width:279px;
	}
	input[type="button"]{
		width:80px;
		background-color:#ff4b25;
		color:#fff;
		font-size:12px;
		text-align:center;
		border:1px solid #ccc;
		cursor:pointer;
	}
	#business_addr1{
		width:423px;
	}
	
	#detail_ex{
		width:100%;
		resize:none;
		height:350px;
		border:1px solid #ccc;
	}
	
	.submitBox{
		text-align:right;
	}
	.submitBox input{
		width:80px;
		padding:5px 0;
		border:1px solid #ff4b25;
		color:#ff4b25;
		background-color:#fff;
		cursor:pointer;
	}
	
	#map{
		width:100%;
		height:300px;
		margin-bottom:5px;
		display:none;
	}
</style>
<div class="proWrite_wrap">
	<div class="container">
		<div class="proWrite_title">
			<h2>펜션정보를 입력하세요</h2>
		</div>
		<div class="proWrite_table">
			<form action="mapInsert.mp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="pro_userName" value="pro_userName">
			<input type="hidden" id="LatY" name="LatY" placeholder="y"/>
			<input type="hidden" id="LngX" name="LngX" placeholder="x"/>
			<ul>
				<li>
					<div class="write_th">
					   <label for="business_name">펜션이름</label>
					</div>
					<div class="write_td">
					    <input type="text" id="business_name" name="business_name" autocomplete="off">
					</div> 
				</li>
				<li>
					<div class="write_th">
					   <label for="business_addr1">펜션위치</label>
					</div>
					<div class="write_td">
						<div class="addr_box">
						    <input type="text" id="postNum" placeholder="우편번호" name="postNum" autocomplete="off">
							<input type="text" id="sample5_address" placeholder="주소" name="business_addr" autocomplete="off">
							<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
						</div>
						<div class="addr_box">
							<input type="text" id="business_addr1" placeholder="상세주소" name="business_addr1" autocomplete="off">
						</div>
						
					</div> 
				</li>
			    
			    <li>
					<div class="write_th">
					   <label for="detail_ex">상세설명</label>
					</div>
					<div class="write_td">
					    <textarea name="detail_ex" id="detail_ex"></textarea>
					</div> 
				</li>
				<li class="map_box">
			    	<div id="map"></div>
			    </li>
				<li>
					<div class="write_th">
					   <label for="detail_ex">썸네일이미지</label>
					</div>
					<div class="write_td">
					    <p>
							<input type="file" class="thumbnail_file" name="thumbnail_file" />
						</p>
					</div> 
				</li>
				<!-- <li>
					<div class="write_th">
					   <label for="detail_ex">슬라이드이미지</label>
					</div>
					<div class="write_td">
					    <p class="file_box">
							<input type="file" class="slide_file" name="slide_file" />
							<button type="button" class="thum_plus">+</button>
						</p>
					</div> 
				</li>
				 -->
				<li class="submitBox">
					<input type="submit" id="proWriteBtn" value="작성완료">
				</li>
			</ul>
			
			</form>
		</div>
	</div>
</div>

<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });
	
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postNum").value=data.zonecode;
                document.getElementById("sample5_address").value = fullAddr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                        var resultY = document.getElementById("LatY").value= result.y;
                        var resultX = document.getElementById("LngX").value= result.x;
                       
                    }
                });
            }
        }).open();
    	
    }
    
    /* $(function(){
    	$(".thum_plus").on("click",function(){
    		var imgLength = $('.thumbnail_file').length;
    		if(imgLength < 5){
    		$( ".file_box" ).append( "<input type='file' class='thumbnail_file' name='thumbnail_file' />" );
    		}else{
    			alert('더이상 추가할 수 없습니다.');
    		}
    	});
    }); */
    
</script>
<%@ include file="footer.jsp" %>