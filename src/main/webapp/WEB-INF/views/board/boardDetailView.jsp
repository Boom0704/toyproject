<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Board Detail View</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        .detail-container {
            width: 100%;
            max-width: 1080px;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            margin-bottom: 20px;
        }
        .detail-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .detail-header h2 {
            color: #6f5f5e;
            font-size: 2em;
        }
        .detail-info {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-bottom: 20px;
            color: #6d8c8e;
        }
        .detail-info-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .detail-photo {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 20px;
            margin-bottom: 20px;
        }
        .photo-navigation {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .photo-navigation button {
            background-color: #6d8c8e;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            outline: none;
            transition: background-color 0.3s;
        }
        .photo-navigation button:hover {
            background-color: #5a7b7e;
        }
        .content-section {
            color: #6f5f5e;
            margin-bottom: 20px;
        }
        .comments-container {
            width: 100%;
            max-width: 1080px;
            background-color: #aec8ca;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .comment {
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #d28a7c;
            padding: 10px 0;
            margin-bottom: 10px;
        }
        .comment:last-child {
            border-bottom: none;
        }
        .comment img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .comment-content {
            flex: 1;
        }
        .comment h5 {
            margin: 0;
            color: #6f5f5e;
        }
        .comment p {
            margin: 5px 0;
            color: #6d8c8e;
        }
        .comment-date {
            font-size: 0.8em;
            color: #d28a7c;
        }
        .comment-input-container {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }
        .comment-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
            margin-right: 10px;
        }
        .comment-button {
            padding: 10px 20px;
            background-color: #6d8c8e;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            outline: none;
            transition: background-color 0.3s;
        }
        .comment-button:hover {
            background-color: #5a7b7e;
        }
    </style>
</head>
<body>

    <div class="detail-container">
        <div class="detail-header">
            <h2>${board.title}</h2>
        </div>
        <div class="detail-info">
            <p class="detail-info-item">작성자: ${board.author}</p>
            <p class="detail-info-item">날짜: <fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd"/></p>
        </div>
        <img id="detail-photo" class="detail-photo" src="${board.imageUrl}" alt="게시글 이미지">
        <div class="content-section">
            <p>${board.content}</p>
        </div>
    </div>

    <div class="comments-container">
        <h4>댓글</h4>
        <c:forEach var="comment" items="${comments}">
            <div class="comment">
                <img src="${comment.profileImg}" alt="댓글 작성자 사진">
                <div class="comment-content">
                    <h5>${comment.author}</h5>
                    <p>${comment.content}</p>
                    <p class="comment-date"><fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd"/></p>
                </div>
            </div>
        </c:forEach>
        <div class="comment-input-container">
            <input type="text" class="comment-input" placeholder="댓글을 입력하세요...">
            <button class="comment-button">입력</button>
        </div>
    </div>

    <!-- 부트스트랩 및 자바스크립트 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
