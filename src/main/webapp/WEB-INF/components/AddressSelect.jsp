<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 주소 선택 컴포넌트 -->
<div class="address-select" style="display: flex; gap: 10px;">
    <select id="sido" onchange="updateSigungu()">
        <option value="전체">전체</option>
        <!-- 시도명 옵션이 여기 동적으로 채워집니다 -->
    </select>
    
    <select id="sigungu" onchange="updateDong()" style="display: none;">
        <option value="전체">전체</option>
        <!-- 시군구명 옵션이 여기 동적으로 채워집니다 -->
    </select>
    
    <select id="dong" style="display: none;">
        <option value="전체">전체</option>
        <!-- 법정동명 옵션이 여기 동적으로 채워집니다 -->
    </select>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.0/papaparse.min.js"></script>

<script>
// 주소 데이터 로드 및 선택 목록 동적 구성
document.addEventListener('DOMContentLoaded', function() {
    fetch('<%=request.getContextPath()%>/resources/address.csv')
        .then(response => response.text())
        .then(csvText => {
            const csvData = Papa.parse(csvText, { header: true }).data;
            processCSVData(csvData);
        })
        .catch(error => {
            console.error("CSV 파일을 불러오는 중 오류 발생:", error);
        });
});

let sidoData = [];
let sigunguData = [];
let dongData = [];

function processCSVData(data) {
    const sidoSet = new Set();
    const sigunguSet = {};
    const dongSet = {};

    // 시도, 시군구, 법정동 데이터를 처리
    data.forEach(row => {
        const sido = row['시도명'];
        const sigungu = row['시군구명'];
        const dong = row['법정동명'];

        if (sido) sidoSet.add(sido);
        if (sigungu) {
            if (!sigunguSet[sido]) sigunguSet[sido] = new Set();
            sigunguSet[sido].add(sigungu);
        }
        if (dong) {
            if (!dongSet[sigungu]) dongSet[sigungu] = new Set();
            dongSet[sigungu].add(dong);
        }
    });

    sidoData = ['전체', ...Array.from(sidoSet).sort()];  // '전체'를 항상 첫 번째로 추가
    sigunguData = sigunguSet;
    dongData = dongSet;

    populateSelect('sido', sidoData);
}

function populateSelect(elementId, options) {
    const select = document.getElementById(elementId);
    select.innerHTML = '';  // 기존 옵션 초기화
    options.forEach(option => {
        const opt = document.createElement('option');
        opt.value = option;
        opt.innerHTML = option;
        select.appendChild(opt);
    });
}

function updateSigungu() {
    const sido = document.getElementById('sido').value;
    const sigunguSelect = document.getElementById('sigungu');
    const dongSelect = document.getElementById('dong');
    
    // '전체'를 선택하면 시군구, 동을 숨기고 초기화
    if (sido === '전체') {
        sigunguSelect.style.display = 'none';
        sigunguSelect.innerHTML = '<option value="전체">전체</option>';
        dongSelect.style.display = 'none';
        dongSelect.innerHTML = '<option value="전체">전체</option>';
        return;
    }

    sigunguSelect.style.display = 'block';
    sigunguSelect.innerHTML = '<option value="전체">전체</option>';

    if (sigunguData[sido]) {
        populateSelect('sigungu', ['전체', ...Array.from(sigunguData[sido]).sort()]);
    }

    // 동 선택도 초기화
    dongSelect.style.display = 'none';
    dongSelect.innerHTML = '<option value="전체">전체</option>';
}

function updateDong() {
    const sigungu = document.getElementById('sigungu').value;
    const dongSelect = document.getElementById('dong');
    
    // '전체'를 선택하면 동을 숨기고 초기화
    if (sigungu === '전체') {
        dongSelect.style.display = 'none';
        dongSelect.innerHTML = '<option value="전체">전체</option>';
        return;
    }

    dongSelect.style.display = 'block';
    dongSelect.innerHTML = '<option value="전체">전체</option>';

    if (dongData[sigungu]) {
        populateSelect('dong', ['전체', ...Array.from(dongData[sigungu]).sort()]);
    }
}
</script>
