<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Influencer Cat Detail</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/influencer.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

    <!-- Main Content Section -->
    <div class="mainContent">
        <!-- 카드와 간판 사진 -->
        <div class="cat-card">
            <!-- 카드 섹션: card.jsp 파일을 포함 -->
            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
            
            <!-- 간판 사진 -->
	 	<div class="signboard-photo">
	        <img src="https://cdn.dailyvet.co.kr/wp-content/uploads/2023/12/28225708/20231228ceva_experts4.jpg" 
	             alt="간판 사진" class="main-signboard-photo">
	    </div>
        </div>

        <!-- 가로 스크롤 사진 리스트 -->
		<div class="photo-gallery-wrapper">
		    <div class="photo-gallery">
		        <div class="photo-scroll-container">
		            <c:forEach begin="1" end="10" var="i">
		                <img src="https://cdn.dailyvet.co.kr/wp-content/uploads/2023/12/28225708/20231228ceva_experts4.jpg" 
		                     alt="작은사진 ${i}" class="thumbnail-photo">
		            </c:forEach>
		        </div>
		    </div>
		</div>

        <!-- 지도 섹션 -->
        <div class="cat-map">
            <div id="map-container"></div> <!-- 지도 표시될 영역 -->
        </div>

        <!-- 연관 포스트 섹션 -->
		<div class="related-posts">
		    <div class="post-blocks">
		        <c:forEach begin="1" end="5" var="post">
		            <div class="post">
		                <h4>고양이 포스트 제목 ${post}</h4>
		                <p>이것은 고양이 포스트 설명입니다. ${post}</p>
		                <img src="https://cdn.dailyvet.co.kr/wp-content/uploads/2023/12/28225708/20231228ceva_experts4.jpg" 
		                     alt="포스트 이미지 ${post}" class="post-photo">
		                <p class="post-date">2024-12-${post}</p>
		            </div>
		        </c:forEach>
		    </div>
		</div>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>

    <!-- Leaflet JS for Map -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        // 지도 객체 생성 및 위치 설정 (대전광역시)
        var latitude = 36.3504119;
        var longitude = 127.3845475;
        var map = L.map('map-container').setView([latitude, longitude], 19);

        // 타일 레이어 추가 (OpenStreetMap)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // 마커 추가
        L.marker([latitude, longitude]).addTo(map)
            .bindPopup("<b>대전광역시</b><br>위도: " + latitude + "<br>경도: " + longitude).openPopup();

        // 반경 1km 원 추가
        L.circle([latitude, longitude], {
            color: 'blue',
            fillColor: '#a3c1ff',
            fillOpacity: 0.5,
            radius: 1000
        }).addTo(map);
    </script>
</body>
</html>
