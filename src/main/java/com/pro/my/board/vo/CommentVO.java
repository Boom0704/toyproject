package com.pro.my.board.vo;

import java.util.Date;

public class CommentVO {
    private int id;               // 댓글 ID
    private String author;        // 글쓴이 (회원 ID)
    private String content;       // 댓글 내용
    private String photoUrl;      // 사진 URL
    private Date createDt;        // 생성 날짜
    private Date updateDt;        // 수정 날짜
    private int postId;           // 게시물 ID

    // 기본 생성자
    public CommentVO() {}

    // 매개변수가 있는 생성자
    public CommentVO(int id, String author, String content, String photoUrl, Date createDt, Date updateDt, int postId) {
        this.id = id;
        this.author = author;
        this.content = content;
        this.photoUrl = photoUrl;
        this.createDt = createDt;
        this.updateDt = updateDt;
        this.postId = postId;
    }

    // Getter 및 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public Date getCreateDt() {
        return createDt;
    }

    public void setCreateDt(Date createDt) {
        this.createDt = createDt;
    }

    public Date getUpdateDt() {
        return updateDt;
    }

    public void setUpdateDt(Date updateDt) {
        this.updateDt = updateDt;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

	@Override
	public String toString() {
		return "CommentVO [id=" + id + ", author=" + author + ", content=" + content + ", photoUrl=" + photoUrl
				+ ", createDt=" + createDt + ", updateDt=" + updateDt + ", postId=" + postId + "]";
	}
}
