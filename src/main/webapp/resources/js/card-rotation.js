document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.card').forEach((card) => {
        // 마우스가 들어왔을 때 확대 및 회전 적용
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'scale(1.3)'; // 확대
            card.style.transition = 'transform 0.3s ease'; // 부드러운 확대 효과
        });

        // 마우스를 움직일 때 회전 적용
        card.addEventListener('mousemove', (event) => {
            const cardRect = card.getBoundingClientRect();
            const centerX = cardRect.left + cardRect.width / 2;
            const centerY = cardRect.top + cardRect.height / 2;
            const mouseX = event.clientX - centerX;
            const mouseY = event.clientY - centerY;

            const rotateX = (mouseY / (cardRect.height / 2)) * -50; 
            const rotateY = (mouseX / (cardRect.width / 2)) * 50;

            card.style.transform = `rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(1.3)`; // 회전 + 확대
        });

        // 마우스가 나갔을 때 원복
        card.addEventListener('mouseleave', () => {
            card.style.transform = 'rotateX(0deg) rotateY(0deg) scale(1)'; // 원래 크기로 회복
            card.style.transition = 'transform 0.3s ease'; // 부드러운 원복 효과
        });
    });
});
