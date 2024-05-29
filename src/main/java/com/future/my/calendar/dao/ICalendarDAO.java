package com.future.my.calendar.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.future.my.calendar.vo.CalendarVO;

@Mapper
public interface ICalendarDAO {
	// 일정 조회
	public List<CalendarVO> getCalendarList(CalendarVO vo);
	
	// 일정 등록
	public int addCalendarEvent(CalendarVO vo);
	
	// 일정 수정
	public int updateCalendarEvent(CalendarVO vo);
	public int getNextCalNo(); // 게시글 수정을 위한 시퀀스 조회
	
	// 일정 삭제 (수정으로 del_yn 컬럼 'N' --> 'Y')
	// del_yn = 'N' 조건을걸어서 조회 할 것 DB에 데이터는 남아있음
	public int updateCalendarDel(CalendarVO vo);
	
}
