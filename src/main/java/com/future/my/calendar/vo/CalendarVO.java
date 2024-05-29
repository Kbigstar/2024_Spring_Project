package com.future.my.calendar.vo;

public class CalendarVO {

	private int calNo;
	private String calTitle;
	private String calStartdt;
	private String calEnddt;
	private String calAllday;
	private String calBgcolor;
	private String calTextcolor;
	private String memId;
	private String delYn;
	public int getCalNo() {
		return calNo;
	}
	public void setCalNo(int calNo) {
		this.calNo = calNo;
	}
	public String getCalTitle() {
		return calTitle;
	}
	public void setCalTitle(String calTitle) {
		this.calTitle = calTitle;
	}
	public String getCalStartdt() {
		return calStartdt;
	}
	public void setCalStartdt(String calStartdt) {
		this.calStartdt = calStartdt;
	}
	public String getCalEnddt() {
		return calEnddt;
	}
	public void setCalEnddt(String calEnddt) {
		this.calEnddt = calEnddt;
	}
	public String getCalAllday() {
		return calAllday;
	}
	public void setCalAllday(String calAllday) {
		this.calAllday = calAllday;
	}
	public String getCalBgcolor() {
		return calBgcolor;
	}
	public void setCalBgcolor(String calBgcolor) {
		this.calBgcolor = calBgcolor;
	}
	public String getCalTextcolor() {
		return calTextcolor;
	}
	public void setCalTextcolor(String calTextcolor) {
		this.calTextcolor = calTextcolor;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	@Override
	public String toString() {
		return "CalendarVO [calNo=" + calNo + ", calTitle=" + calTitle + ", calStartdt=" + calStartdt + ", calEnddt="
				+ calEnddt + ", calAllday=" + calAllday + ", calBgcolor=" + calBgcolor + ", calTextcolor="
				+ calTextcolor + ", memId=" + memId + ", delYn=" + delYn + "]";
	}
	
	
}
