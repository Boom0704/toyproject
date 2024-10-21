<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Board Write View</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        #write {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            margin-top: 10vh;
            margin-bottom: 10vh;
        }
        .write-container {
            width: 100%;
            max-width: 1080px;
            padding: 20px;
            border-radius: 20px;
    		border: 2px solid #6d8c8e; /* 보더 추가 및 강조 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            margin-bottom: 20px;
        }
        .write-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .write-header h2 {
            color: #6f5f5e;
            font-size: 2em;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        .photo-preview {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .photo-preview img {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin: 10px;
            position: relative;
        }
        .remove-photo-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 16px;
        }
        .add-photo-btn {
            background-color: #6d8c8e;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            margin-bottom: 10px;
        }
        .add-photo-btn.disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .submit-btn {
            background-color: #5a7b7e;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            display: block;
            width: 100%;
        }
        .submit-btn:hover {
            background-color: #6d8c8e;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/components/header.jsp" />
    <div id="write">
	    <div class="write-container">
	        <div class="write-header">
	            <h2>고양이 사진</h2>
	        </div>
	        <form id="boardWriteForm">
	            <div class="form-group">
	                <input type="text" id="title" placeholder="제목을 입력하세요" required>
	            </div>
	            <div class="form-group">
	                <textarea id="content" placeholder="내용을 입력하세요" rows="5" required></textarea>
	            </div>
	            <div class="form-group">
	                <button type="button" class="add-photo-btn" id="addPhotoBtn">사진 추가 (최대 10장)</button>
	                <input type="file" id="photoInput" style="display: none;" accept="image/*">
	                <div class="photo-preview" id="photoPreview"></div>
	            </div>
	            <button type="button" class="submit-btn" id="submitBtn">작성 완료</button>
	        </form>
        </div>
    </div>
	<jsp:include page="/WEB-INF/components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const photoInput = document.getElementById('photoInput');
        const addPhotoBtn = document.getElementById('addPhotoBtn');
        const photoPreview = document.getElementById('photoPreview');
        const submitBtn = document.getElementById('submitBtn');
        let photoFiles = [];
        const maxPhotos = 10;

        // 사진 추가 버튼 클릭 시 파일 선택 창 열기
        addPhotoBtn.addEventListener('click', () => {
            if (photoFiles.length < maxPhotos) {
                photoInput.click();
            }
        });

        // 파일 선택 시 미리보기 및 사진 배열에 추가
        photoInput.addEventListener('change', function() {
            const file = this.files[0];
            if (file && photoFiles.length < maxPhotos) {
                photoFiles.push(file);
                const reader = new FileReader();
                reader.onload = function(e) {
                    const imgWrapper = document.createElement('div');
                    imgWrapper.style.position = 'relative';
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    const removeBtn = document.createElement('button');
                    removeBtn.textContent = '×';
                    removeBtn.classList.add('remove-photo-btn');
                    removeBtn.onclick = () => removePhoto(imgWrapper, file);
                    imgWrapper.appendChild(img);
                    imgWrapper.appendChild(removeBtn);
                    photoPreview.appendChild(imgWrapper);
                };
                reader.readAsDataURL(file);
            }
            updateAddPhotoBtn();
        });

        // 사진 삭제
        function removePhoto(wrapper, file) {
            wrapper.remove();
            photoFiles = photoFiles.filter(f => f !== file);
            updateAddPhotoBtn();
        }

        // 사진이 10장일 경우 더 이상 추가 불가능
        function updateAddPhotoBtn() {
            if (photoFiles.length >= maxPhotos) {
                addPhotoBtn.classList.add('disabled');
                addPhotoBtn.disabled = true;
            } else {
                addPhotoBtn.classList.remove('disabled');
                addPhotoBtn.disabled = false;
            }
        }

        // 게시글 작성 완료 버튼 클릭 시 사진 업로드 후 글 저장
        submitBtn.addEventListener('click', () => {
            if (photoFiles.length === 0) {
                alert("최소 1장의 사진을 업로드해야 합니다.");
                return;
            }

            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;

            if (!title || !content) {
                alert("제목과 내용을 입력하세요.");
                return;
            }

            const uploadedUrls = [];

            // 사진들을 하나씩 업로드
            const uploadPromises = photoFiles.map(file => uploadPhoto(file));

            Promise.all(uploadPromises).then(urls => {
                uploadedUrls.push(...urls);

                // 모든 사진이 업로드된 후 게시글 저장 요청
                fetch("/boardWriteDo", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        title: title,
                        content: content,
                        imageUrls: uploadedUrls // 사진 URLs 배열
                    })
                })
                .then(response => response.text())
                .then(result => {
                    alert("게시글이 성공적으로 작성되었습니다.");
                    window.location.href = "/boardList";
                })
                .catch(error => {
                    console.error("게시글 작성 중 오류 발생:", error);
                    alert("게시글 작성 중 오류가 발생했습니다.");
                });
            });
        });

        // 사진 업로드 함수
        function uploadPhoto(file) {
            const formData = new FormData();
            formData.append("file", file);

            return fetch("/picture/upload", {
                method: "POST",
                body: formData
            })
            .then(response => response.text());
        }
    </script>
</body>
</html>
