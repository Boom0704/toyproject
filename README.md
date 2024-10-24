# 프로젝트 개요
이 프로젝트는 사용자가 게시글을 작성하고, 댓글을 달며, 좋아요와 즐겨찾기를 통해 상호작용할 수 있는 **커뮤니티 플랫폼**입니다. **Spring MVC**와 **Oracle Database**를 사용해 백엔드를 개발하고, **JSP**로 프론트엔드를 구성했습니다. 주요 기능으로는 게시글 및 댓글 관리, 좋아요 및 즐겨찾기 기능이 포함되어 있습니다.

# 기술 스택
- **Backend**: Spring MVC, MyBatis
- **Frontend**: JSP, HTML, CSS, JavaScript
- **Database**: Oracle Database
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9.0

# 주요 기능

## 게시글 관리:
- 게시글 작성, 수정, 삭제, 조회 기능
- 게시글에 사진, 내용, 위치 정보 추가 가능
- `POST_ID` 자동 증가

## 댓글 관리:
- 게시글에 댓글 작성 및 삭제 기능
- 댓글은 작성자, 내용, 작성 시간 포함

## 좋아요 및 즐겨찾기:
- 게시글에 좋아요 및 즐겨찾기 추가/삭제 가능

## 사용자 관리:
- 사용자 로그인 및 회원가입
- 프로필 이미지 변경 기능

# 프로젝트 구조
- **Controller**: 요청 처리 및 서비스 호출
- **Service**: 비즈니스 로직 처리
- **DAO**: 데이터베이스 접근 및 쿼리 실행
- **MyBatis**: SQL 매퍼를 사용한 DB 연동
	