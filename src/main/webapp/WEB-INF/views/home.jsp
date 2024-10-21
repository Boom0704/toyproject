<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
        .card-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
            padding: 20px;
            list-style: none;
        }

        .card {
            width: calc(50% - 20px);
            max-width: 300px;
            box-sizing: border-box;
        }

        @media screen and (max-width: 600px) {
            .card {
                width: calc(50% - 20px);
            }
        }

        @media screen and (max-width: 400px) {
            .card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

	<div style="width: 100%; padding-left: 10%; padding-right: 10%;">
	    <ul class="card-list">
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	        <li class="card">
	            <jsp:include page="/WEB-INF/components/card.jsp"></jsp:include>
	        </li>
	    </ul>
	</div>
    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>
</body>
</html>
