<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
        body {
            height: 80vh;
            background-color: #fec397;
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
            align-items: center;
            justify-content: center;
        }
        .logo h4 {
            margin-top: 1rem;
            height: 24px;
            line-height: 24px;
        }
        .right-section form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        .form-control {
            border-color: #d28a7c;
            height: 45px;
        }
        .btn-login, .btn-register {
            width: 100%;
            height: 45px;
        }
        .btn-login {
            background-color: #6d8c8e;
            color: #ffffff;
        }
        .btn-register {
            background-color: #aec8ca;
            color: #ffffff;
        }
        .remember-me {
            display: flex;
            align-items: center;
            gap: 0.5rem;
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
                    <h4>로그인</h4>
                </div>
            </div>
            <div class="right-section">
                <!-- 로그인 폼 -->
                <form id="authForm" action="/loginDo" method="post">
                    <input type="text" class="form-control" name="memId" placeholder="아이디" value="${cookie.rememberId}" required>
                    <input type="password" class="form-control" name="memPw" placeholder="비밀번호" required>

                    <!-- 아이디 기억하기 체크박스 -->
                    <div class="remember-me">
                        <input type="checkbox" id="rememberMe" name="remember" ${cookie.rememberId != null ? 'checked' : ''}>
                        <label for="rememberMe">아이디 기억하기</label>
                    </div>

                    <!-- 로그인 버튼 (폼 제출) -->
                    <button type="submit" class="btn btn-primary btn-login">로그인</button>
                </form>
                
                <!-- 회원가입 버튼 (제출 없이 이동) -->
                <button type="button" class="btn btn-secondary btn-register" onclick="window.location.href='/registView'">회원가입</button>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
