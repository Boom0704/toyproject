<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Board View</title>
    <!-- Updated link to board.css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body>

    <!-- Include the header component -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    <div id="board">
	    <div class="header">
	        <input type="text" placeholder="검색어를 입력하세요...">
	        <div style="display: flex; gap: 5px;">
	            <select id="city" onchange="updateDistricts()">
	                <option value="전체">전체</option>
	                <option value="서울">서울</option>
	                <option value="대전">대전</option>
	                <option value="대구">대구</option>
	                <option value="충남">충남</option>
	            </select>
	            <select id="district" onchange="updateSubDistricts()" style="display: none;">
	                <option value="전체">전체</option>
	            </select>
	            <select id="sub-district" style="display: none;">
	                <option value="전체">전체</option>
	            </select>
	        </div>
	        <div class="sort-options">
	            <select id="sort">
	                <option value="최신순">최신순</option>
	                <option value="인기순">인기순</option>
	            </select>
	            <label><input type="checkbox"> 즐겨찾기</label>
	        </div>
	        <button>검색</button>
	        <div class="d-flex ms-auto">
			    <a href="<%=request.getContextPath()%>/boardWriteView" class="btn btn-primary">글쓰기</a>
			</div>
	    </div>
	
	    <!-- Placeholder for board content (profile cards) -->
	    <div class="profile-grid">
	        <div class="profile-card">
	            <div class="new-badge">NEW</div>
	            <span class="favorite-star">★</span>
	            <img class="profile-photo" src="assets/catt.png" alt="고양이 사진">
	            <div class="profile-info">
	                <h2>고양이 이름</h2>
	                <p>지역: 대전 대덕구</p>
	                <p>좋아요 수: 100</p>
	                <span class="favorite-heart">♥</span>
	            </div>
	        </div>
	        <!-- Add more profile cards as needed -->
	    </div>
	
	    <div class="add-profile">더보기</div>
	
	    <!-- Include the footer component -->
    </div>
	<jsp:include page="/WEB-INF/components/footer.jsp" />
	
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // JavaScript for updating districts and sub-districts (placeholders)
        function updateDistricts() {
            const city = document.getElementById('city').value;
            const district = document.getElementById('district');
            district.style.display = city !== '전체' ? 'block' : 'none';
            // Placeholder logic for populating districts
        }

        function updateSubDistricts() {
            const district = document.getElementById('district').value;
            const subDistrict = document.getElementById('sub-district');
            subDistrict.style.display = district !== '전체' ? 'block' : 'none';
            // Placeholder logic for populating sub-districts
        }
    </script>
</body>
</html>
