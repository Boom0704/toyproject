package com.pro.my.influencer.vo;

import java.util.Date;

public class InfluencerVO {
    private int id;
    private String mainPhoto;
    private String address;
    private String name;
    private double latitude;
    private double longitude;
    private Date createdAt;
    private Date updatedAt;
    
    
    
	public InfluencerVO() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public InfluencerVO(int id, String mainPhoto, String address, String name, double latitude, double longitude,
			Date createdAt, Date updatedAt) {
		super();
		this.id = id;
		this.mainPhoto = mainPhoto;
		this.address = address;
		this.name = name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMainPhoto() {
		return mainPhoto;
	}
	public void setMainPhoto(String mainPhoto) {
		this.mainPhoto = mainPhoto;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	@Override
	public String toString() {
		return "InfluencerVO [id=" + id + ", mainPhoto=" + mainPhoto + ", address=" + address + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
}
