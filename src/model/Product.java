package product;

import java.io.Serializable;

public class Product implements Serializable {

	private static final long serialVersionUID = -4274700572038677000L;
	private String categoryL; // 분류
	private String categoryS; // 분류
	private String Pid; // 상품 아이디
	private String name; // 상품명
	private String description; // 상품 설명
	private Integer unitPrice; // 상품 가격
	private String fileName; // 이미지 파일명

	private int quantity; // 장바구니에 담은 개수

	public Product() {
		super();
	}

	public String getCategoryL() {
		return categoryL;
	}

	public void setCategoryL(String categoryL) {
		this.categoryL = categoryL;
	}

	public String getCategoryS() {
		return categoryS;
	}

	public void setCategoryS(String categoryS) {
		this.categoryS = categoryS;
	}

	

	public String getPid() {
		return Pid;
	}

	public void setPid(String pid) {
		Pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	
}
