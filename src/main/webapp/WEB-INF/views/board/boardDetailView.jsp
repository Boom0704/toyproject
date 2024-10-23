<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<title>Board Detail View</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/boardDetailView.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>
	<!-- 헤더 추가 -->
	<div class="detail">
		<div class="detail-container">
			<div class="detail-header">
				<h2>${board.title}
					<c:if
						test="${not empty sessionScope.login and sessionScope.login.memId == board.memId}">
						<button class="delete-btn" onclick="deleteBoard(${board.postId})">삭제</button>
					</c:if>
				</h2>
			</div>
			<div class="detail-info">
				<p class="detail-info-item">작성자: ${board.memId}</p>
				<div class="detail-info-item">
					<c:set var="userHasLiked"
						value="${fn:contains(likeList, sessionScope.login.memId)}" />
					<c:if test="${empty sessionScope.login}">
						<span>좋아요 : </span>
					</c:if>
					<c:if test="${not empty sessionScope.login}">
						<i class="heart ${userHasLiked ? 'checked' : 'unchecked'}"
							onclick="toggleHeart(this, ${board.postId}, '${sessionScope.login.memId}')">
							&#9829; </i>
					</c:if>

					<span id="like-count"> ${likesCount}</span>
				</div>
				<div class="detail-info-item">
					<c:set var="userHasFavorited"
						value="${fn:contains(favoriteList, sessionScope.login.memId)}" />

					<c:if test="${empty sessionScope.login}">
						<span>즐겨찾기 : </span>
					</c:if>
					<c:if test="${not empty sessionScope.login}">
						<i class="star ${userHasFavorited ? 'checked' : 'unchecked'}"
							onclick="toggleFavorite(this, ${board.postId}, '${sessionScope.login.memId}')">
							&#9733; </i>
					</c:if>
					<span id="favorite-count"> ${favoritesCount}</span>
				</div>
			</div>
			<div class="detail-info">
				<p class="detail-info-item">조회수: ${board.views}</p>
				<p class="detail-info-item">
					날짜:
					<fmt:formatDate value="${board.createDt}" pattern="yyyy-MM-dd" />
				</p>
				<span class="detail-info-item" id="location-info">위치: 불러오는
					중...</span>
			</div>

			<!-- 지도 추가 -->
			<div id="map"></div>

			<!-- 이미지 슬라이드 -->
			<div class="photo-slider">
				<c:choose>
					<c:when test="${fn:contains(board.photoUrls, ',')}">
						<img id="detail-photo" class="detail-photo"
							src="${fn:substringBefore(board.photoUrls, ',')}" alt="게시글 이미지">
						<button class="nav-btn left" onclick="prevPhoto()">&#60;</button>
						<button class="nav-btn right" onclick="nextPhoto()">&#62;</button>
					</c:when>
					<c:otherwise>
						<img id="detail-photo" class="detail-photo"
							src="${board.photoUrls}" alt="게시글 이미지">
					</c:otherwise>
				</c:choose>
			</div>

			<div class="content-section">
				<p>${board.content}</p>
			</div>
		</div>

		<div class="comments-container">
			<h4>댓글</h4>
			<c:forEach var="comment" items="${comments}">
				<div class="comment">
					<img src="${comment.photoUrl}" alt="댓글 작성자 사진">
					<div class="comment-content">
						<h5>${comment.author}</h5>
						<p>${comment.content}</p>
						<p class="comment-date">
							<fmt:formatDate value="${comment.createDt}"
								pattern="yyyy-MM-dd a hh:mm" />
						</p>
					</div>
					<c:if test="${not empty sessionScope.login and sessionScope.login.memId == comment.author}">
					    <div class="comment-actions">
					        <button class="delete-comment-button" onclick="handleDeleteComment(${comment.id}, this)">삭제</button>
					    </div>
					</c:if>
				</div>
			</c:forEach>
			<c:if test="${not empty sessionScope.login}">
				<div class="comment-input-container">
					<input type="text" id="comment-input" class="comment-input"
						placeholder="댓글을 입력하세요...">
					<button class="comment-button" onclick="writeCommentDo()">입력</button>
				</div>
			</c:if>
		</div>
	</div>
	<jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>
	<!-- 푸터 추가 -->

	<!-- 부트스트랩 및 자바스크립트 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
	<script>
        // 이미지 배열을 생성
        const photos = '${board.photoUrls}'.split(',');
        let currentIndex = 0;

        // 슬라이드 이미지 업데이트 함수
        function updatePhoto() {
            document.getElementById('detail-photo').src = photos[currentIndex];
        }

        // 이전 사진
        function prevPhoto() {
            currentIndex = (currentIndex > 0) ? currentIndex - 1 : photos.length - 1;
            updatePhoto();
        }

        // 다음 사진
        function nextPhoto() {
            currentIndex = (currentIndex < photos.length - 1) ? currentIndex + 1 : 0;
            updatePhoto();
        }

        // 지도 객체 생성 및 위치 설정
        var latitude = ${board.latitude};
        var longitude = ${board.longitude};

        // 비어있지 않으면 처리
        if (latitude && longitude) {
            var map = L.map('map').setView([latitude, longitude], 19); // 최대 확대 설정

            // 타일 레이어 추가 (OpenStreetMap)
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 19,
                attribution: '© OpenStreetMap contributors'
            }).addTo(map);

            // 마커 추가
            L.marker([latitude, longitude]).addTo(map)
                .bindPopup("<b>게시글 위치</b><br>위도: " + latitude + "<br>경도: " + longitude).openPopup();
            
            // 1km 반경 원 추가
            L.circle([latitude, longitude], {
                color: 'blue', // 원의 외곽선 색
                fillColor: '#a3c1ff', // 원 내부 색
                fillOpacity: 0.5, // 원의 투명도
                radius: 1000 // 반경 1km = 1000 meters
            }).addTo(map);

            // 행정구역 정보를 가져오는 함수
            const url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=" + latitude + "&lon=" + longitude + "&zoom=18&addressdetails=1";
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data && data.address) {
                        const address = data.address;
                        const fullAddress = ["위치: ", address.city, address.borough, address.suburb || address.quarter]
                            .filter(Boolean) // 빈 값 제거
                            .join(" ");
                        document.getElementById('location-info').textContent = fullAddress;

                        
                    } else {
                        console.error("행정구역 정보를 찾을 수 없습니다.");
                        document.getElementById('location-info').innerText = '위치 정보를 찾을 수 없습니다.';
                    }
                })
                .catch(error => {
                    console.error("오류 발생: ", error);
                    document.getElementById('location-info').innerText = '위치 정보를 가져오는데 실패했습니다.';
                });
        } else {
            document.getElementById('location-info').innerText = '위도와 경도 정보가 없습니다.';
        }

        // 게시물 삭제 함수
        function deleteBoard(postId) {
            if (confirm("정말 이 게시물을 삭제하시겠습니까?")) {
                fetch(`/deleteBoard/${board.postId}`, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        alert('게시물이 삭제되었습니다.');
                        window.location.href = '/boardView'; // 삭제 후 게시판 목록으로 이동
                    } else {
                        alert('게시물 삭제에 실패했습니다.');
                    }
                })
                .catch(error => {
                    alert('오류가 발생했습니다: ' + error.message);
                });
            }
        }
        
        function writeCommentDo() {
            // 게시물 ID와 사용자 정보 수집
            const postId = ${board.postId};  // JSP 내에 삽입된 postId
            const memId = '${sessionScope.login.memId}';  // 문자열로 감싸서 JavaScript에서 사용할 수 있도록 함
            const profileImg = '${sessionScope.login.profileImg}';  // 문자열로 감싸서 사용
            const content = document.getElementById("comment-input").value;  // 인풋 필드의 내용

            // 댓글 입력 필드가 비어있는지 확인
            if (!content) {
                alert('댓글 내용을 입력하세요.');
                return;
            }

        
            fetch('/comment/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    postId: postId,  // postId 값 확인
                    author: memId,  // memId 값 확인
                    content: content,  // 입력된 댓글 내용
                    photoUrl: profileImg  // 프로필 이미지 URL
                })
            })
            .then(response => response.text())  // 응답을 텍스트로 받음
            .then(data => {
                alert(data);  // 서버에서 반환된 메시지 출력

                // 입력 필드 초기화
                document.getElementById("comment-input").value = '';
            })
            .catch((error) => {
                console.error('Error:', error);

                // 오류 발생 시 화면에 추가한 댓글을 제거
                commentSection.removeChild(newComment);
                alert('댓글 작성 중 오류가 발생했습니다.');
            });
        }
        // 댓글 삭제 요청 함수
		function handleDeleteComment(commentId, deleteButton) {
		    fetch("/comment/" + commentId, {
		        method: 'DELETE',
		    })
		    .then(response => {
		        if (response.ok) {
		            // 삭제가 성공하면 부모의 부모인 comment를 삭제
		            const commentElement = deleteButton.parentElement.parentElement; // 부모의 부모 요소 찾기
		            commentElement.remove(); // 해당 요소 삭제
		        } else {
		            console.error('댓글 삭제 실패');
		        }
		    })
		    .catch(error => console.error('에러 발생:', error));
		}


		function toggleHeart(element, postId, memId) {
		    // 좋아요가 체크되어 있는지 확인
		    const isChecked = element.classList.contains('checked');
		    
		    // URL 및 HTTP 메서드를 좋아요 상태에 따라 설정
		    const url = isChecked ? `/likes/remove` : `/likes/add`;
		    const method = isChecked ? 'DELETE' : 'POST';

		    // 요청에 사용할 body 데이터 (각 함수 내에서 생성)
		    const bodyData = JSON.stringify({
		        postId: postId,
		        memId: memId  // memId 값을 올바르게 전달
		    });

		    // 서버로 좋아요 추가/삭제 요청 보내기
		    fetch(url, {
		        method: method,
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: bodyData
		    })
		    .then(response => {
		        if (response.ok) {
		            // 상태 토글
		            if (isChecked) {
		                element.classList.remove('checked');
		                element.classList.add('unchecked');
		                updateLikeCount(postId, -1); // 좋아요 수 감소
		            } else {
		                element.classList.remove('unchecked');
		                element.classList.add('checked');
		                updateLikeCount(postId, 1); // 좋아요 수 증가
		            }
		        } else {
		            console.error('좋아요 상태 변경 실패');
		        }
		    })
		    .catch(error => console.error('에러 발생:', error));
		}

		// 좋아요 수 업데이트 함수
		function updateLikeCount(postId, change) {
		    const likeCountElement = document.querySelector(`#like-count`);
		
		    if (likeCountElement) {
		        const currentCount = parseInt(likeCountElement.textContent);
		        likeCountElement.textContent = currentCount + change;
		    } else {
		        console.error(`like-count 요소를 찾을 수 없습니다.`);
		    }
		}
		function toggleFavorite(element, postId, memId) {
		    // 페이버릿이 체크되어 있는지 확인
		    const isChecked = element.classList.contains('checked');
		    
		    // URL 및 HTTP 메서드를 페이버릿 상태에 따라 설정
		    const url = isChecked ? `/favorites/remove` : `/favorites/add`;
		    const method = isChecked ? 'DELETE' : 'POST';

		    // 요청에 사용할 body 데이터 (각 함수 내에서 생성)
		    const bodyData = JSON.stringify({
		        postId: postId,
		        memId: memId  // memId 값을 올바르게 전달
		    });

		    // 서버로 페이버릿 추가/삭제 요청 보내기
		    fetch(url, {
		        method: method,
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: bodyData
		    })
		    .then(response => {
		        if (response.ok) {
		            // 상태 토글
		            if (isChecked) {
		                element.classList.remove('checked');
		                element.classList.add('unchecked');
		                updateFavoriteCount(-1); // 페이버릿 수 감소
		            } else {
		                element.classList.remove('unchecked');
		                element.classList.add('checked');
		                updateFavoriteCount(1); // 페이버릿 수 증가
		            }
		        } else {
		            console.error('페이버릿 상태 변경 실패');
		        }
		    })
		    .catch(error => console.error('에러 발생:', error));
		}

		// 페이버릿 수 업데이트 함수
		function updateFavoriteCount(change) {
		    const favoriteCountElement = document.querySelector(`#favorite-count`);

		    if (favoriteCountElement) {
		        const currentCount = parseInt(favoriteCountElement.textContent);
		        favoriteCountElement.textContent = currentCount + change;
		    } else {
		        console.error(`favorite-count 요소를 찾을 수 없습니다.`);
		    }
		}

    </script>

</body>
</html>
