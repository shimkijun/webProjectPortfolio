package org.web.bbsProDTO;

public class BoardDTO {

	private int pro_id; //seq_num
	private String pro_userName; //작성자 이름및 업체
	private String business_name; //기업 이름
	private String detail_ex; //상세 설명
	private int postNum; //우편번호
	private String business_addr; //기업 소제지
	private String business_addr1; //상세 주소
	private String thumbnail_file; //썸네일 이미지
	private String slide_file; //슬라이드 이미지
	private String LatY; // y좌표
	private String LngX; // x좌표
	
	public int getPro_id() {
		return pro_id;
	}
	public void setPro_id(int pro_id) {
		this.pro_id = pro_id;
	}
	public String getPro_userName() {
		return pro_userName;
	}
	public void setPro_userName(String pro_userName) {
		this.pro_userName = pro_userName;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public String getDetail_ex() {
		return detail_ex;
	}
	public void setDetail_ex(String detail_ex) {
		this.detail_ex = detail_ex;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getBusiness_addr() {
		return business_addr;
	}
	public void setBusiness_addr(String business_addr) {
		this.business_addr = business_addr;
	}
	
	public String getBusiness_addr1() {
		return business_addr1;
	}
	public void setBusiness_addr1(String business_addr1) {
		this.business_addr1 = business_addr1;
	}
	public String getThumbnail_file() {
		return thumbnail_file;
	}
	public void setThumbnail_file(String thumbnail_file) {
		this.thumbnail_file = thumbnail_file;
	}
	
	public String getSlide_file() {
		return slide_file;
	}
	public void setSlide_file(String slide_file) {
		this.slide_file = slide_file;
	}
	public String getLatY() {
		return LatY;
	}
	public void setLatY(String latY) {
		LatY = latY;
	}
	public String getLngX() {
		return LngX;
	}
	public void setLngX(String lngX) {
		LngX = lngX;
	}
	
	

	
}
