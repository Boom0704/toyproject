<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="profile-card">
    <div class="profile-card__img">
        <img src="${imgSrc}" alt="User Profile Image">
    </div>
    <div class="profile-card__name">${profileName}</div>
    <div class="profile-card__txt">마지막 업데이트: ${updateDate}</div>
    <div class="profile-card__email">Email: ${email}</div>
    <div class="profile-card__buttons">
        <button class="profile-card__button">메시지 보내기</button>
    </div>
</div>
