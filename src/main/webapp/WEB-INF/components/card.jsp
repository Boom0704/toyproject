<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카드 회전 효과</title>
    <style>
.card:before,
.card:after {
    content: "";
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    top: 0;
    background-repeat: no-repeat;
    background-position: center;
    background-size: 160%;
    z-index: 2;
    animation: holoSparkle 15s ease infinite both;
    opacity: 0.5;
    mix-blend-mode: screen;
    background-image: url("${pageContext.request.contextPath}/assets/effect.gif"); /* 반짝이는 효과 gif */
}

</style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/card.css">
</head>
<body>
    <div class="cards-container">
        <div class="card">
            <a class="card-image" href="#">
                <img src="https://flexible.img.hani.co.kr/flexible/normal/758/492/imgdb/original/2024/0808/20240808502492.jpg" alt="Cat Image 1" />
            </a>
            <div class="card-content">
                <span id="title">더미1</span>
                <span id="location">대전 대덕구 장동</span>
                <span id="like">Like: 5</span>
            </div>
        </div>
    </div>
    
    <!-- 외부 JavaScript 파일 포함 -->
    <script src="${pageContext.request.contextPath}/resources/js/card-rotation.js"></script>
</body>
</html>
