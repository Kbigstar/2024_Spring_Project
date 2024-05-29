package com.future.my.commons.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.future.my.member.vo.MemberVO;

public class LoginCheckinterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		if (login == null) {
			response.sendRedirect(request.getContextPath()+"/loginView");
			return false;
		}
		
		return true; // 로그인 정보가 있을 경우
	}
}
