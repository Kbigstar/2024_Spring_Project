package com.future.my.member.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.future.my.member.service.MemberService;
import com.future.my.member.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping("/loginView")
	public String loginView() {
		
		return "member/loginView";
	}
	
	// 로그인
	@RequestMapping("/loginDo")
	public String loginDo(MemberVO vo, HttpSession session
			, boolean remember, String fromURL
			, RedirectAttributes re, HttpServletResponse resp) throws Exception {
		System.out.println("id = " + vo.getMemId());
		System.out.println("pw = " + vo.getMemPw());
		
		MemberVO login = memberService.loginMember(vo);
		if (login == null) {
			re.addFlashAttribute("msg", "아이디 또는 비밀번호를 확인해주세요..!");
			return "redirect:/loginView";
		}

		// 첫번째 매개변수 ([사용자입력] 아직 암호화가 안된)
		// 두번째 매개변수 (암호화가 된 비밀번호)
		boolean match = passwordEncoder.matches(vo.getMemPw(), login.getMemPw());
		if (!match) {
			re.addFlashAttribute("msg", "비밀번호를 확인 해주세요..!");
			return "redirect:/loginView";
		}
		
		System.out.println("controller : " + login);
		
		session.setAttribute("login", login);

		// 아이디 기억하기 선택했을 때
		if(remember) {
			Cookie cookie = new Cookie("rememberId", vo.getMemId());
			resp.addCookie(cookie); // 응답하는 객체에 담아서 전달
		} else {
			Cookie cookie = new Cookie("rememberId", "");
			cookie.setMaxAge(0); // 유효시간이 없게 (유효시간 없으면 삭제됨)
			resp.addCookie(cookie);
		}
		
		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping("/logoutDo")
	public String logOutDo(HttpSession session, RedirectAttributes re) {
		
		if(session.getAttribute("login") == null)
		{
			re.addFlashAttribute("msg", "로그인 상태가 아닙니다 !!");
			return "redirect:/loginView";
		}
		
		// 세션종료
		session.invalidate();
		
		re.addFlashAttribute("msg", "로그아웃 되셨습니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/registView")
	public String registView() {
		
		return "member/registView";
	}
	
	// 회원 가입
	@RequestMapping("/registDo")
	public String registDo(HttpServletRequest request, MemberVO member, RedirectAttributes re) {
		member.setMemPw(passwordEncoder.encode(request.getParameter("memPw"))); 
		System.out.println(member);
		try {
			memberService.registMember(member);
		} catch (Exception e) {
			e.printStackTrace();
			re.addFlashAttribute("msg", "이미 존재하는 아이디입니다!");

			return "redirect:/registView";
		}
		
		re.addFlashAttribute("msg", "회원가입이 정상적으로 처리 되었습니다!");
		
		return "redirect:/";
	}
	
	@RequestMapping("/mypageView")
	public String mypageView(HttpSession session, Model model) {
		if (session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		
		return "member/mypageView";
	}
	
	// 회원 수정
	@RequestMapping("/updateDo")
	public String updateDo(HttpServletRequest request, MemberVO member, RedirectAttributes re) {
	    System.out.println(request.getParameter("userId"));
	    System.out.println(member);

	    // 원본 비밀번호 확인
	    String memPw = request.getParameter("memPw");
	    System.out.println("원본 비밀번호: " + memPw);

	    // 비밀번호 암호화
	    String encodedPw = passwordEncoder.encode(memPw);
	    member.setMemPw(encodedPw);
	    System.out.println("encodedPw :" + encodedPw);
	    System.out.println("member VO:"+member);

	    try {
	        memberService.updateMember(member);
	    } catch (Exception e) {
	        e.printStackTrace();
	        re.addFlashAttribute("msg", "회원수정에 실패하였습니다..");
	        return "redirect:/mypageView";
	    }

	    re.addFlashAttribute("msg2", "회원수정이 정상적으로 처리 되었습니다!");

	    return "redirect:/mypageView";
	}
	
	// FAQ
	@RequestMapping("/faqView")
	public String faqView() {
		return "member/faqView";
	}
	
	
	// 아이디 중복 확인
	@PostMapping("/ConfirmId")
	@ResponseBody
	public ResponseEntity<Boolean> confirmId(String id){
		System.out.println("confirm Id...");
		System.out.println("id : " + id);
		boolean result = true;
		
		if(id.trim().isEmpty()) {
			System.out.println("id : " + id);
			result = false;
		} else {
			if(memberService.selectId(id)){
				result = false;
			} else {
				result = true;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
}
