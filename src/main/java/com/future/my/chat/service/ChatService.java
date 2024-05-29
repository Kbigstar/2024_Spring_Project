package com.future.my.chat.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.chat.dao.IChatDAO;
import com.future.my.chat.vo.ChatGptVO;
import com.future.my.chat.vo.RoomVO;

@Service
public class ChatService {
    @Autowired
    IChatDAO dao;

    // 채팅방 조회
    public List<RoomVO> getRoomList(String userId) {
        return dao.getRoomList(userId);
    }
    
    // 채팅방 생성
	public void createRoom(RoomVO vo) {
		dao.createRoom(vo);
	}
	
	// 채팅내용 기록
	public void insertChat(ChatGptVO chatVO) {
		dao.insertChat(chatVO);
	}
	
	// 채팅내용
	public List<ChatGptVO> getChatList(int roomNo){
		return dao.getChatList(roomNo);
	}
	
	public void deleteRoom(RoomVO vo) {
		dao.deleteRoom(vo);
	}
}
