package org.web.memberDTO;

public class NormalMemberDTO {
	
	private String userId;
	private String userPw;
	private String userEmail;
	private String userPhone;
	private byte ifNull;
	public NormalMemberDTO() {};
	
	public NormalMemberDTO(String userId, String userPw, String userEmail, String userPhone) {
		super();
		this.userId = userId;
		this.userPw = userPw;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
	
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public byte getIfNull() {
		return ifNull;
	}

	public void setIfNull(byte ifNull) {
		this.ifNull = ifNull;
	}
	
	

}
