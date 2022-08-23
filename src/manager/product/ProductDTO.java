package manager.product;

import java.sql.Timestamp;

public class ProductDTO {
	private int product_id;
	private String product_kind;
	private String product_name;
	private int product_price;
	private int product_count;
	private String manufacturing_com;
	private String manufacturing_date;
	private String product_image;
	private String product_content;
	private int discount_rate;
	private Timestamp reg_date;

	public int getProduct_id() {
		return product_id;
	}

	public String getProduct_kind() {
		return product_kind;
	}

	public String getProduct_name() {
		return product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public int getProduct_count() {
		return product_count;
	}

	public String getManufacturing_com() {
		return manufacturing_com;
	}

	public String getManufacturing_date() {
		return manufacturing_date;
	}

	public String getProduct_image() {
		return product_image;
	}

	public String getProduct_content() {
		return product_content;
	}

	public int getDiscount_rate() {
		return discount_rate;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_kind(String product_kind) {
		this.product_kind = product_kind;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public void setManufacturing_com(String manufacturing_com) {
		this.manufacturing_com = manufacturing_com;
	}

	public void setManufacturing_date(String manufacturing_date) {
		this.manufacturing_date = manufacturing_date;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "ProductDTO [product_id=" + product_id + ", product_kind=" + product_kind + ", product_name="
				+ product_name + ", product_price=" + product_price + ", product_count=" + product_count
				+ ", manufacturing_com=" + manufacturing_com + ", manufacturing_date=" + manufacturing_date
				+ ", product_image=" + product_image + ", product_content=" + product_content + ", discount_rate="
				+ discount_rate + ", reg_date=" + reg_date + "]";
	}
}
