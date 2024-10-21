package com.pro.my.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.my.member.dao.IMemberDAO;
import com.pro.my.member.vo.MemberVO;

@Service  // 비지니스 로직을 처리하는 계층
public class MemberService {

	// spring 의 의존성 주입(dependency Injection) 을 자동으로 처리
	@Autowired
	IMemberDAO dao;
	
	public void registMember(MemberVO vo) throws Exception {
		int result = dao.registMember(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public MemberVO loginMember(MemberVO vo) throws Exception {
		MemberVO user = dao.loginMember(vo);
		if(user == null) {
			throw new Exception();	
		}
		return user;
		
	}
	
    // 프로필 이미지 변경
    public void updateProfileImage(String memId, String profileImg) throws Exception {
        int result = dao.updateProfileImage(memId, profileImg);
        if (result == 0) {
            throw new Exception("프로필 이미지 업데이트 실패");
        }
    }
}
