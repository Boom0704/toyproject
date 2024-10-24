<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Influencer Cat Detail</title>
    <!-- Leaflet JS for Map -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet.markercluster/dist/leaflet.markercluster.js"></script>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/influencer.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.css" />
<link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.Default.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

    <!-- Main Content Section -->
    <div class="mainContent">
        <!-- 카드와 간판 사진 -->
        <div class="cat-card">
            <!-- 카드 섹션: card.jsp 파일을 포함 -->
            <jsp:include page="/WEB-INF/components/card.jsp">
			            <jsp:param name="id" value="${influencer.id}"/>
			            <jsp:param name="name" value="${influencer.name}"/>
			            <jsp:param name="mainPhoto" value="${influencer.mainPhoto}"/>
			            <jsp:param name="address" value="${influencer.address}"/>
			            <jsp:param name="updatedAt" value="${influencer.updatedAt}"/>
			</jsp:include>
            <!-- 간판 사진 -->
	 	<div class="signboard-photo">
	        <img src="${influencer.mainPhoto}" 
	             alt="${influencer.name}" class="main-signboard-photo">
	    </div>
        </div>

        <!-- 가로 스크롤 사진 리스트 -->
		<div class="photo-gallery-wrapper">
		    <div class="photo-gallery">
		        <div class="photo-scroll-container">
		            <c:forEach var="board" items="${boardList}">
		                <c:set var="photoUrlList" value="${fn:split(board.photoUrls, ',')}" />
		                <c:forEach var="photoUrl" items="${photoUrlList}">
		                    <img src="${photoUrl}" alt="Thumbnail" class="thumbnail-photo">
		                </c:forEach>
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
	            <c:forEach var="board" items="${boardList}">
	                <div class="profile-card" onclick="location.href='<%=request.getContextPath()%>/boardDetailView/${board.postId}'">
	                    <div class="profile-photo-container">
	                        <c:choose>
	                            <c:when test="${fn:contains(board.photoUrls, ',')}">
	                                <img class="profile-photo" src="${fn:substringBefore(board.photoUrls, ',')}" alt="고양이 사진">
	                            </c:when>
	                            <c:otherwise>
	                                <img class="profile-photo" src="${board.photoUrls}" alt="고양이 사진">
	                            </c:otherwise>
	                        </c:choose>
	                    </div>
	                    <div class="profile-info">
	                        <h2>${board.title}</h2>
	                        <p id="profile-views">조회수: ${board.views}</p> <!-- 위치 정보 표시 -->
	                        <h7>
							    <fmt:formatDate value="${board.createDt}" pattern="yyyy-MM-dd HH:mm" />
							</h7>
	                    </div>
	                </div>
	            </c:forEach>
		    </div>
		</div>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>
<script>
    // 지도 객체 생성 및 기본 위치 설정 (influencer의 좌표)
    const map = L.map('map-container').setView([${influencer.latitude}, ${influencer.longitude}], 19);

    // 타일 레이어 추가 (OpenStreetMap)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    // 마커 클러스터 그룹 생성
    var markers = L.markerClusterGroup({
        iconCreateFunction: function(cluster) {
            return L.divIcon({
                html: `<img src='${pageContext.request.contextPath}/assets/catt.png' style='width:70px; height:70px; border-radius:50%'/>`,
                className: 'custom-div-icon',
                iconSize: [70, 70],
                iconAnchor: [35, 35]
            });
        }
    });

    var circles = {}; // 원을 저장할 객체

    <c:forEach var="board" items="${boardList}" varStatus="status">
        (function() {
            var photoUrls = "${board.photoUrls}";
            var addr = photoUrls.includes(',') ? photoUrls.split(',')[0] : photoUrls;

            var customIcon = L.icon({
                className: 'custom-div-icon',
                iconUrl: addr,
                iconSize: [100, 100],
                iconAnchor: [50, 50],
                popupAnchor: [0, -50]
            });

            var latitude = ${board.latitude};
            var longitude = ${board.longitude};

            if (latitude && longitude) {
                var marker = L.marker([latitude, longitude], {icon: customIcon});

                marker.on('mouseover', function(e) {
                    marker.bindPopup("<b>${board.title}</b><br>게시물 바로가기").openPopup();
                });

                marker.on('mouseout', function(e) {
                    marker.closePopup();
                });

                marker.on('click', function() {
                    window.location.href = "/boardDetailView/${board.postId}";
                });

                markers.addLayer(marker);

                var circle = L.circle([latitude, longitude], {
                    color: 'blue',
                    fillColor: '#a3c1ff',
                    fillOpacity: 0.5,
                    radius: 300
                });

                circles[${status.index}] = circle;
                circle.addTo(map);
            }
        })();
    </c:forEach>

    map.addLayer(markers);

    // 클러스터 이벤트 처리
    markers.on('clusterclick', function (e) {
        for (var key in circles) {
            if (circles.hasOwnProperty(key)) {
                map.removeLayer(circles[key]); // 클러스터가 생기면 원을 삭제
            }
        }
    });

    markers.on('unspiderfied', function (e) {
        for (var key in circles) {
            if (circles.hasOwnProperty(key)) {
                circles[key].addTo(map); // 클러스터가 해제되면 원을 다시 표시
            }
        }
    });

    // 현재 위치 가져오기 (사용하지 않음)
    // map.locate({setView: true, maxZoom: 19});
</script>

<script>
    // 모든 썸네일 이미지에 클릭 이벤트 리스너 추가
    document.addEventListener('DOMContentLoaded', function() {
        const thumbnails = document.querySelectorAll('.thumbnail-photo');
        const mainImage = document.querySelector('.main-signboard-photo');

        thumbnails.forEach(function(thumbnail) {
            thumbnail.addEventListener('click', function() {
                // 이전에 선택된 썸네일에서 선택 스타일 제거
                thumbnails.forEach(function(img) {
                    img.classList.remove('selected');
                });
                // 현재 클릭된 썸네일에 선택 스타일 추가
                this.classList.add('selected');

                // 메인 이미지의 src를 클릭된 썸네일의 src로 변경
                mainImage.src = this.src;
            });
        });
    });
</script>
</body>
</html>
