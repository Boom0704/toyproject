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
                <img src="${param.mainPhoto}" alt="${param.name}" />
            </a>
            <div class="card-content">
                <span id="title">${param.name}</span>
                <span id="location">${param.address}</span>

                <!-- updatedAt 값을 포맷팅 -->
                <c:choose>
                    <c:when test="${not empty param.updatedAt}">
                        <%
                            String updatedAt = (String) request.getParameter("updatedAt");
                            // SimpleDateFormat을 사용하여 문자열 날짜 포맷을 변경
                            java.text.SimpleDateFormat originalFormat = new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", java.util.Locale.ENGLISH);
                            java.text.SimpleDateFormat targetFormat = new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm");
                            java.util.Date date = originalFormat.parse(updatedAt);
                            String formattedDate = targetFormat.format(date);
                        %>
                        <span id="like"><%= formattedDate %></span>
                    </c:when>
                    <c:otherwise>
                        <span id="like">업데이트 날짜 없음</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <!-- 외부 JavaScript 파일 포함 -->
    <script src="${pageContext.request.contextPath}/resources/js/card-rotation.js"></script>
</body>
</html>
