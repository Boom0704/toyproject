package com.pro.my.member.vo;

import java.util.Date;

public class MemberVO {
    private int id;    
    private String memId;        // 회원 ID
    private String memPw;        // 회원 비밀번호
    private String email;        // 이메일
    private String profileImg;   // 프로필 이미지
    private String useYn;        // 사용 여부
    private Date updateDt;       // 수정 날짜
    private Date createDt;       // 생성 날짜

    // 기본 생성자
    public MemberVO() {}

    // 매개변수가 있는 생성자
    public MemberVO(int id,String memId, String memPw, String email, String profileImg, String useYn, Date updateDt, Date createDt) {
        this.id = id;
        this.memId = memId;
        this.memPw = memPw;
        this.email = email;
        this.profileImg = profileImg;
        this.useYn = useYn;
        this.updateDt = updateDt;
        this.createDt = createDt;
    }

    // Getter와 Setter 메서드
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public String getMemPw() {
        return memPw;
    }

    public void setMemPw(String memPw) {
        this.memPw = memPw;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfileImg() {
        return profileImg;
    }

    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
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

    // toString() 메서드
    @Override
    public String toString() {
        return "MemberVO{" +
                "id=" + id +
                ", memId='" + memId + '\'' +
                ", memPw='" + memPw + '\'' +
                ", email='" + email + '\'' +
                ", profileImg='" + profileImg + '\'' +
                ", useYn='" + useYn + '\'' +
                ", updateDt=" + updateDt +
                ", createDt=" + createDt +
                '}';
    }
}
