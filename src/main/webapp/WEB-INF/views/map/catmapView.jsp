<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>cat-map</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        #map {
            height: 600px; /* 지도 높이 설정 */
            width: 90%;
    		border-radius: 30px;
        }
        body {
            background-color: #ffffff; /* 배경색 흰색으로 설정 */
        }
        .map-container {
            display: flex;
            flex-direction: column;
            align-items: center; /* 가운데 정렬 */
            justify-content: center;
            min-height: 100vh; /* 화면 중앙에 지도 배치 */
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/components/header.jsp"></jsp:include> <!-- 헤더 추가 -->

<div class="map-container">
    <h2>현재 위치를 기준으로 지도 표시</h2>
    <div id="map"></div> <!-- 지도 표시 영역 -->
</div>

<jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include> <!-- 푸터 추가 -->

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script>
    // 지도 객체 생성 (임시로 서울 시청 좌표를 사용)
    var map = L.map('map').setView([37.5665, 126.9780], 19); // 최대 확대 (19까지 확대)

    // 타일 레이어 추가 (OpenStreetMap)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,  // OpenStreetMap의 최대 줌 레벨 설정
        maxNativeZoom: 19  // 타일의 원래 최대 줌 레벨, 이후 확대 시 타일이 스케일링됨
    }).addTo(map);

    // 현재 위치를 가져오는 함수
    function onLocationFound(e) {
        var radius = e.accuracy / 2;

        // 현재 위치에 마커 추가
        var marker = L.marker(e.latlng).addTo(map)
            .bindPopup("현재 위치: " + e.latlng.toString()).openPopup();

        // 정확도에 따른 원 추가 (반지름)
        L.circle(e.latlng, radius).addTo(map);
    }

    // 위치를 찾지 못했을 경우
    function onLocationError(e) {
        alert("현재 위치를 가져올 수 없습니다: " + e.message);
    }

    // 현재 위치 가져오기 및 처리
    map.locate({setView: true, maxZoom: 19, maxNativeZoom: 19}); // 최대 확대 레벨로 설정
    map.on('locationfound', onLocationFound); // 위치를 찾았을 때 이벤트 처리
    map.on('locationerror', onLocationError); // 오류 발생 시 이벤트 처리

</script>

</body>
</html>
