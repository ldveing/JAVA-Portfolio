<%@page import="mall.cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 상품 삭제(1개)</title>
</head>
<body>
<%

String memberId = (String)session.getAttribute("memberId");

if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}

int cart_id = Integer.parseInt(request.getParameter("cart_id"));

// CartDAO 연동
CartDAO cartDAO = CartDAO.getInstance();
cartDAO.deleteCart(cart_id);
response.sendRedirect("cartList.jsp");
%>
</body>
</html>