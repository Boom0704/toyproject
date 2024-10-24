package com.pro.my.influencer.vo;

public class InfluencerPostVO {
    private int influencerId;
    private int postId;
    
   
	public InfluencerPostVO() {
		super();
	}
	public InfluencerPostVO(int influencerId, int postId) {
		super();
		this.influencerId = influencerId;
		this.postId = postId;
	}
	public int getInfluencerId() {
		return influencerId;
	}
	public void setInfluencerId(int influencerId) {
		this.influencerId = influencerId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	@Override
	public String toString() {
		return "InfluencerPostVO [influencerId=" + influencerId + ", postId=" + postId + "]";
	}
}
