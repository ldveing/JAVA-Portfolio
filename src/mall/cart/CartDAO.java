package mall.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class CartDAO {
	// Singleton Pattern
	private CartDAO() { }

	private static CartDAO instance = new CartDAO();

	public static CartDAO getInstance() {
		return instance;
	}

	// DB 연결, 질의에 사용할 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 장바구니에 상품 등록
	public int insertCart(CartDTO cart) {
		String sql = "insert into cart(buyer, product_id, product_name, manufacturing_com, product_price, "
				+ "discount_rate, buy_price, buy_count, product_image) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int check = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getBuyer());
			pstmt.setInt(2, cart.getProduct_id());
			pstmt.setString(3, cart.getProduct_name());
			pstmt.setString(4, cart.getManufacturing_com());
			pstmt.setInt(5, cart.getProduct_price());
			pstmt.setInt(6, cart.getDiscount_rate());
			pstmt.setInt(7, cart.getBuy_price());
			pstmt.setInt(8, cart.getBuy_count());
			pstmt.setString(9, cart.getProduct_image());
			check = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("=> insertCart() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return check;
	}
	
	// 장바구니 주문 (각 상품별)
	public CartDTO getcart(int cart_id) {
		String sql = "select * from cart where cart_id = ?";
		CartDTO cart = null;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cart = new CartDTO();
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setBuyer(rs.getString("buyer"));
				cart.setProduct_id(rs.getInt("product_id"));
				cart.setProduct_name(rs.getString("product_name"));
				cart.setManufacturing_com(rs.getString("manufacturing_com"));
				cart.setProduct_price(rs.getInt("product_price"));
				cart.setDiscount_rate(rs.getInt("discount_rate"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getInt("buy_count"));
				cart.setProduct_image(rs.getString("product_image"));
			}
		} catch (Exception e) {
			System.out.println("=> getcart() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cart;		
	}
	
	// 장바구니 주문 (선택한 상품 or 전체 상품)
	
	// 장바구니 -> 구매 확인, buyForm.jsp에서 사용
	public List<CartDTO> getCartList(List<Integer> cart_id_list) {
		String sql = "select * from cart where cart_id = ?";
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		CartDTO cart = null;
		try {
			conn = JDBCUtil.getConnection();
			for (int c_id : cart_id_list) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, c_id);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cart = new CartDTO();
					cart.setCart_id(rs.getInt("cart_id"));
					cart.setBuyer(rs.getString("buyer"));
					cart.setProduct_id(rs.getInt("product_id"));
					cart.setProduct_name(rs.getString("product_name"));
					cart.setManufacturing_com(rs.getString("manufacturing_com"));
					cart.setProduct_price(rs.getInt("product_price"));
					cart.setDiscount_rate(rs.getInt("discount_rate"));
					cart.setBuy_price(rs.getInt("buy_price"));
					cart.setBuy_count(rs.getInt("buy_count"));
					cart.setProduct_image(rs.getString("product_image"));
					cartList.add(cart);
				}
			}		
		} catch (Exception e) {
			System.out.println("=> getCartList(cart_id_list) 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cartList;
		
	}
	
	// 장바구니 목록 확인(사용자의 모든 장바구니)
	public List<CartDTO> getCartList(String buyer) {
		String sql = "select * from cart where buyer = ?";
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setBuyer(rs.getString("buyer"));
				cart.setProduct_id(rs.getInt("product_id"));
				cart.setProduct_name(rs.getString("product_name"));
				cart.setManufacturing_com(rs.getString("manufacturing_com"));
				cart.setProduct_price(rs.getInt("product_price"));
				cart.setDiscount_rate(rs.getInt("discount_rate"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getInt("buy_count"));
				cart.setProduct_image(rs.getString("product_image"));
				cartList.add(cart);
			}
		} catch (Exception e) {
			System.out.println("=> getCartList() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cartList;
	}
	
	// 장바구니 상품 종류 개수
	public int getCartListCount(String buyer) {
		String sql = "select count(*) from cart where buyer = ?";
		int count = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			rs.next();
			count = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("=> getCartListCount() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return count;
	}
	
	// 장바구니 주문 수량 수정 (각 상품별)
	public void updateCart(int cart_id, int buy_count) {
		String sql = "update cart set buy_count = ? where cart_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, buy_count);
			pstmt.setInt(2, cart_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("=> updateCart() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 장바구니 삭제 (각 상품별)
	public void deleteCart(int cart_id) {
		String sql = "delete from cart where cart_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("=> deleteCart() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	
	// 장바구니 삭제 (선택한 상품 or 전체 상품)
	public void deleteCartList(String[] cart_ids) {
		String sql = "delete from cart where cart_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			for (String cart_id : cart_ids) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(cart_id));
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println("=> deleteCartList() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
}
