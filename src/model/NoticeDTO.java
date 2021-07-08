package model;

public class NoticeDTO {
	private int n_num; // 게시글번호
	private String name; // 이름
	private String subject; // 제목
	private String content; // 내용
	private String regist_day; // 날짜
	private int hit; // 조회수
	private String ip; // ip주소

	public NoticeDTO() {
		super();
	}

	public int getN_num() {
		return n_num;
	}

	public void setN_num(int n_num) {
		this.n_num = n_num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegist_day() {
		return regist_day;
	}

	public void setRegist_day(String regist_day) {
		this.regist_day = regist_day;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	

}