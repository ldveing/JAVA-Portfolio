package mall.cart;

public class CartDTO {
	// 장바구니 번호, 구매자, 상품 번호, 상품 이름, 저자, 출판사, 상품가격, 할인율, 구매 금액, 구매 수량, 상품 이미지
	private int cart_id;
	private String buyer;
	private int product_id;
	private String product_name;
	private String manufacturing_com;
	private int product_price;
	private int discount_rate;
	private int buy_price;
	private int buy_count;
	private String product_image;

	public int getCart_id() {
		return cart_id;
	}

	public String getBuyer() {
		return buyer;
	}

	public int getProduct_id() {
		return product_id;
	}

	public String getProduct_name() {
		return product_name;
	}

	public String getManufacturing_com() {
		return manufacturing_com;
	}

	public int getProduct_price() {
		return product_price;
	}

	public int getDiscount_rate() {
		return discount_rate;
	}

	public int getBuy_price() {
		return buy_price;
	}

	public int getBuy_count() {
		return buy_count;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setManufacturing_com(String manufacturing_com) {
		this.manufacturing_com = manufacturing_com;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}

	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}

	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	@Override
	public String toString() {
		return "CartDTO [cart_id=" + cart_id + ", buyer=" + buyer + ", product_id=" + product_id + ", product_name="
				+ product_name + ", manufacturing_com=" + manufacturing_com + ", product_price=" + product_price
				+ ", discount_rate=" + discount_rate + ", buy_price=" + buy_price + ", buy_count=" + buy_count
				+ ", product_image=" + product_image + "]";
	}

}
