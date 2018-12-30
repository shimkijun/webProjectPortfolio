package org.web.boardLike;

public class BoardLikeDTO {

	private int listNum;//게시판 고유 id 값
	private String userId;//접속중인 유저의 아이디 값을 담아주는 필드네임(id중복 불가 id를 고유값으로 활용)
	private int likeNum;//좋아요 를 누르면 1로 저장
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getLikeNum() {
		return likeNum;
	}
	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
	}
	
}
