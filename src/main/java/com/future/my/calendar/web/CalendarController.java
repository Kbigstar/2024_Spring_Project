package com.future.my.calendar.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.future.my.calendar.service.CalendarService;
import com.future.my.calendar.vo.CalendarVO;


@Controller
public class CalendarController {
	
	@Autowired
	CalendarService calService;
	
	@RequestMapping("/calendarView")
	public String calendarView() {
		return "calendar/calendar";
	}
	
	// 일정 조회
	@RequestMapping("/calendarData")
	@ResponseBody
	public List<CalendarVO> getCalendarData(@RequestBody CalendarVO vo) {
		System.out.println(vo);
		System.out.println(calService.getCalendarList(vo));
	    return calService.getCalendarList(vo);
	}

	// 일정 등록
	@RequestMapping("/addEvent")
	    public ResponseEntity<?> addCalendarEvent(@RequestBody CalendarVO vo) {
			Map<String, Object> map = new HashMap<String, Object>();
	        try {
	        	
	            // 여기서 캘린더 이벤트 추가 로직을 처리하고 성공 했다면
	             calService.addCalendarEvent(vo);
	             System.out.println(">>>>>" + vo.getCalNo());
	             map.put("calNo", vo.getCalNo());
	             return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	        } catch (Exception e) {
	        	 return new ResponseEntity<Map<String, Object>>(map, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
	
	// 일정 등록
	@RequestMapping("/updateEvent")
	    public ResponseEntity<String> updateCalendarEvent(@RequestBody CalendarVO vo) {
	        try {
	            // 여기서 캘린더 이벤트 수정 로직을 처리하고 성공 했다면
	        	System.out.println("업데이트");
	        	System.out.println(vo);
	             calService.updateCalendarEvent(vo);
	            return ResponseEntity.ok().body("[not error]Event update successfully");
	        } catch (Exception e) {
	        	System.out.println(e);
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update event");
	        }
	    }
	
	// 일정 삭제
	@RequestMapping("/delEvent")
	    public ResponseEntity<String> updateCalendarDel(@RequestBody CalendarVO vo) {
	        try {
	            // 여기서 캘린더 이벤트 삭제 로직을 처리하고 성공 했다면
	        	System.out.println("[삭제] 업데이트");
	        	System.out.println(vo);
	             calService.updateCalendarDel(vo);
	            return ResponseEntity.ok().body("[not error]Event del update successfully");
	        } catch (Exception e) {
	        	System.out.println(e);
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to del update event");
	        }
	    }
}
