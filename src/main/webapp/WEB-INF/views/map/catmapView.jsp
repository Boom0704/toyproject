<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Cat Exploration Map</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.Default.css" />
    <style>
        body {
            background-color: #f7f7f7;
            font-family: 'Arial', sans-serif;
            background-image: linear-gradient(135deg, #aec8ca 0%, #fec397 100%);
        }

        #map {
            height: 600px;
            width: 90%;
            border-radius: 30px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            background-color: #6d8c8e;
        }

        #map:hover {
            transform: scale(1.1);
        }

        .title {
            font-size: 2.5em;
            color: #6f5f5e;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.2);
            animation: fadeIn 2s ease-in-out;
        }

        .subtitle {
            font-size: 1.2em;
            color: #d28a7c;
            margin-bottom: 20px;
            animation: fadeIn 3s ease-in-out;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .map-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 40px 20px;
            background-color: #f7f7f7;
            background-image: linear-gradient(135deg, #aec8ca 0%, #fec397 100%);
        }

        .custom-div-icon {
            border-radius: 50%;
            transition: transform 0.3s ease;
        }

        .custom-div-icon:hover {
            transform: scale(1.2);
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

<div class="map-container">
    <h2 class="title">고양이 탐험 지도</h2>
    <p class="subtitle">고양이들이 탐험한 위치를 확인하고, 클릭하여 자세히 알아보세요!</p>

    <div id="map"></div> <!-- 지도 표시 영역 -->
</div>

<jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://unpkg.com/leaflet.markercluster/dist/leaflet.markercluster.js"></script>
<script>
    var map = L.map('map').setView([36.3504119, 127.3845475], 19);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

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

    <c:forEach var="board" items="${boards}" varStatus="status">
        let addr${status.index};
        let photoUrls${status.index} = "${board.photoUrls}";

        if (photoUrls${status.index}.includes(',')) {
            addr${status.index} = photoUrls${status.index}.split(',')[0];
        } else {
            addr${status.index} = photoUrls${status.index};
        }

        let customIcon${status.index} = L.icon({
            className: 'custom-div-icon',
            iconUrl: addr${status.index},
            iconSize: [100, 100],
            iconAnchor: [50, 50],
            popupAnchor: [0, -50]
        });

        let latitude${status.index} = ${board.latitude};
        let longitude${status.index} = ${board.longitude};

        if (latitude${status.index} && longitude${status.index}) {
            let marker${status.index} = L.marker([latitude${status.index}, longitude${status.index}], {icon: customIcon${status.index}});

            marker${status.index}.on('mouseover', function(e) {
                marker${status.index}.bindPopup("<b>${board.title}</b><br> 게시물 바로가기").openPopup();
            });

            marker${status.index}.on('mouseout', function(e) {
                marker${status.index}.closePopup();
            });

            marker${status.index}.on('click', function() {
                window.location.href = "/boardDetailView/${board.postId}";
            });

            markers.addLayer(marker${status.index});

            let circle${status.index} = L.circle([latitude${status.index}, longitude${status.index}], {
                color: 'blue',
                fillColor: '#a3c1ff',
                fillOpacity: 0.5,
                radius: 300
            });

            circles[status.index] = circle${status.index};
            circle${status.index}.addTo(map);
        }
    </c:forEach>

    map.addLayer(markers);

    // 클러스터가 해제되면 서클을 보이고, 클러스터가 생기면 서클을 숨김
    markers.on('clusterclick', function (e) {
        Object.keys(circles).forEach(key => {
            map.removeLayer(circles[key]); // 클러스터가 생기면 원을 삭제
        });
    });

    markers.on('unspiderfied', function (e) {
        Object.keys(circles).forEach(key => {
            circles[key].addTo(map); // 클러스터가 해제되면 원을 다시 표시
        });
    });

    // 현재 위치 가져오기
    map.locate({setView: true, maxZoom: 19});
</script>

</body>
</html>
