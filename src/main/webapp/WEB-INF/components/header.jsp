<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<div id="contextPathDiv" data-context-path="${pageContext.request.contextPath}">
  <script src="${pageContext.request.contextPath}/resources/js/rain.js"></script>
</div>
<nav class="navbar navbar-expand-lg" style="background-color: #fec397;" id="mainNav">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/" style="color: #6f5f5e; font-weight: bold;">
      <img src="${pageContext.request.contextPath}/assets/catt.png" alt="고양이 로고" style="height: 60px; margin-right: 10px;" />
      <p style="font-size: 34px; margin: 0;">withCat</p>
    </a>
    <button class="navbar-toggler text-uppercase font-weight-bold" style="background-color: #d28a7c; color: #fff;" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      Menu <i class="fas fa-bars"></i>
    </button>
	<div class="collapse navbar-collapse" id="navbarResponsive">
	  <ul class="navbar-nav ms-auto">
	    <li class="nav-item mx-0 mx-lg-1">
	      <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/" style="color: #6f5f5e; font-weight: bold;">홈</a>
	    </li>
	    <li class="nav-item mx-0 mx-lg-1">
	      <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/catmapView" style="color: #6f5f5e; font-weight: bold;">고양이맵</a>
	    </li>
	    <li class="nav-item mx-0 mx-lg-1">
	      <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/boardView" style="color: #6f5f5e; font-weight: bold;">게시판</a>
	    </li>
	    <c:if test="${sessionScope.login == null}">
	      <li class="nav-item mx-0 mx-lg-1">
	        <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/loginView" style="color: #6f5f5e; font-weight: bold;">로그인</a>
	      </li>
	      <li class="nav-item mx-0 mx-lg-1">
	        <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/registView" style="color: #6f5f5e; font-weight: bold;">회원가입</a>
	      </li>
	    </c:if>
	    <c:if test="${sessionScope.login != null}">
	      <li class="nav-item mx-0 mx-lg-1">
	        <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/profileView" style="color: #6f5f5e; font-weight: bold;">${sessionScope.login.memId} 님</a>
	      </li>
	      <li class="nav-item mx-0 mx-lg-1">
	        <a class="nav-link py-2 px-0 px-lg-2 rounded" href="/logoutDo" style="color: #6f5f5e; font-weight: bold;">로그아웃</a>
	      </li>
	    </c:if>
	    <!-- 스위치 -->
	    <div class="form-check form-switch">
	      <input class="form-check-input" type="checkbox" id="toggleRainEffect" checked>
	    </div>
	  </ul>
	</div>
  </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const header = document.querySelector('.main-header');
    const navButton = document.querySelector('.navbar-toggler');
    const navCollapse = document.querySelector('#navbarResponsive');

    navButton.addEventListener('click', () => {
      if (!navCollapse.classList.contains('show')) {
        navCollapse.style.transition = 'height 0.3s ease-in-out';
        navCollapse.style.height = 'auto';
      } else {
        navCollapse.style.height = '0';
      }
    });

    // 호버 시 스타일 변경
    const navItems = document.querySelectorAll('.navbar-nav .nav-link');
    navItems.forEach(item => {
      item.addEventListener('mouseover', () => {
        item.style.color = '#4a4a4a';
        item.style.fontWeight = 'bolder';
        item.style.transform = 'scale(1.1)';
        item.style.transition = 'all 0.2s ease-in-out';
      });
      item.addEventListener('mouseout', () => {
        item.style.color = '#6f5f5e';
        item.style.fontWeight = 'bold';
        item.style.transform = 'scale(1)';
      });
    });
  });
</script>
<script src="${pageContext.request.contextPath}/resources/js/rain.js"></script>
<style>
#mainNav {
  z-index: 1000; /* 헤더가 고양이 이미지 위에 나타나도록 설정 */
  position: relative; /* z-index가 적용되기 위해 position 설정 필요 */
}

/* 고양이 이미지가 웹 페이지 전체에 적용되도록 스타일링 */
.falling-cat {
  position: fixed; /* 항상 화면 최상단에 고정 */
  top: 0; /* 화면 최상단에서 시작 */
  width: 100px; /* 고양이 크기 */
  animation: fall linear infinite;
  pointer-events: none; /* 클릭 방지 */
  z-index: 10000; /* 헤더 및 컨텐츠보다 앞서서 보이도록 설정 */
}

@keyframes fall {
  0% {
    transform: translate(-50px, -100px) rotate(0deg); /* 왼쪽에서 시작 */
    opacity: 1;
  }
  100% {
    transform: translate(-200px, 100vh) rotate(360deg); /* 오른쪽 아래로 사선 이동 */
    opacity: 0.5;
  }
}

.navbar-nav .form-check {
  display: flex;
  align-items: center; /* 세로 정렬을 중앙에 맞춤 */
  margin-left: 15px; /* 네비게이션 항목들과 적절한 간격 추가 */
}

.navbar-nav .form-check-input {
  transform: scale(1.3); /* 스위치 크기 조정 */
  margin-right: 5px; /* 스위치와 라벨 간 간격 */
}

.navbar-nav .form-check-label {
  font-size: 16px; /* 폰트 크기 네비게이션 메뉴와 일치 */
  color: #6f5f5e; /* 기존 네비게이션 항목과 동일한 색상 */
  font-weight: bold; /* 네비게이션 항목과 동일한 두께 */
}
</style>