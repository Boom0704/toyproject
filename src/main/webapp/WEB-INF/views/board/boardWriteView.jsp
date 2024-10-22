<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Board Write View</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        #write {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            margin-top: 10vh;
            margin-bottom: 10vh;
        }
        .write-container {
            width: 100%;
            max-width: 1080px;
            padding: 20px;
            border-radius: 20px;
            border: 2px solid #6d8c8e;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            margin-bottom: 20px;
        }
        .write-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .write-header h2 {
            color: #6f5f5e;
            font-size: 2em;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        /* 둥글고 귀여운 지도를 위한 스타일 */
        #map {
            width: 300px;
            height: 300px;
            border-radius: 50%;
            margin: 20px auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .photo-preview {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .photo-preview img {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin: 10px;
            position: relative;
        }
        .remove-photo-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 16px;
        }
        .add-photo-btn {
            background-color: #6d8c8e;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        .add-photo-btn.disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .submit-btn {
            background-color: #5a7b7e;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            display: block;
            width: 100%;
        }
        .submit-btn:hover {
            background-color: #6d8c8e;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />
    <div id="write">
        <div class="write-container">
            <div id="map"></div> <!-- 둥글고 귀엽게 지도를 표시 -->
            <div class="write-header">
                <h2>고양이 사진</h2>
            </div>
            <form id="boardWriteForm">
                <div class="form-group">
                    <input type="text" id="title" placeholder="제목을 입력하세요" required>
                </div>
                <div class="form-group">
                    <textarea id="content" placeholder="내용을 입력하세요" rows="5" required></textarea>
                </div>
                <div class="form-group">
                    <button type="button" class="add-photo-btn" id="addPhotoBtn">사진 추가 (최대 10장)</button>
                    <input type="file" id="photoInput" style="display: none;" accept="image/*">
                    <div class="photo-preview" id="photoPreview"></div>
                </div>
                <button type="button" class="submit-btn" id="submitBtn">작성 완료</button>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/components/footer.jsp" />

    <!-- Leaflet.js 및 Bootstrap JS -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let gpsCoordinates = { latitude: null, longitude: null };
        let map;
        let marker;

        // 지도 초기화 및 GPS 정보 받기
        function initMap() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    gpsCoordinates.latitude = position.coords.latitude;
                    gpsCoordinates.longitude = position.coords.longitude;

                    // Leaflet 지도 초기화
                    map = L.map('map').setView([gpsCoordinates.latitude, gpsCoordinates.longitude], 13);

                    // OpenStreetMap 타일 레이어 추가
                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                        attribution: '© OpenStreetMap contributors'
                    }).addTo(map);

                    // 현재 위치에 마커 추가
                    marker = L.marker([gpsCoordinates.latitude, gpsCoordinates.longitude]).addTo(map)
                        .bindPopup('현재 위치')
                        .openPopup();

                }, function (error) {
                    // GPS 권한 거부 시 처리
                    if (error.code === error.PERMISSION_DENIED) {
                        alert("GPS 사용에 동의해야 게시글 작성이 가능합니다.");
                        window.location.href = "/";
                    }
                });
            } else {
                alert("이 브라우저는 GPS를 지원하지 않습니다.");
                window.location.href = "/";
            }
        }

        // 지도 및 GPS 초기화 호출
        initMap();

        const photoInput = document.getElementById('photoInput');
        const addPhotoBtn = document.getElementById('addPhotoBtn');
        const photoPreview = document.getElementById('photoPreview');
        const submitBtn = document.getElementById('submitBtn');
        let photoFiles = [];
        const maxPhotos = 10;

        // 사진 추가 버튼 클릭 시 파일 선택 창 열기
        addPhotoBtn.addEventListener('click', () => {
            if (photoFiles.length < maxPhotos) {
                photoInput.click();
            }
        });

        // 파일 선택 시 미리보기 및 사진 배열에 추가
        photoInput.addEventListener('change', function() {
            const file = this.files[0];
            if (file && photoFiles.length < maxPhotos) {
                photoFiles.push(file);
                const reader = new FileReader();
                reader.onload = function(e) {
                    const imgWrapper = document.createElement('div');
                    imgWrapper.style.position = 'relative';
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    const removeBtn = document.createElement('button');
                    removeBtn.textContent = '×';
                    removeBtn.classList.add('remove-photo-btn');
                    removeBtn.onclick = () => removePhoto(imgWrapper, file);
                    imgWrapper.appendChild(img);
                    imgWrapper.appendChild(removeBtn);
                    photoPreview.appendChild(imgWrapper);
                };
                reader.readAsDataURL(file);
            }
            updateAddPhotoBtn();
        });

        // 사진 삭제
        function removePhoto(wrapper, file) {
            wrapper.remove();
            photoFiles = photoFiles.filter(f => f !== file);
            updateAddPhotoBtn();
        }

        // 사진이 10장일 경우 더 이상 추가 불가능
        function updateAddPhotoBtn() {
            if (photoFiles.length >= maxPhotos) {
                addPhotoBtn.classList.add('disabled');
                addPhotoBtn.disabled = true;
            } else {
                addPhotoBtn.classList.remove('disabled');
                addPhotoBtn.disabled = false;
            }
        }
        submitBtn.addEventListener('click', () => {
            if (photoFiles.length === 0) {
                alert("최소 1장의 사진을 업로드해야 합니다.");
                return;
            }

            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;

            if (!title || !content) {
                alert("제목과 내용을 입력하세요.");
                return;
            }

            const uploadedUrls = [];

            // 사진들을 하나씩 업로드
            const uploadPromises = photoFiles.map(file => uploadPhoto(file));

            Promise.all(uploadPromises).then(urls => {
                uploadedUrls.push(...urls);

                // 로그인된 유저의 memId 가져오기 (세션 이용)
                const memId = "${sessionScope.login.memId}"
                
                // 모든 사진이 업로드된 후 게시글 저장 요청
                fetch("/boardWriteDo", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        title: title,
                        content: content,
                        imageUrls: uploadedUrls, // 사진 URLs 배열
                        latitude: gpsCoordinates.latitude,
                        longitude: gpsCoordinates.longitude,
                        memId: memId
                    })
                })
                .then(response => response.text())
                .then(result => {
                    alert("게시글이 성공적으로 작성되었습니다.");
                    window.location.href = "/boardView";
                })
                .catch(error => {
                    console.error("게시글 작성 중 오류 발생:", error);
                    alert("게시글 작성 중 오류가 발생했습니다.");
                });
            });
        });

        // 사진 업로드 함수
        function uploadPhoto(file) {
            const formData = new FormData();
            formData.append("file", file);

            return fetch("/picture/upload", {
                method: "POST",
                body: formData
            })
            .then(response => response.text());
        }
    </script>
</body>
</html>
