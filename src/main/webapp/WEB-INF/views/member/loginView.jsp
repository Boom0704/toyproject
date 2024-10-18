<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        body {
            height: 100vh;
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
            height: 400px;
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
            padding: 2rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .logo {
            margin-bottom: 1rem;
        }
        .form-control {
            margin-bottom: 1rem;
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
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

    <div class="login-wrapper">
        <div class="login-container">
            <div class="left-section">
                <div class="logo">
                    <img src="assets/catt.png" alt="고양이 로고" style="height: 60px;" />
                </div>
            </div>
            <div class="right-section">
                <form action="/login" method="post">
                    <input type="text" class="form-control" name="username" placeholder="아이디" required>
                    <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
                    <button type="submit" class="btn btn-primary btn-login">로그인</button>
                </form>
                <button onclick="location.href='/register'" class="btn btn-secondary btn-register">회원가입</button>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
