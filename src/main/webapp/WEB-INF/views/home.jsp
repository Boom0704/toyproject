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
        
        .main-banner {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 0;
            background-color: #f9f9f9;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .main-banner img {
            max-width: 400px;
            transition: transform 0.3s ease-in-out;
        }

        .main-banner:hover img {
            transform: scale(1.1) rotate(15deg);
        }

        .main-banner-text {
            margin-left: 0px;
            font-size: 6rem;
            font-weight: bold;
            color: #333;
            position: relative;
        }

        .main-banner-text::after {
            content: '인플루언서 고양이';
            position: absolute;
            right: 10;
            bottom: -20px;
            font-size: 2rem;
            font-weight: normal;
            color: #ff6699;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
        }

        .main-banner:hover .main-banner-text::after {
            opacity: 1;
        }

        /* Hover 시 귀여운 효과 */
        .main-banner:hover .main-banner-text {
            color: #ff6699;
        }

        /* 반응형 처리 */
        @media screen and (max-width: 600px) {
            .main-banner img {
                max-width: 250px;
            }
            .main-banner-text {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"></jsp:include>

    <div class="main-banner">
        <img src="<c:url value='/resources/assets/walkcat.gif'/>" alt="고양이 이미지">
        <div class="main-banner-text">
            Influencer Cat
        </div>
    </div>

	<div style="width: 100%; padding-left: 10%; padding-right: 10%;">
	    <ul class="card-list">
	        <c:forEach var="influencer" items="${influencerList}">
			    <li class="card" onclick="location.href='<%=request.getContextPath()%>/influencers/${influencer.id}'" 
     style="cursor:pointer;">
			        <jsp:include page="/WEB-INF/components/card.jsp">
			            <jsp:param name="id" value="${influencer.id}"/>
			            <jsp:param name="name" value="${influencer.name}"/>
			            <jsp:param name="mainPhoto" value="${influencer.mainPhoto}"/>
			            <jsp:param name="address" value="${influencer.address}"/>
			            <jsp:param name="updatedAt" value="${influencer.updatedAt}"/>
			        </jsp:include>
			    </li>
			</c:forEach>
	    </ul>
	</div>
    <jsp:include page="/WEB-INF/components/footer.jsp"></jsp:include>
</body>
</html>
