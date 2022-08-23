<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 처리</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");

// 폼의 입력 정보 획득
// 파일 업로드 폼 -> cos.jar. 라이브러리의 MultipartRequest 클래스 사용
// request, 업로드 폴더, 최대 크기, enctype, 파일명 중복 정책
String realFolder = "c:/images_ezenmall";
int maxSize = 1024 * 1024 * 6; // 6MB
String encType = "utf-8";
String fileName = "";
MultipartRequest multi = null;

try{
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = multi.getFileNames();
	while(files.hasMoreElements()){
		String name = (String)files.nextElement();
		fileName = multi.getFilesystemName(name);
	}
	
}catch(Exception e) { 
	System.out.println("productUpdatePro.jsp 파일" + e.getMessage());
	e.printStackTrace();
}

// pageNum을 획득
String pageNum = multi.getParameter("pageNum");


//폼에서 넘어오는 9개의 필드 값을 획득(업로드 파일일 때는 반드시 MultipartRequest를 사용해야 함.) - product_id, reg_date 제외
String product_kind = multi.getParameter("product_kind");
String product_neme = multi.getParameter("product_name");
int product_price = Integer.parseInt(multi.getParameter("product_price"));
int product_count = Integer.parseInt(multi.getParameter("product_count"));
String manufacturing_com = multi.getParameter("manufacturing_com");
String manufacturing_date = multi.getParameter("manufacturing_date");
int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));

//ProductDTO 객체 생성. setter 메소드를 사용하여 값을 입력
ProductDTO product = new ProductDTO();
product.setProduct_kind(product_kind);
product.setProduct_name(product_neme);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setManufacturing_com(manufacturing_com);
product.setManufacturing_date(manufacturing_date);
product.setProduct_image(fileName);
product.setProduct_content(fileName);
product.setDiscount_rate(discount_rate);

// System.out.println("product 객체: " + product);

// DB 연결, product 테이블에 상품 추가 처리
ProductDAO productDAO = ProductDAO.getInstance();
productDAO.updateProduct(product);
response.sendRedirect("productList.jsp?&pageNum=" + pageNum);
%>
</body>
</html>