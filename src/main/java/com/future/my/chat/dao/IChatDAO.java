package com.future.my.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.chat.vo.ChatGptVO;
import com.future.my.chat.vo.RoomVO;

@Mapper
public interface IChatDAO {
	
	public List<RoomVO> getRoomList(String memId);
	
	// 채팅방 생성
	public int createRoom(RoomVO vo);
	
	// 채팅내용 삽입
	public int insertChat(ChatGptVO chatVO);

	// 채팅내용 
	public List<ChatGptVO> getChatList(int roomNo);
	
	// 채팅방 삭제
	public int deleteRoom(RoomVO vo);
	
}
