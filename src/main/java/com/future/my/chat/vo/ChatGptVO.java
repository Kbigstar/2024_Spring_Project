package com.future.my.chat.vo;

public class ChatGptVO {
	private int chatNo;
	private int roomNo;
	private String memId;
	private String chatMsg;
	private String sendDate;
	
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getChatMsg() {
		return chatMsg;
	}
	public void setChatMsg(String chatMsg) {
		this.chatMsg = chatMsg;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	@Override
	public String toString() {
		return "ChatGptVO [chatNo=" + chatNo + ", roomNo=" + roomNo + ", memId=" + memId + ", chatMsg=" + chatMsg
				+ ", sendDate=" + sendDate + "]";
	}
	
	
}
