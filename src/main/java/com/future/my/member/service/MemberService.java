package com.future.my.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.member.dao.IMemberDAO;
import com.future.my.member.vo.MemberVO;

import jdk.internal.org.jline.utils.Log;

@Service
public class MemberService {
	
	@Autowired
	IMemberDAO dao;
	// 회원가입
	public void registMember(MemberVO member) throws Exception {
		int result = dao.registMember(member);
		
		if (result == 0) {
			throw new Exception();
		}
	}
	
	// 로그인
	public MemberVO loginMember(MemberVO member){
		return dao.loginMember(member);
	}
	
	// 회원수정 (update)
	public void updateMember(MemberVO vo) throws Exception {
		int result = dao.updateMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}
	
	public boolean selectId(String id) {
		System.out.println("id 중복확인");
		return dao.selectId(id);
	}
	
}
