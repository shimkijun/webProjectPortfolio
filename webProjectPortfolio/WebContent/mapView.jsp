<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커 클러스터러에 클릭이벤트 추가하기</title>
</head>
<script>
	
</script>
<style>
	#map{
		width:100%;
		height:100vh;
	}
</style>
<body>
<div id="map"></div>
<script src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0133dcaed0bd462fc689ea050efdfaa9&libraries=clusterer"></script>
<script>	

    var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new daum.maps.LatLng(37.15072, 127.05054720000001), // 지도의 중심좌표
        level : 9 // 지도의 확대 레벨
    });
 
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
        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = $(data.positions).map(function(i, position) {
            return new daum.maps.Marker({
                position : new daum.maps.LatLng(position.lat, position.lng)
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
</body>
</html>