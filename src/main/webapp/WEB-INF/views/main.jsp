<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>geolocation으로 마커 표시하기</title>
</head>
<body>
<p style="margin-top:-12px">
    <b>Chrome 브라우저는 https 환경에서만 geolocation을 지원합니다.</b> 참고해주세요.
</p>
<div id="map" style="width:500px;height:350px;"></div>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0c41ee7938be09dffb8f43413a742eb"></script>
<script>
//지도를 표시할 div
var mapContainer = document.getElementById('map'), 
    mapOption = 
    { 
		// 지도의 중심좌표
        center: new kakao.maps.LatLng(33.450701, 126.570667), 
    	// 지도의 확대 레벨    
        level: 6
    }; 

//지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation)
{
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(
   		function(position)
	    {
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	            
	        // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	        var locPosition = new kakao.maps.LatLng(lat, lon),
	     	// 인포윈도우에 표시될 내용입니다
	            message = '<div style="padding:5px;">현재 위치</div>'; 
	        //json으로 보낼 위도,경도
	        var data = {"lat": lat,
	        			"lon": lon};
	        var positions = [];
	        //ajax호출
	        $.ajax
	        ({
	        	type : "POST",
				url : "/location",
				data : JSON.stringify(data),
				dataType : "JSON",
				contentType : "application/json; charset=UTF-8",
				async : false,
				success : function(result)
				{	
					//일정 반경이내의 배드민턴장 위치
					var closestList = result.closestList
					//positions에 title,latlng속성가진 obj로 변환하여 추가
					for(var i in closestList)
					{
						var obj = new Object();
						obj.title = closestList[i].name;
						obj.latlng = new kakao.maps.LatLng(closestList[i].lon, closestList[i].lat);
						positions.push(obj)
						//console.log("lon" + closestList[i].lon);
						//console.log("lat" + closestList[i].lat);
					}
					
			        //마커 image url
			        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			        
			        // 각 위치에 마커 생성
			        for (var i = 0; i < positions.length; i ++) 
			        {
			            // 마커 이미지의 이미지 크기 입니다
			            var imageSize = new kakao.maps.Size(24, 35); 
			            
			            // 마커 이미지를 생성합니다    
			            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			            
			            // 마커를 생성합니다
			            var marker = new kakao.maps.Marker
			            ({
			                map: map, // 마커를 표시할 지도
			                position: positions[i].latlng, // 마커를 표시할 위치
			                title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			                image : markerImage // 마커 이미지 
			            });
			            
			            var lat = positions[i].latlng.getLat();
			            var lng = positions[i].latlng.getLng();
			            var latlngString = lat + ',' + lng;
			            var iwRemoveable = true;
			            var iwContent = '<div style="padding:6px; width:230px;">'+ positions[i].title +'<br><a href="https://map.kakao.com/link/map/'
			            				+ positions[i].title + ',' + latlngString + '" style="color:blue" target="_blank">지도보기</a> <a href="https://map.kakao.com/link/to/'
			            				+ positions[i].title + ',' + latlngString + '" style="color:blue" target="_blank">길찾기</a></div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			            var iwPosition = positions[i]; //인포윈도우 표시 위치입니다
			            var previousInfowindow = null;
			            // 마커 클릭 이벤트 리스너 추가
		           	    addClickListener(marker, iwContent, previousInfowindow);
		           	    
				        // 현재위치의 마커, message표시
				        crrentMarker(locPosition, message);
			        }
			        
				}//success
	        })//$ajax
	    }//function(position)
    )//getCurrentPosition
} else 
	{ // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        message = 'geolocation을 사용할수 없어요..'
	        crrentMarker(locPosition, message);
	}


// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function crrentMarker(locPosition, message) 
{
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker
    ({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow
    ({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}

function addClickListener(marker, iwContent) 
{	
	var previousInfowindow = null;
	var infowindow = new kakao.maps.InfoWindow
	({
        position: marker.getPosition(),
        content: iwContent,
        removable: true
    });

    //
    function clickHandler()
    {
        // 새 인포윈도우 열기
        infowindow.setPosition(marker.getPosition());
        infowindow.open(map, marker);
    }

    // 이전 인포윈도우가 있다면 이전 클릭 이벤트를 제거합니다.
    if (previousInfowindow) {
        kakao.maps.event.removeListener(marker, 'click', previousInfowindow);
    }

    // 클릭 이벤트 핸들러를 등록합니다.
    kakao.maps.event.addListener(marker, 'click', clickHandler);

    // 이전 클릭 이벤트를 저장합니다.
    previousInfowindow = clickHandler;
}


</script>
</body>
</html>