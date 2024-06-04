package com.future.my.chat.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.future.my.chat.service.ChatService;
import com.future.my.chat.vo.ChatGptVO;
import com.future.my.chat.vo.RoomVO;
import com.future.my.member.vo.MemberVO;

@Controller
public class ChatController {

    @Autowired
    ChatService chatService;

    // 채팅방 조회
    @RequestMapping("/chatView")
    public String chatView(HttpSession session, Model model) {
        MemberVO loginUser = (MemberVO) session.getAttribute("login");
        if (loginUser == null) {
            // 로그인되지 않은 사용자 처리
            return "redirect:/loginView";
        }
        
        String userId = loginUser.getMemId(); // 세션에서 사용자 아이디 가져오기
        List<RoomVO> roomList = chatService.getRoomList(userId);
        model.addAttribute("roomList", roomList);
        return "chatgpt/chatgpt";
    }

    // 채팅방 생성
    @PostMapping("/createRoom")
    @ResponseBody
    public RoomVO createRoom(@RequestBody RoomVO roomVO) {
            chatService.createRoom(roomVO);
            System.out.println(roomVO);
        return roomVO;
    }
    
    
 // 채팅 내역 조회
    @GetMapping("/chatListView")
    @ResponseBody
    public List<ChatGptVO> chatListView(@RequestParam int roomNo) {
        return chatService.getChatList(roomNo);
    }


    static class RequestData {
        private int roomNo;

        public int getRoomNo() {
            return roomNo;
        }

        public void setRoomNo(int roomNo) {
            this.roomNo = roomNo;
        }
    }
    
    // 채팅 메시지 전송 처리
    @ResponseBody
    @PostMapping("/sendMessage")
    public ResponseEntity<?> sendMessage(@RequestBody ChatGptVO chatVO) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	// 채팅 메시지를 데이터베이스에 저장
        chatService.insertChat(chatVO);

        
        System.out.println("메세지 저장");
        System.out.println(chatVO);
        map.put("msg", "Y");
        return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
    }

 // 채팅방 삭제
    @DeleteMapping("/deleteRoom")
    @ResponseBody
    public ResponseEntity<String> deleteRoom(@RequestBody RoomVO roomVO) {
        try {
            System.out.println(roomVO);
            chatService.deleteRoom(roomVO);
            System.out.println("========================");
            return new ResponseEntity<>("Room deleted successfully!", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to delete room: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
}