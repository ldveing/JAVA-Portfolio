<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="manager.product.ProductDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
String pageNum = request.getParameter("pageNum");
int product_id = Integer.parseInt(request.getParameter("product_id"));
ProductDAO productDAO = ProductDAO.getInstance();
productDAO.deleteProduct(product_id);
response.sendRedirect("productList.jsp?pageNum=" + pageNum);
%>
</body>
</html>