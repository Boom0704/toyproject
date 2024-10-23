document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.card').forEach((card) => {
        card.addEventListener('mousemove', (event) => {
            const cardRect = card.getBoundingClientRect();
            const centerX = cardRect.left + cardRect.width / 2;
            const centerY = cardRect.top + cardRect.height / 2;
            const mouseX = event.clientX - centerX;
            const mouseY = event.clientY - centerY;

            // 각도를 3배로 증가 (더 부드럽게)
            const rotateX = (mouseY / (cardRect.height / 2)) * -45; 
            const rotateY = (mouseX / (cardRect.width / 2)) * 45;

            // 부드러운 회전을 위해 requestAnimationFrame 추가
            window.requestAnimationFrame(() => {
                card.style.transform = `rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
            });
        });

        // 마우스를 뗐을 때 회전 초기화
        card.addEventListener('mouseout', () => {
            card.style.transform = 'rotateX(0deg) rotateY(0deg)';
        });
    });
});
