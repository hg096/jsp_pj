package model;

public class OrderDTO {
	private int o_num; // 주문번호
	private String p_name; // 상품이름
	private int amount;	// 수량
	private String m_name; // 주문자
	private String regist_day; // 주문날짜
	private int t_Price; // 총가격
	private String conditions; // 상태
	private String postcode; //우편번호
	private String address; // 주소 
	
	
	public OrderDTO() {
		super();
	}


	public int getO_num() {
		return o_num;
	}


	public void setO_num(int o_num) {
		this.o_num = o_num;
	}


	public String getP_name() {
		return p_name;
	}


	public void setP_name(String p_name) {
		this.p_name = p_name;
	}


	public int getAmount() {
		return amount;
	}


	public void setAmount(int amount) {
		this.amount = amount;
	}


	public String getM_name() {
		return m_name;
	}


	public void setM_name(String m_name) {
		this.m_name = m_name;
	}


	public String getRegist_day() {
		return regist_day;
	}


	public void setRegist_day(String regist_day) {
		this.regist_day = regist_day;
	}


	public int getT_Price() {
		return t_Price;
	}


	public void setT_Price(int t_Price) {
		this.t_Price = t_Price;
	}


	public String getConditions() {
		return conditions;
	}


	public void setConditions(String conditions) {
		this.conditions = conditions;
	}


	public String getPostcode() {
		return postcode;
	}


	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}

	
	
}
