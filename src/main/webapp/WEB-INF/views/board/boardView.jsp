<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Board View</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
    <meta charset="UTF-8">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body>

    <jsp:include page="/WEB-INF/components/header.jsp" />

    <div id="board">
        <div class="header">
            <input type="text" placeholder="검색어를 입력하세요...">
            <!-- 주소 선택 컴포넌트 포함 -->
            <jsp:include page="/WEB-INF/components/AddressSelect.jsp" />
            
            <div class="sort-options">
                <select id="sort">
                    <option value="최신순">최신순</option>
                    <option value="인기순">인기순</option>
                </select>
                <label><input type="checkbox"> 즐겨찾기</label>
            </div>
            <button>검색</button>

            <!-- 로그인된 유저일 때만 글쓰기 버튼 표시 -->
            <c:if test="${not empty sessionScope.login}">
                <div class="d-flex ms-auto">
                    <a href="<%=request.getContextPath()%>/boardWriteView" class="btn btn-primary">글쓰기</a>
                </div>
            </c:if>
        </div>

        <!-- 게시물 목록 -->
		<div class="profile-grid">
		    <c:forEach var="board" items="${boards}">
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
			                <p>지역: 어캐함</p>
			            </div>
			        </div>
			    </c:forEach>
			</div>

        <div class="add-profile">더보기</div>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
