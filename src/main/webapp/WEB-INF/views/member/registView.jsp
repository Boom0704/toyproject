<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>회원가입 및 로그인</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
        body {
            height: 80vh;
            background-color: #f4b29a; /* 일관된 배경 색상 사용 */
            font-family: sans-serif; /* 기본 시스템 폰트 사용 */
        }
        .login-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            padding-top: 2rem;
            padding-bottom: 2rem;
        }
        .login-container {
            display: flex;
            max-width: 600px;
            width: 100%;
            height: auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin: auto;
        }
        .left-section {
            width: 25%;
            background-color: #fec397;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .right-section {
            width: 75%;
            padding: 3rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
		.logo {
		    display: flex;
		    flex-direction: column;
		    align-items: center; /* 이미지와 h4 텍스트를 중앙에 정렬 */
		    justify-content: center; /* 세로 방향으로 중앙 정렬 */
		}
		.logo h4 {
			margin-top: 1rem;
		    height: 24px; /* 고정된 높이 설정 */
		    line-height: 24px; /* 텍스트를 세로 중앙 정렬 */
		}
        .right-section form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        .form-control {
            border-color: #d28a7c;
            height: 45px;
            border-radius: 5px;
        }
        .btn-login, .btn-register {
            width: 100%;
            height: 45px;
            border-radius: 5px;
        }
        .btn-login {
            background-color: #6d8c8e;
            color: #ffffff;
        }
        .btn-register {
            background-color: #aec8ca;
            color: #ffffff;
        }
        .btn-register:hover, .btn-login:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

    <div class="login-wrapper">
        <div class="login-container">
            <div class="left-section">
                <div class="logo">
                    <img src="assets/catt.png" alt="고양이 로고" style="height: 70px;" />
                    <h4>회원가입</h4>
                </div>
            </div>
            <div class="right-section">
                <!-- 회원가입 폼 (form action 설정) -->
                
                <form id="authForm" action="/registerDo" method="post">
                    <input type="text" class="form-control" name="memId" placeholder="아이디" required>
                    <input type="password" class="form-control" name="memPw" placeholder="비밀번호" required>
                    <input type="password" class="form-control" name="confirm_password" placeholder="비밀번호 확인" required>
                    <input type="email" class="form-control" name="email" placeholder="이메일" required>
                    <!-- 회원가입 버튼 (폼 제출) -->
                    <button type="submit" class="btn btn-primary btn-register">회원가입</button>
                </form>
                <!-- 로그인 버튼 (제출 없이 이동) -->
                <button type="button" class="btn btn-secondary btn-login" onclick="window.location.href='/loginView'">로그인</button>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
