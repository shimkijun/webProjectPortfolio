package org.web.chatDTO;

public class ChatDTO {
	private int chatId;
	private String fromId;
	private String toId;
	private String chatContent;
	private String chatTime;
	private int chatRead;
	private int chatRe;

	
	public int getChatId() {
		return chatId;
	}
	public void setChatId(int chatId) {
		this.chatId = chatId;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	public int getChatRead() {
		return chatRead;
	}
	public void setChatRead(int chatRead) {
		this.chatRead = chatRead;
	}
	
	public int getChatRe() {
		return chatRe;
	}
	public void setChatRe(int chatRe) {
		this.chatRe = chatRe;
	}

	
	
}
