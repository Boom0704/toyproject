package com.pro.my.board.vo;

import java.util.Date;

public class FavoriteVO {

    private int postId;     // 게시글 ID
    private String memId;   // 사용자 ID
    private Date favoriteDt; // 즐겨찾기한 날짜

    // 기본 생성자
    public FavoriteVO() {
    }

    // 파라미터를 포함한 생성자
    public FavoriteVO(int postId, String memId, Date favoriteDt) {
        this.postId = postId;
        this.memId = memId;
        this.favoriteDt = favoriteDt;
    }

    // Getter 및 Setter
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

    public Date getFavoriteDt() {
        return favoriteDt;
    }

    public void setFavoriteDt(Date favoriteDt) {
        this.favoriteDt = favoriteDt;
    }

    @Override
    public String toString() {
        return "FavoriteVO{" +
                "postId=" + postId +
                ", memId='" + memId + '\'' +
                ", favoriteDt=" + favoriteDt +
                '}';
    }
}
