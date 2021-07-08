package product;

import java.util.ArrayList;

public class ProductRepository {

	private ArrayList<Product> listOfProducts = new ArrayList<>();
	//싱글톤 패턴
	private static ProductRepository instance = new ProductRepository();

	public static ProductRepository getInstance() {
		return instance; //객체 생성 대신에 getInstance
	}

	public ProductRepository() {
		
	}
	//DB에서 SELECT * FROM product로 가져온다.
	public ArrayList<Product> getAllProducts() {
		return listOfProducts; 
	}

	//아이디로 제품을 검색해서 제품 객체를 리턴한다.
	public Product getProductById(String pId) {
		Product productById = null;
		// 리스트의 제품들을 하나씩 반복문을 실행한다.
		for (int i = 0; i < listOfProducts.size(); i++) {
			Product product = listOfProducts.get(i);
			if (product.getPid().equals(pId)) {
				productById = product;
				break;
			}
		}
		return productById;
	}
	//새로 등록된 제품을 디비에 저장
	// 새로 등록된 제품을 리스트에 추가한다.
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}

}
