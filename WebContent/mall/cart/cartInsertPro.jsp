<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 등록</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String memberId = (String)session.getAttribute("memberId");

if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}
%>

<jsp:useBean id="cart" class="mall.cart.CartDTO"></jsp:useBean>
<jsp:setProperty property="*" name="cart"/>

<%
// 카트 정보 확인
// System.out.println(cart);

// DB 연결, 질의
CartDAO cartDAO = CartDAO.getInstance();

// 장바구니 중복 상품 획인
// 이미 존재하는 상품일 경우, 상품 수량 수정. 존재하지 않는 상품이면 상품 추가
// cart_id, product_id, buy_count
int cart_id = 0;
int buy_count = 0;
List<CartDTO> cartList = cartDAO.getCartList(memberId);
for(CartDTO dto : cartList) {
	if(dto.getProduct_id() == cart.getProduct_id()) {
		cart_id = dto.getCart_id();
		buy_count = dto.getBuy_count();
	}
}

if(cart_id == 0) { // 카트에 새 상품 추가
	cartDAO.insertCart(cart);
} else { // 카트에 중복 상품이 있으면 수량 수정
	cartDAO.updateCart(cart_id, buy_count + cart.getBuy_count()); // 기존 수량 + 추가 수량
}

/* 
int check = cartDAO.insertCart(cart);

out.print("<script>");
if(check == 0){
	out.print("alert('장바구니 추가에 실패');history.back();");
} else {
	out.print("location='cartList.jsp';");
}
out.print("</script>"); 
*/

response.sendRedirect("cartList.jsp");
%>
</body>
</html>