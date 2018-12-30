<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0133dcaed0bd462fc689ea050efdfaa9&libraries=clusterer,services"></script>
<script>
$(".nav .gnb li:eq(2) > a").css({"color":"#f76a0e"});
</script>
<style>
	body{
		height:100vh;
		overflow:hidden;
	}
	.viewMap_left{
		position:absolute;
		left:0;
		top:49px;
		right:400px;
	}
	#map{
		width:100%;
		height:100vh;
		float:left;
	}
	.viewMap_right{
		width:400px;
		height:100vh;
		position:absolute;
		right:0;
		top:49px;
		z-index:1;
		overflow:hidden;
	}
	.mapList{
		height:100%;
	}
	
	.mapList ul li{
		height:115px;
		overflow:hidden;
		margin-bottom:10px;
		background-color:#fff;
		
	}
	
	.itemList_box::after{
		display:block;
		clear:both;
		content:"";
	}
	
	.itemList_box{
		height:100%;
	}
	
	#allList{
		width:416px;
		overflow-y:scroll;
		height:100%;
		background-color:#ccc;	
		padding:10px;
	}
	
	#allList a {
		display:block;
		width:100%;
		height:100%;
	}
	.itemList_box > div{
		float:left;
		height:100%;
	}
	.item_img{
		width:165px;
		height:100%;
	}
	.item_img img{
		width:100%;
		height:100%;
	}
	.item_info{
		width:198px;
		padding:10px;
	}
	
	.item_info h2{
		width:100%;
		font-size:14px;
		white-space: nowrap; 
    	overflow: hidden;
    	text-overflow: ellipsis;
    	color:#333;
    	padding-bottom:5px;
	}
	.item_info .price{
		font-weight:700;
		font-size:16px;
		color:#ff4b25;
	}
	.item_info p{
		width:100%;
		white-space: nowrap; 
    	overflow: hidden;
    	text-overflow: ellipsis;
    	font-size:14px;
    	padding-bottom:5px;
	}
	
	.item_info p.item_ex span{
		color:#a5a59e;
	}
	
	
	
	.mapViewSearch{
		position: absolute;
	    left: 90px;
	    top: 120px;
	    width: 400px;
	    z-index: 3;
	}
	.mvSearchBox{
		width:100%;
		border:5px solid #ff4b25;
	   border-radius:5px;
	   background-color:#fff;
	}
	
	.searchToggle{
		background-color:#ff4b25;
		color:#fff;
		font-weight:700;
		text-align:center;
		font-size:16px;
		width:15px;
		height:15px;
		line-height:11px;
		position:absolute;
		left:0;
		top:-18px;
		border-radius:3px;
		cursor:pointer;
	}
	#searchMap{
		width:100%;
		border:0;
		padding:4px 10px;
	}
	
	#searchBtn{
		position: absolute;
	    right: 5px;
	    width: 80px;
	    top: 5px;
	    border: 0;
	    color: #ff4b25;
	    background-color: #fff;
	    border-left: 5px solid #ff4b25;
	    line-height: 24px;
	    cursor:pointer;
	}
	#searchBtn:focus {
		outline: 0;
	}
	span.no{
		display:none;
	}
	.mvSearchBox.close{
		display:none;
	}
</style>
<div class="proMapView_wrap">
	<div class="viewMap_left">
		<div id="map"></div>
	</div>
	<div class="viewMap_right">
		<div class="mapList" id="autoScroll">
			<ul id="allList">
			</ul>
		</div>
	</div>
</div>
<script>

	allListMap();
	function allListMap(){
		$.ajax({
			type : "POST",
			url: "scroll.mp",
			success : function(data){
				if(data == "") return;
				var parsed = JSON.parse(data);
				var items = parsed.items;
				for(var i = 0; i < items.length;i++){
				addListMap(items[i][0].item_id,items[i][2].agent_name,items[i][3].agent_comment,items[i][5].agent_address,items[i][7].agent_img);
				}
			}
		});
	}

	function addListMap(no,agent_name,agent_comment,agent_address,agent_img){
		$("#allList").append("<li>"+
			"<a href='#none'>"+
				"<span class='no'>"+no+"</span>"+
				"<div class='itemList_box'>"+
					"<div class='item_img'>"+
						"<img src='bbsThum/"+agent_img+"' />"+
					"</div>"+
					"<div class='item_info'>"+
						"<h2 class='item_name'>"+
							agent_name.replace(/ /gi,"&nbsp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\n/gi,"</br>") +
						"</h2>"+
						"<p class='price'>" +
							"40,000"+
						"</p>"+
						"<p class='item_addr'>"+
							agent_address+
						"</p>"+
						"<p class='item_ex'>"+
							agent_comment.replace(/ /gi,"&nbsp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\n/gi,"</br>")+
						"</p>"+
					"</div>"+
				"</div>"+
			"</a>"+
		"</li>");
		}
	

		
		$(document).on("click","#allList > li",function(){
			 var idx = $(this).index();
			 var item_id = $(this).find("span.no").text();
			 var agent_name = $(this).find(".item_name").text();
			 var agent_user = $(this).find("input[name='agent_user']").val();
			 $.ajax({
					type : "POST",
					url: "proView.mp",
					data : {item_id:item_id,agent_name:agent_name},
					success : function(result){
						if(result == 1){
							location.href="proDetail.mp?id="+item_id+"&agent_name="+agent_name;
						}else{
							alert("잘못된 경로입니다.");
						}
					}
				});
		});
</script>
<script>	


    var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new daum.maps.LatLng(37.15072, 127.05054720000001), // 지도의 중심좌표
        level : 11 // 지도의 확대 레벨
    });

    var geocoder = new daum.maps.services.Geocoder();
    
	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();
	
	 // 지도 타입 컨트롤을 지도에 표시합니다
	 map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	 
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	 map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

	
	

	
    // 마커 클러스터러를 생성합니다
    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다
    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다
    var clusterer = new daum.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
        minLevel: 2, // 클러스터 할 최소 지도 레벨
        disableClickZoom: true, // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
        calculator: [10, 30, 50,100],
        styles: [{ // calculator 각 사이 값 마다 적용될 스타일을 지정한다
            width : '40px', height : '40px',
            background: 'rgba(255, 255, 255, .8)',
            borderRadius: '100%',
            color: '#ff4b25',
            textAlign: 'center',
            fontWeight: 'bold',
            lineHeight: '41px'
        },
        {
            width : '50px', height : '50px',
            background: 'rgba(255, 255, 255, .8)',
            borderRadius: '100%',
            color: '#ff4b25',
            textAlign: 'center',
            fontWeight: 'bold',
            lineHeight: '51px'
        },
        {
            width : '60px', height : '60px',
            background: 'rgba(255, 255, 255, .8)',
            borderRadius: '100%',
            color: '#ff4b25',
            textAlign: 'center',
            fontWeight: 'bold',
            lineHeight: '61px'
        },
        {
            width : '70px', height : '70px',
            background: 'rgba(255, 255, 255, .8)',
            borderRadius: '100%',
            color: '#ff4b25',
            textAlign: 'center',
            fontWeight: 'bold',
            lineHeight: '71px'
        },
        {
            width : '80px', height : '80px',
            background: 'rgba(255, 255, 255, .8)',
            borderRadius: '100%',
            color: '#ff4b25',
            textAlign: 'center',
            fontWeight: 'bold',
            lineHeight: '81px'
        }
    ]

    });
    // 데이터를 가져오기 위해 jQuery를 사용합니다
    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
    $.get("json/location.json", function(data) {
    	// 주소로 좌표를 검색합니다
    	
    	//마커가 1개 일때 1로 보여질수 있도록 이미지 변경 (꼼수)
    	 var icon = new daum.maps.MarkerImage(
       	    'img/marker_num1.png',
       	    new daum.maps.Size(40, 40)
       	);
 			
 	    // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = $(data.positions).map(function(i, position) {
            return new daum.maps.Marker({
                position : new daum.maps.LatLng(position.lat, position.lng),
                image : icon
            });
        });
       
 	    
        // 클러스터러에 마커들을 추가합니다
        clusterer.addMarkers(markers);
    });

    // 마커 클러스터러에 클릭이벤트를 등록합니다
    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

        // 현재 지도 레벨에서 1레벨 확대한 레벨
        var level = map.getLevel()-1;

        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
        map.setLevel(level, {anchor: cluster.getCenter()});
    });
</script>
<%@ include file="footer.jsp" %>
