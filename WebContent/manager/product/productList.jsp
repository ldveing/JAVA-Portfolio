<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="manager.product.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 리스트</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Anton&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
#container {width: 1200px; margin: 0 auto;}
a{text-decoration: none; color: black;}
/* 상단 - 메인 & 서브 타이틀 */
.m_title {font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 20px;}
a { text-decoration: none; color: #59637f; font-size: 0.9em; font-weight: bold;}
/* 상단 - 메뉴바(전체 상품 수, 아이디, 로그아웃, 등록) */
.top_info { margin-bottom: 10px; text-align: right;}
.c_cnt { float: left;}
.c_cnt, .c_managerId { color: #59637f; font-size: 0.95em; font-weight: bold;}
.c_managerId { clear: both;}
.c_logout a { color: #99424f;}
/* 상단 - 상품 정보 테이블 */
.top_search { margin-bottom: 10px;}
.c_select { width: 153px; height: 25px;}
.c_input { width: 200px; height: 19px;}
.c_submit { width: 82px; height: 27px; border: none; background: #000; color: #fff;
font-size: 0.8em; font-weight: bold; border-radius: 3px;}

/* 중단 - 상품 목록 테이블 */
table { width: 100%; border: 1px solid black; border-collapse: collapse; font-size: 0.9em;}
tr { height: 30px;}
tr:nth-child(2n+1) { background: #f8f9fa;}
th, td { border: 1px solid black;}
th { background: #dee2e6;}
.center {text-align: center;}
.left { text-align: left; padding-left: 3px;}
.right { text-align: right;}
.img_update:hover { content:url('../../icons/update2.png')}
.img_delete:hover { content:url('../../icons/delete2.png')}
.f_row { text-align: center; font-weight: bold; color: #c84557;}
/* 하단 - 페이징 영역 */
#paging { text-align: center; margin-top: 20px;}
#pBox { display: inline-block; width: 22px; height: 22px; padding:5px; margin: 5px;}
#pBox:hover { background: #495057; color: white; font-weight: bold; border-radius: 10px;}
.pBox_c { background: #495057; color: white; font-weight: bold; border-radius: 10px;}
.pBox_b { font-weight: 1000;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
	})
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String ID = (String)session.getAttribute("ID");
if(ID == null){
	out.print("<script>location='../logon/managerLoginForm.jsp';</script>");
}


/*---------------------------------------------------*/
//################# 페이징(paging) 처리
//페이징(paging) 처리를 위한 변수 선언
int pageSize = 10;// 한 페이지에 10건의 게시들을 보여 줌.
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1"; // 페이지 번호가 없을 경우 1 페이지로 설정

int currentPage = Integer.parseInt(pageNum); 		// 현재 페이지
int startRow = (currentPage - 1 ) * pageSize + 1; 	// 현제 페이지의 첫 번째 행
int endRow = currentPage * pageSize; 				// 현재 페이지의 마지막 행

/*---------------------------------------------------*/

// 검색 처리 - 검색일 때는 search = 1, 검색이 아닐 때는 search = 0
String search = request.getParameter("search");
String s_search = "";
String i_search = "";
if(search == null) {
	search = "0";
} else { // search가 "1"일 때
	s_search = request.getParameter("s_search");
	i_search = request.getParameter("i_search");
}


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
DecimalFormat df = new DecimalFormat("#,###,###");
String product_kindName = "";

// DB 연결, 질의 처리
ProductDAO productDAO = ProductDAO.getInstance();

//전체 상품 수
int cnt = 0;

// 전체 상품 조회 - 게시판 전체 정보를 currentPage의 pageSize 크기만큼 획득(paging 처리)
// 검색 처리(검색일 때는 search = 1, 검색이 아닐 때는 search = 0)
List<ProductDTO> productList = null;
if(search.equals("1")) {
	productList = productDAO.getProductList(startRow, pageSize, s_search, i_search);
	cnt = productDAO.getProductCount(s_search, i_search);
}
else if(search.equals("0")){
	productList = productDAO.getProductList(startRow, pageSize);
	cnt = productDAO.getProductCount();
}

//매 페이지마다 전체 상품 수에 대한 역순 번호 정렬
int number = cnt - (currentPage - 1) * pageSize;
%>
<div id="container">
<%-- 상단 타이틀 --%>
	<div class="m_title"><a href="../managerMain.jsp">TEA TIME</a></div>
	<div class="s_title"><a href="productList.jsp">상품 목록</a></div>
		
	<div class="top_info">
		<span class="c_cnt">전체 상품 수: <%=cnt %> 개</span>
		<span class="c_managerId"><%=ID %>님(관리자)</span>&emsp;|&emsp;
		<span class="c_logout"><a href="../logon/managerLogout.jsp">로그아웃</a></span>&emsp;|&emsp;
		<span class="c_register"><a href="productRegisterForm.jsp">상품 등록</a></span>&emsp;
	</div>
	<%-- 상단 검색 처리 --%>
	<div class="top_search">
		<form action="productList.jsp" method="post" name="searchForm">
			<input type="hidden" name="search" value="1">
			<span class="c_s1">
				<select name="s_search" class="c_select">
					<option>이름</option>
					<option>제조사</option>
				</select>
			</span>
			<span class="c_s2"><input type="text" name="i_search" class="c_input"></span>
			<span class="c_s3"><input type="submit" value="검색" class="c_submit"></span>
		</form>
	</div>
	<%-- 중단 테이블 --%>
	<table>
		<tr>
			<th width="">No.</th>
			<th width="">상품 분류</th>
			<th width="">이미지</th>
			<th width="">상품 제목</th>
			<th width="">가격</th>
			<th width="">수량</th>
			<th width="">제조사</th>
			<th width="">제조일</th>
			<th width="">할인율</th>
			<th width="">등록일</th>
			<th width="">수정 | 삭제</th>
		</tr>
		<%if(cnt == 0) { // 등록된 글이 없을 때
			out.print("<tr class='f_row'><td colspan='11'>등록된 제품이 없습니다.</td></tr>");
		} else { // 등록된 글이 있을 때
			for(ProductDTO product : productList){
				switch(product.getProduct_kind()){
				case "1": product_kindName = "녹차"; break;
				case "2": product_kindName = "백차"; break;
				case "3": product_kindName = "홍차"; break;
				case "4": product_kindName = "우롱차"; break;
				case "5": product_kindName = "흑차"; break;
				case "6": product_kindName = "과일차"; break;
				case "7": product_kindName = "허브차"; break;
				case "8": product_kindName = "커피 원두"; break;
				case "9": product_kindName = "커피 가루"; break;
				case "10": product_kindName = "핫초코"; break;
				case "11": product_kindName = "다구"; break;
				case "12": product_kindName = "커피 기구"; break;
				case "13": product_kindName = "컵"; break;
				case "14": product_kindName = "기타"; break;
				}
		%>
		<tr>
			<td class="center"><%=number-- %></td>
			<td class="center"><%=product_kindName %></td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum%>">
				<img src=<%="/images_ezenmall/" + product.getProduct_image() %> width="35px" height="50px"></a>
			</td>
			<td class="left">
				<a href="productContent.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum%>"><%=product.getProduct_name() %></a>
			</td>
			<td class="right"><%=df.format(product.getProduct_price()) %> 원</td>
			<td class="right"><%=df.format(product.getProduct_count()) %> 개</td>
			<td class="center"><%=product.getManufacturing_com() %></td>
			<td class="center"><%=product.getManufacturing_date() %></td>
			<td class="center"><%=product.getDiscount_rate() %> %</td>
			<td class="center"><%=sdf.format(product.getReg_date()) %></td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum%>" title="상품 수정"><img src="../../icons/update1.png" width="25" class="img_update"></a>&nbsp;
				<a href="productDeletePro.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum%>" title="상품 삭제"><img src="../../icons/delete1.png" width="25" class="img_delete"></a>
			</td>
		</tr>
		<%} }%>
	</table>
	<%-- 하단 페이징 처리 --%>
	<div id="paging">
	<%
	if(cnt > 0){
		int pageCount = cnt / pageSize + (cnt%pageSize == 0 ? 0 : 1); // 전체 페이지 수
		int startPage = 1; // 시작 페이지 번호
		int pageBlock = 10; // 페이지의 개수
		
		// 시작 페이지 설정
		if(currentPage % 10 != 0) startPage = (currentPage/10) * 10 + 1;
		else startPage = (currentPage/10 - 1) * 10 + 1;
		
		// 끝 페이지 설정
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		
		// 처음 페이지 처리
		if(startPage > 10){ // currentPage > 10
			out.print("<a href='productList.jsp?pageNum=1&search=" + search + "&s_search=" + s_search + "&i_search=" + i_search + "'><div id='pBox' class='pBox_b' title='첫 페이지'>" + "〈〈" + "</div></a>");
		}
		
		// 이전 페이지 처리
		if(startPage > 10){ // startPage - 1 ==> 이전 페이지 처리 버튼 클릭 시, 1 페이지 전으로 이동
			out.print("<a href='productList.jsp?pageNum=" + (currentPage - 10) + "&search=" + search + "&s_search=" + s_search + "&i_search=" + i_search + "'><div id='pBox' class='pBox_b' title='이전 페이지'>" + "〈" + "</div></a>");
		}
		
		// 페이징 블럭 출력 처리
		for(int i = startPage; i <= endPage; i++){
			if(currentPage == i){ // 선택된 페이지가 현재 페이지일 때
				out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
			}else{ // 다른 페이지로 이동
				out.print("<a href='productList.jsp?pageNum=" + i + "&search=" + search + "&s_search=" + s_search + "&i_search=" + i_search + "'><div id='pBox'>" + i + "</div></a>");
			}
		}
		
		// 다음 페이지 처리
		if(endPage < pageCount){ // currentPage + 1 ==> 다음 페이지 처리 버튼 클릭 시, 1 페이지 다음으로 이동
			int movePage = currentPage + 10;
			if(movePage > pageCount) movePage = pageCount;
			out.print("<a href='productList.jsp?pageNum=" + movePage + "&search=" + search + "&s_search=" + s_search + "&i_search=" + i_search + "'><div id='pBox' class='pBox_b' title='다음 페이지'>" + "〉" + "</div></a>");
		}
		
		// 마지막 페이지 처리
		if(endPage < pageCount){ //currentPage < pageCount
			out.print("<a href='productList.jsp?pageNum=" + pageCount + "&search=" + search + "&s_search=" + s_search + "&i_search=" + i_search + "'><div id='pBox' class='pBox_b' title='마지막 페이지'>" + "〉〉" + "</div></a>");
		}
		
		
	}
	%>
	</div>
</div>
</body>
</html>