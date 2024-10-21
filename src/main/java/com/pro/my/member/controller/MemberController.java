package com.pro.my.member.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.my.member.service.MemberService;
import com.pro.my.member.vo.MemberVO;


@Controller
public class MemberController {
	@Autowired   // 컨트롤러에 전역적으로 memberService 사용가능
	MemberService memberService;

	@RequestMapping("/loginView")
	public String loginView() {
		return "member/loginView";
	}
	
	@RequestMapping("/loginDo")
	public String loginDo(MemberVO vo, boolean remember, HttpSession session, HttpServletResponse response) throws Exception {
		System.out.println(vo);
		MemberVO login = memberService.loginMember(vo);
		session.setAttribute("login", login);
		
		if(remember) {
			// 쿠키 생성
			Cookie cookie = new Cookie("rememberId", login.getMemId());
			response.addCookie(cookie);
		}else {
			// 쿠키 삭제
			// 동일한 key 값을 가지는 쿠키의 유효시간을 0으로
			Cookie cookie = new Cookie("rememberId","");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		return "redirect:/";
	}
	
	@RequestMapping("/logoutDo")
	public String logout(HttpSession session) throws Exception{
		
		session.invalidate();
		
		return "redirect:/";
	}
	

	@RequestMapping("/registView")
	public String registView() {
		return "member/registView";
	}
	
	@RequestMapping("/profileView")
	public String profileView() {
		return "member/profileView";
	}
	
	@RequestMapping("/registerDo")
	public String registerDo(MemberVO vo) {
		System.out.println(vo);
		vo.setUseYn("Y");
		vo.setProfileImg("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png");
		try {
			memberService.registMember(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/loginView";
	}
	
    @PostMapping("/member/imgchange")
    public void changeProfileImage(@RequestBody Map<String, String> data) {
        String imageUrl = data.get("imageUrl");
        String memId = data.get("memId"); // 클라이언트에서 사용자 ID도 받아온다고 가정

        try {
            // 서비스 계층을 통해 프로필 이미지 업데이트
            memberService.updateProfileImage(memId, imageUrl);
            System.out.println("프로필 이미지 업데이트 완료: " + imageUrl);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("프로필 이미지 업데이트 실패");
        }
    }
}
