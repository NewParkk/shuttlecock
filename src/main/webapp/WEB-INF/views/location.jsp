<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지도 상세보기</title>
    <!-- Kakao Maps API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
/* 지도를 담을 영역의 크기 설정 */
#map {
    width: 100%;
    height: 1000px;
}
</style>
</head>
<body>
    <h1>지도 상세보기</h1>
    <div id="map"></div>

<script src="/js/main-map-js.js"></script>
</body>
</html>