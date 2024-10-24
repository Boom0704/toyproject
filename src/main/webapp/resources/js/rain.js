let intervalId = null; // setInterval 관리 변수

function createFallingCat() {
  const contextPath = document.querySelector('#contextPathDiv').getAttribute('data-context-path');
  const catImg = document.createElement('img');
  catImg.src = contextPath + '/resources/assets/rain.png';
  catImg.classList.add('falling-cat');
  catImg.style.left = Math.random() * window.innerWidth + 'px';
  catImg.style.animationDuration = Math.random() * 3 + 2 + 's';
  document.body.appendChild(catImg);
  setTimeout(() => {
    catImg.remove();
  }, 5000);
}

document.addEventListener('DOMContentLoaded', function () {
  // 쿠키 읽기 함수
  function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
  }

  // 쿠키 저장 함수
  function setCookie(name, value, days) {
    let expires = "";
    if (days) {
      const date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
  }

  // 고양이 비 효과를 끄고 켜는 함수
  function toggleRainEffect(enabled) {
    if (enabled) {
      if (!intervalId) { // 이미 실행 중이 아닌 경우에만 setInterval 실행
        intervalId = setInterval(createFallingCat, 500);
      }
    } else {
      if (intervalId) { // 실행 중인 interval이 있을 때만 clearInterval
        clearInterval(intervalId);
        intervalId = null;
      }
      // 비활성화 시 고양이 이미지 제거
      const cats = document.querySelectorAll('.falling-cat');
      cats.forEach(cat => cat.remove());
    }
  }

  // 페이지 로드 시 쿠키에서 상태를 불러옴
  const rainEnabled = getCookie('rainEffect') === 'true'; // 쿠키 값이 'true'이면 켜짐
  const toggleSwitch = document.getElementById('toggleRainEffect');

  // 스위치 상태 설정 (쿠키 값에 따라 설정)
  toggleSwitch.checked = rainEnabled; // 쿠키 값이 'true'일 때만 스위치가 켜짐
  toggleRainEffect(rainEnabled); // 쿠키 값에 따라 고양이 비 효과 설정

  // 스위치 변경 시 쿠키에 상태 저장 및 고양이 비 효과 끄고 켜기
  toggleSwitch.addEventListener('change', function (e) {
    const enabled = e.target.checked;
    setCookie('rainEffect', enabled, 7); // 쿠키 7일 유지
    toggleRainEffect(enabled);
  });
});
