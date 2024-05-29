package com.future.my.chat.vo;

public class RoomVO {
	private int roomNo;
	private String roomName;
	private String memId;
	private String regDate;
	private String delYn;
	
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	@Override
	public String toString() {
		return "RoomVO [roomNo=" + roomNo + ", roomName=" + roomName + ", memId=" + memId + ", regDate=" + regDate
				+ ", delYn=" + delYn + "]";
	}
	
	
}
