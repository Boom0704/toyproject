package com.pro.my.board.vo;

import java.util.Date;

public class BoardVO {
    private int postId;
    private String memId;
    private String title;
    private String content;
    private String photoUrls;
    private String likes; 
    private int views;
    private String favorites;
    private String useYn;
    private Date updateDt;
    private Date createDt;
    private double latitude;
    private double longitude;
    // 기본 생성자
    public BoardVO() {}

    // 모든 필드를 포함한 생성자
    public BoardVO(int postId, String memId, String title, String content, String photoUrls, String likes, int views, String favorites, String useYn, Date updateDt, Date createDt, double latitude, double longitude) {
        this.postId = postId;
        this.memId = memId;
        this.title = title;
        this.content = content;
        this.photoUrls = photoUrls;
        this.likes = likes;
        this.views = views;
        this.favorites = favorites;
        this.useYn = useYn;
        this.updateDt = updateDt;
        this.createDt = createDt;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    // Getter와 Setter 메서드
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPhotoUrls() {
        return photoUrls;
    }

    public void setPhotoUrls(String photoUrls) {
        this.photoUrls = photoUrls;
    }

    public String getLikes() {
        return likes;
    }

    public void setLikes(String likes) {
        this.likes = likes;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getFavorites() {
        return favorites;
    }

    public void setFavorites(String favorites) {
        this.favorites = favorites;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public Date getUpdateDt() {
        return updateDt;
    }

    public void setUpdateDt(Date updateDt) {
        this.updateDt = updateDt;
    }

    public Date getCreateDt() {
        return createDt;
    }

    public void setCreateDt(Date createDt) {
        this.createDt = createDt;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    
    @Override
    public String toString() {
        return "BoardVO [postId=" + postId + ", title=" + title + ", content=" + content 
            + ", likes=" + likes + ", memId=" + memId + ", photoUrls=" + photoUrls 
            + ", latitude=" + latitude + ", longitude=" + longitude + "]";
    }
}