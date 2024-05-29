package com.future.my.calendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.calendar.dao.ICalendarDAO;
import com.future.my.calendar.vo.CalendarVO;

@Service
public class CalendarService {
	
	@Autowired
	ICalendarDAO dao;
	

	
	public List<CalendarVO> getCalendarList(CalendarVO vo){
		List<CalendarVO> result = dao.getCalendarList(vo);
		return result;
	}

	public void addCalendarEvent(CalendarVO vo) throws Exception {
		int result = dao.addCalendarEvent(vo);
		System.out.println("=======================" + vo.getCalNo());
		if (result == 0) {
			throw new Exception();
		}
	}
	
	public void updateCalendarEvent(CalendarVO vo) throws Exception {
		int result = dao.updateCalendarEvent(vo);
		
		if (result == 0) {
			throw new Exception();
		}
	}
	
	public void updateCalendarDel(CalendarVO vo) throws Exception {
		int result = dao.updateCalendarDel(vo);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
}
