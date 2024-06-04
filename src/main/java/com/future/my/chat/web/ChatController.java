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
import org.springframework.web.bind.annotation.PathVariable;
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

    @PostMapping("/rooms")
    @ResponseBody
    public ResponseEntity<RoomVO> createRoom(@RequestBody RoomVO roomVO) {
        try {
            chatService.createRoom(roomVO);
            return ResponseEntity.status(HttpStatus.CREATED).body(roomVO);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    
    
 // 채팅 내역 조회
    @GetMapping("/rooms/{roomNo}/chats")
    @ResponseBody
    public ResponseEntity<List<ChatGptVO>> chatListView(@PathVariable int roomNo) {
        try {
            List<ChatGptVO> chatList = chatService.getChatList(roomNo);
            return ResponseEntity.ok(chatList);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
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
    @PostMapping("/rooms/{roomNo}/messages")
    @ResponseBody
    public ResponseEntity<?> sendMessage(@PathVariable int roomNo, @RequestBody ChatGptVO chatVO) {
        Map<String, Object> map = new HashMap<>();
        try {
            // roomNo를 chatVO에 설정
            chatVO.setRoomNo(roomNo);
            // 채팅 메시지를 데이터베이스에 저장
            chatService.insertChat(chatVO);

            System.out.println("메세지 저장");
            System.out.println(chatVO);
            map.put("msg", "Y");
            return ResponseEntity.ok(map);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to send message");
        }
    }


 // 채팅방 삭제
    @DeleteMapping("/rooms/{roomNo}")
    @ResponseBody
    public ResponseEntity<String> deleteRoom(@PathVariable int roomNo) {
        try {
            RoomVO roomVO = new RoomVO();
            roomVO.setRoomNo(roomNo);
            chatService.deleteRoom(roomVO);
            System.out.println("Room deleted: " + roomNo);
            return ResponseEntity.ok("Room deleted successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete room: " + e.getMessage());
        }
    }

}