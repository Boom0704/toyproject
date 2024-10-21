package com.pro.my.member.dao;

import com.pro.my.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IMemberDAO {

    // 회원 정보 추가 (회원가입)
	public int registMember(MemberVO member);
	// 회원 조회
	public MemberVO loginMember(MemberVO vo);

	public int updateProfileImage(@Param("memId") String memId, @Param("profileImg") String profileImg);
}
