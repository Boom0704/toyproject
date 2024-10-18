<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="./css/header.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />

<nav class="navbar navbar-expand-lg" style="background-color: #fec397;" id="mainNav">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/" style="color: #6f5f5e; font-weight: bold;">
      <img src="assets/catt.png" alt="고양이 로고" style="height: 60px; margin-right: 10px;" />
      <p style="font-size: 34px; margin: 0;">withCat</p>
    </a>
    <button class="navbar-toggler text-uppercase font-weight-bold" style="background-color: #d28a7c; color: #fff;" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      Menu <i class="fas fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="/" style="color: #6f5f5e; font-weight: bold;">홈</a></li>
        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="/cat-map" style="color: #6f5f5e; font-weight: bold;">고양이맵</a></li>
        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="/board" style="color: #6f5f5e; font-weight: bold;">게시판</a></li>
        <c:if test="${sessionScope.login == null}">
          <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="<c:url value='loginView' />" style="color: #6f5f5e; font-weight: bold;">로그인</a></li>
          <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="/registView" style="color: #6f5f5e; font-weight: bold;">회원가입</a></li>
        </c:if>
        <c:if test="${sessionScope.login != null}">
          <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="#" style="color: #6f5f5e; font-weight: bold;">${sessionScope.login.memId} 님</a></li>
          <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-2 px-0 px-lg-2 rounded" href="/logoutDo" style="color: #6f5f5e; font-weight: bold;">로그아웃</a></li>
        </c:if>
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
