package mall.buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mall.cart.CartDTO;
import util.JDBCUtil;

public class BuyDAO {
	// Singleton Pattern
	private BuyDAO() { }

	private static BuyDAO instance = new BuyDAO();

	public static BuyDAO getInstance() {
		return instance;
	}

	// DB 연결, 질의에 사용할 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// buyForm.jsp -> buyInsertPro.jsp
	// 구매 목록 추가 - 트랜잭션 처리
	// 3가지 작업: 구매 테이블 등록, 카트 테이블 삭제, 상품 테이블 수정(재고 수량 수정)
	public void insertBuyList(List<BuyDTO> buyList, List<CartDTO> cartList) throws SQLException{
		String sql1 = "insert into buy(buy_id, buyer, product_id, product_name, buy_price, buy_count, product_image, "
				+ "account, delivery_name, delivery_tel, delivery_address) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?)";
		String sql2 = "delete from cart where cart_id = ?";
		String sql3 = "select product_count from product where product_id = ?";
		String sql4 = "update product set product_count = ? where product_id = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			
			conn.setAutoCommit(false);
			// 1번 작업 - 구매 테이블에 구매 상품 등록
			for(BuyDTO buy : buyList) {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, buy.getBuy_id());
				pstmt.setString(2, buy.getBuyer());
				pstmt.setInt(3, buy.getProduct_id());
				pstmt.setString(4, buy.getProduct_name());
				pstmt.setInt(5, buy.getBuy_price());
				pstmt.setInt(6, buy.getBuy_count());
				pstmt.setString(7, buy.getProduct_image());
				pstmt.setString(8, buy.getAccount());
				pstmt.setString(9, buy.getDelivery_name());
				pstmt.setString(10, buy.getDelivery_tel());
				pstmt.setString(11, buy.getDelivery_address());
				pstmt.executeUpdate();
			}
			
			// 2번 작업 - 구매 상품 카트 테이블에서 삭제
			for(CartDTO cart : cartList) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, cart.getCart_id());
				pstmt.executeUpdate();
			}
			
			// 3번 작업 - 상품 테이블에서 재고 수량 파악 -> 상품 테이블 수정(재고 수량 수정: 기존 재고 수량 - 구매 수량)
			for(BuyDTO buy : buyList) {
				// 상품 테이블의 재고 수량 파악
				int p_count = 0;
				pstmt = conn.prepareStatement(sql3);
				pstmt.setInt(1, buy.getProduct_id());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					p_count = rs.getInt("product_count");
				}
				
				// 상품 테이블의 재고 수량 수정
				pstmt = conn.prepareStatement(sql4);
				pstmt.setInt(1, p_count-buy.getBuy_count());
				pstmt.setInt(2, buy.getProduct_id());
				pstmt.executeUpdate();
			}
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch (Exception e) {
			System.out.println("=> insertBuyList() 메소드 실행" + e.getMessage());
			conn.rollback();
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 구매 목록 수정 -> 수량 수정
	
	// buyList.jsp
	// 구매 목록 보기
	public List<BuyDTO> getBuyList(String buyer) {
		String sql = "select * from buy where buyer=? order by buy_date desc";
		List<BuyDTO> buyList = new ArrayList<BuyDTO>();
		BuyDTO buy = null;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				buy = new BuyDTO();
				buy.setBuy_id(rs.getString("buy_id"));
				buy.setBuyer(rs.getString("buyer"));
				buy.setProduct_id(rs.getInt("product_id"));
				buy.setProduct_name(rs.getString("product_name"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getInt("buy_count"));
				buy.setProduct_image(rs.getString("product_image"));
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setAccount(rs.getString("account"));
				buy.setDelivery_name(rs.getString("delivery_name"));
				buy.setDelivery_tel(rs.getString("delivery_tel"));
				buy.setDelivery_address(rs.getString("delivery_address"));
				buy.setDelivery_state(rs.getString("delivery_state"));
				buyList.add(buy);
			}
		} catch (Exception e) {
			System.out.println("=> getBuyList() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return buyList;
	}
	
	// 구매 아이디별 구매 상품 수 구하기
	public int getBuyIdCount(String buy_id) {
		String sql = "select count(*) from buy where buy_id = ?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("=> getBuyListDetail() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	// 구매 상세 보기
	public List<BuyDTO> getBuyListDetail(String buy_id) {
		String sql = "select * from buy where buy_id = ?";
		List<BuyDTO> buyListDetail = new ArrayList<BuyDTO>();
		BuyDTO buy = null;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				buy = new BuyDTO();
				buy.setBuy_id(rs.getString("buy_id"));
				buy.setBuyer(rs.getString("buyer"));
				buy.setProduct_id(rs.getInt("product_id"));
				buy.setProduct_name(rs.getString("product_name"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getInt("buy_count"));
				buy.setProduct_image(rs.getString("product_image"));
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setAccount(rs.getString("account"));
				buy.setDelivery_name(rs.getString("delivery_name"));
				buy.setDelivery_tel(rs.getString("delivery_tel"));
				buy.setDelivery_address(rs.getString("delivery_address"));
				buy.setDelivery_state(rs.getString("delivery_state"));
				buyListDetail.add(buy);
			}
		} catch (Exception e) {
			System.out.println("=> getBuyListDetail() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return buyListDetail;
	}
	
	// 구매 목록 날짜별 검색, buySearchPro.jsp
	public List<BuyDTO> getBuyListSearch(String period1, String period2, String buyer) {
		String sql = "select * from buy where buyer = ? "
				+ "and date_format(buy_date, '%Y-%m-%d') >= ? and date_format(buy_date, '%Y-%m-%d') <= ? order by buy_date desc";
		List<BuyDTO> buyListSearch = new ArrayList<BuyDTO>();
		BuyDTO buy = null;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			pstmt.setString(2, period1);
			pstmt.setString(3, period2);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				buy = new BuyDTO();
				buy.setBuy_id(rs.getString("buy_id"));
				buy.setBuyer(rs.getString("buyer"));
				buy.setProduct_id(rs.getInt("product_id"));
				buy.setProduct_name(rs.getString("product_name"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getInt("buy_count"));
				buy.setProduct_image(rs.getString("product_image"));
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setAccount(rs.getString("account"));
				buy.setDelivery_name(rs.getString("delivery_name"));
				buy.setDelivery_tel(rs.getString("delivery_tel"));
				buy.setDelivery_address(rs.getString("delivery_address"));
				buy.setDelivery_state(rs.getString("delivery_state"));
				buyListSearch.add(buy);
			}
		} catch (Exception e) {
			System.out.println("=> getBuyListSearch() 메소드 실행" + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return buyListSearch;
	}
}
