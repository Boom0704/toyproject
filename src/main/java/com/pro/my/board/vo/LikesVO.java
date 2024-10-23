package com.pro.my.board.vo;

import java.util.Date;

public class LikesVO {
    private int postId;     // POST_ID (게시글 ID)
    private String memId;   // MEM_ID (회원 ID)
    private Date likeDt;    // LIKE_DT (좋아요 누른 날짜)

    // Getters and Setters
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public Date getLikeDt() {
        return likeDt;
    }

    public void setLikeDt(Date likeDt) {
        this.likeDt = likeDt;
    }

	@Override
	public String toString() {
		return "LikesVO [postId=" + postId + ", memId=" + memId + ", likeDt=" + likeDt + "]";
	}
    
}
