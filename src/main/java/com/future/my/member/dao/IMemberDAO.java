package com.future.my.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.member.vo.MemberVO;

@Mapper
public interface IMemberDAO {
	// 회원가입
	public int registMember(MemberVO vo);
	
	// 회원 조회 [로그인]
	public MemberVO loginMember(MemberVO vo);
	
	// 회원 이름수정
	public int updateMember(MemberVO vo);
	
	public boolean selectId(String id);
}
