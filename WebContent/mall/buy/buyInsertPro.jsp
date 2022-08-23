<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, mall.buy.*, java.util.*, java.sql.*" %>
<%@ page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최종 구매 확인 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String memberId = (String)session.getAttribute("memberId");

if(memberId == null) { 
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}
// 정보 확인

List<CartDTO> cartList = (List<CartDTO>)session.getAttribute("cartList");
String account = request.getParameter("account");
String delivery_name = request.getParameter("delivery_name");
String delivery_tel = request.getParameter("delivery_tel");
String delivery_address = request.getParameter("delivery_address1") + " " + request.getParameter("delivery_address2");

// 고유한 구매 아이디를 생성 (하나의 카트에 담겨있는 모든 상품에 대한)
// 구매 아이디(buy_id): 날짜 8자리 + 고유한 숫자 12자리 ==> 20자리의 고유한 구매 아이디 생성
// 1. 날짜 8자리
Timestamp now = new Timestamp(System.currentTimeMillis());
String n = now.toString();
String s1 = n.substring(0, 4) + n.substring(5, 7) + n.substring(8, 10);
// 2. 고유한 숫자 12자리
UUID uuid = UUID.randomUUID();
String s2 = uuid.toString().replace("-", "").substring(0, 12);
String buy_id = s1 + s2;

// 구매 리스트에 저장
List<BuyDTO> buyList = new ArrayList<BuyDTO>();
BuyDTO buy = null;
for(CartDTO cart : cartList) {
	buy = new BuyDTO();
	buy.setBuy_id(buy_id);
	buy.setBuyer(cart.getBuyer());
	buy.setProduct_id(cart.getProduct_id());
	buy.setProduct_name(cart.getProduct_name());
	buy.setBuy_price(cart.getBuy_price());
	buy.setBuy_count(cart.getBuy_count());
	buy.setProduct_image(cart.getProduct_image());
	buy.setAccount(account);
	buy.setDelivery_name(delivery_name);
	buy.setDelivery_tel(delivery_tel);
	buy.setDelivery_address(delivery_address);
	buyList.add(buy);
}

session.setAttribute("buyList", buyList);

// buyList 확인
/*
for(BuyDTO b : buyList) {
	System.out.println(b);
}
*/

// BuyDAO 연동
BuyDAO buyDAO = BuyDAO.getInstance();
buyDAO.insertBuyList(buyList, cartList);
response.sendRedirect("buyList.jsp");
%>
</body>
</html>