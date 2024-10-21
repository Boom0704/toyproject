<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Cat Profile Community</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profileView.css" />
</head>
<body>

    <!-- 메인 네비게이션 -->
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

    <!-- 프로필 페이지 내용 -->
    <div class="wrapper">
        <div class="profile-container" id="profile-container">
            <!-- 유저 프로필 -->
            <div class="profile-card">
                <div class="profile-card__img">
                    <img id="userImage" src="${sessionScope.login.profileImg}" alt="User Image" style="cursor: pointer;">
                    <input type="file" id="fileInput" style="display: none;" accept="image/*">
                </div>
                <div class="profile-card__name">${sessionScope.login.memId}</div>
                <div class="profile-card__txt">활동 시작일: <fmt:formatDate value="${sessionScope.login.updateDt}" pattern="yyyy-MM-dd"/></div>

                <div class="profile-card__email">Email: ${sessionScope.login.email}</div>

                <div class="profile-card__inf">
                    <div class="profile-card__inf-item">
                        <div class="profile-card__inf-title">1.5K</div>
                        <div class="profile-card__inf-txt">Followers</div>
                    </div>
                    <div class="profile-card__inf-item">
                        <div class="profile-card__inf-title">256</div>
                        <div class="profile-card__inf-txt">Following</div>
                    </div>
                    <div class="profile-card__inf-item">
                        <div class="profile-card__inf-title">45</div>
                        <div class="profile-card__inf-txt">Posts</div>
                    </div>
                </div>

                <!-- 이미지 저장 버튼 -->
                <div class="profile-card__buttons">
                    <button class="profile-card__button" id="saveButton">이미지 저장</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 부트스트랩 및 자바스크립트 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 파일 선택 및 이미지 업로드 로직 -->
    <script>
        const userImage = document.getElementById('userImage');
        const fileInput = document.getElementById('fileInput');
        const saveButton = document.getElementById('saveButton');

        // 프로필 이미지 클릭 시 파일 선택 창 열기
        userImage.addEventListener('click', () => {
            fileInput.click();
        });

        // 파일 선택 시 이미지 미리보기
        fileInput.addEventListener('change', function() {
            const file = fileInput.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    userImage.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });

        // 이미지 저장 버튼 클릭 시 파일 업로드
saveButton.addEventListener('click', function() {
    const formData = new FormData();
    const file = fileInput.files[0];
    const memId = "${sessionScope.login.memId}"; // JSP에서 세션으로 가져온 사용자 ID

    if (file) {
        formData.append("file", file);

        // 서버로 파일 업로드 요청
        fetch("/picture/upload", {
            method: "POST",
            body: formData
        })
        .then(response => response.text())
        .then(fileUrl => {
            alert("파일이 성공적으로 업로드되었습니다.");

            // 업로드된 파일 URL로 프로필 이미지를 업데이트
            userImage.src = fileUrl;

            // 프로필 이미지 변경 API 호출
            fetch("/member/imgchange", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    memId: memId, // 세션에서 가져온 사용자 ID
                    imageUrl: fileUrl
                })
            })
            .then(() => {
                alert("프로필 이미지가 성공적으로 변경되었습니다.");
            })
            .catch(error => {
                alert("프로필 이미지 변경 중 오류 발생");
                console.error(error);
            });
        })
        .catch(error => {
            alert("파일 업로드 중 오류 발생");
            console.error(error);
        });
    } else {
        alert("파일을 선택해주세요.");
    }
});
    </script>

    <!-- 푸터 -->
    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>
    
</body>
</html>
