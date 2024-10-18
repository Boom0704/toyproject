<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .cards-container {
        display: flex;
        flex-wrap: wrap;
        gap: 1.5rem;
        justify-content: center;
        padding: 0.3rem;
    }
    .card {
        width: 18rem;
        height: 28rem;
        padding: 0;
        box-shadow: 0 0 2rem -1rem rgba(0,0,0,0.3);
        border-radius: 8px;
        overflow: hidden;
        background-color: #040712;
        position: relative;
        transition: transform 0.5s ease, box-shadow 0.2s ease;
        will-change: transform, filter;
    }
    .card:hover {
        box-shadow: 
            -20px -20px 30px -25px #54a29e, 
            20px 20px 30px -25px #a79d66, 
            0 0 13px 4px rgba(255,255,255,0.3),
            0 55px 35px -20px rgba(0, 0, 0, 0.5);
        transform: rotateX(10deg) rotateY(10deg);
    }
    .card:before,
    .card:after {
        content: "";
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0;
        top: 0;
        background-repeat: no-repeat;
        opacity: .5;
        mix-blend-mode: color-dodge;
        transition: all .33s ease;
    }
    .card-image {
        width: 100%;
        height: 60%;
        background-size: cover;
        background-position: center;
        overflow: hidden;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .card-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    .card-content {
    height: 40%;
    color: #ffffff;
    text-align: center; /* 텍스트를 가운데 정렬 */
    display: flex;
    flex-direction: column;
    justify-content: center; /* 세로 정렬 */
    background-color: #333;
    font-size: 1rem;
    padding: 0.3rem;
    border-radius: 8px;
    gap: 0.1rem; /* 간격을 줄이기 */
	}
	
	#title {
	    font-size: 1.5rem;
	    margin: 0; /* 간격 제거 */
	}
	
	#location {
	    font-size: 1.2rem;
	    margin: 0.05rem 0; /* 간격 줄이기 */
	    color: #cccccc;
	}
	
	#like {
	    font-size: 1rem;
	    margin: 0.05rem 0; /* 간격 줄이기 */
	    color: #aaaaaa;
	}
</style>

<div class="cards-container">
    <div class="card" onmousemove="handleMouseMove(event, this)" onmouseout="resetCard(event, this)">
        <a class="card-image" href="#">
            <img src="https://flexible.img.hani.co.kr/flexible/normal/758/492/imgdb/original/2024/0808/20240808502492.jpg" alt="Cat Image 1" />
        </a>
        <div class="card-content">
            <span id="title">더미1</span>
            <span id="location">대전 대덕구 장동</span>
            <span id="like">Like: 5</span>
        </div>
    </div>
</div>

<script>
    function handleMouseMove(event, card) {
        const cardRect = card.getBoundingClientRect();
        const centerX = cardRect.left + cardRect.width / 2;
        const centerY = cardRect.top + cardRect.height / 2;
        const deltaX = event.clientX - centerX;
        const deltaY = event.clientY - centerY;
        const rotateX = (deltaY / cardRect.height) * 15;
        const rotateY = -(deltaX / cardRect.width) * 15;
        card.style.transform = `rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
    }

    function resetCard(event, card) {
        card.style.transform = "rotateX(0deg) rotateY(0deg)";
    }
</script>
