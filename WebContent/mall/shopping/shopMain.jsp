<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="manager.product.*, java.util.*, java.text.*"%>
<%-- 쇼핑몰 메인 페이지: 쇼핑몰의 모든 페이지의 중단에 포함되어 상품을 나열하는 중요한 페이지 --%>
<%-- 상품의 분류별 전체 보기 --%>
<style>
/* 상품 분류 */
.t_kind { margin-top: 30px;}
.d_kind1 { text-align: right; margin-bottom: 10px; margin-left: 20px;}
.d_kind1 .s_kind1 { display: inline-block; float: left;}
.d_kind1 .s_kind1 .s_kind11 { font-size: 1.1em; color: navy;}
.d_kind1 .s_kind2 select { margin-right: 40px; width: 150px; height: 25px;}
.d_kind2 { margin-left: 20px; margin-bottom: 10px; clear: both;}
.d_kind2 .s_kind21 { color: #f1617d;}
/* 상품 분류별 노출 */
.d_kind3 { text-align: center; position:relative; float: left; font-size: 0.9em; margin-bottom: 0;}
.d_kind3 a { text-decoration: none; color: #000;}
.c_product { display: inline-block; width: 250px; height: 350px; padding: 10px; margin: 10px; border: 1px solid gray;}
.c_product div { margin-bottom: 5px;}
.c_product .c_p2, .c_product .c_p4 { font-weight: bold;}
.c_product .c_p3 { font-size: 0.95em; color: #868e96;}
.c_product .c_p2, .c_product .c_p3 { white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
.c_product .s_p_discount { color: #f00;}
/* 상품 hover 효과 */
.c_product2 { display: none;}
.c_product2 .c_p5, .c_product2 .c_p6 { display: none;}
.d_kind3:hover .c_product2 { position: absolute; top: 0; left: 0; background: rgba(0,0,0,0.7); text-align: center;
display: inline-block; width: 250px; height: 350px; padding: 10px; margin: 10px; border: 1px solid gray;}
.d_kind3:hover .c_p5, .d_kind3:hover .c_p6 { display: inline-block; width: 70px; height: 70px; border: none; background: coral;
border-radius: 50%; margin: 140px 5px 0 5px; text-align: center; line-height: 70px; font-size: 0.9em; font-weight: bold; color: #fff;}
/* 하단 - 페이징 영역 */
#paging { text-align: center; margin-top: 20px; clear: both;}
#paging a { color: #000;}
#pBox { display: inline-block; width: 22px; height: 22px; padding:5px; margin: 5px;}
#pBox:hover { background: #f1617d; color: white; font-weight: bold; border-radius: 50%;}
.pBox_c { background: #f1617d; color: white; font-weight: bold; border-radius: 50%;}
.pBox_b { font-weight: 1000;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	let product_kind = document.getElementById("product_kind");
	
	// 상품 분류 선택에 대한 change 이벤트 처리
	product_kind.addEventListener("change", function(event) {
		// product_kind를 가지고 이동
		location = 'shopAll.jsp?product_kind=' + product_kind.value + "#t_kind";
	})
})
</script>
<%
request.setCharacterEncoding("utf-8");
String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "1";

// 상품 분류별 상품명 설정
String product_kindName = "";
switch(product_kind){
	case "1" : product_kindName = "녹차"; break;
	case "2" : product_kindName = "백차"; break;
	case "3" : product_kindName = "홍차"; break;
	case "4" : product_kindName = "우롱차"; break;
	case "5" : product_kindName = "흑차"; break;
	case "6" : product_kindName = "과일차"; break;
	case "7" : product_kindName = "허브차"; break;
	case "8" : product_kindName = "커피 원두"; break;
	case "9" : product_kindName = "분쇄 원두"; break;
	case "10" : product_kindName = "핫초코"; break;
	case "11" : product_kindName = "다구"; break;
	case "12" : product_kindName = "커피 기구"; break;
	case "13" : product_kindName = "컵"; break;
	case "14" : product_kindName = "그릇"; break;
	case "15" : product_kindName = "기타"; break;
}

/*---------------------------------------------------*/
//################# 페이징(paging) 처리
//페이징(paging) 처리를 위한 변수 선언
int pageSize = 8;// 한 페이지에 8건의 게시들을 보여 줌.
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1"; // 페이지 번호가 없을 경우 1 페이지로 설정

int currentPage = Integer.parseInt(pageNum); 		// 현재 페이지
int startRow = (currentPage - 1 ) * pageSize + 1; 	// 현제 페이지의 첫 번째 행
int endRow = currentPage * pageSize; 				// 현재 페이지의 마지막 행

/*---------------------------------------------------*/

DecimalFormat df = new DecimalFormat("#,###,###");

ProductDAO productDAO = ProductDAO.getInstance();

//분류별 상품에 대한 페이징 처리
List<ProductDTO> productList = productDAO.getProductList(startRow, pageSize, product_kind);
int cnt = productDAO.getProductCount(product_kind);
 
/*
for(ProductDTO product : productList){
	System.out.println(product);
}
*/

%>
<%-- 분류별 상품을 4개씩 2단으로 처리 --%>
<div class="t_kind" id="t_kind">
	<div class="d_kind1">
		<span class="s_kind1"><b class="s_kind11"><%=product_kindName %></b> 분야 상품 목록</span>
		<span class="s_kind2">
			<select id="product_kind">
				<option value="1" <%if(product_kind.equals("1")) {%> selected <%} %>>녹차</option>
				<option value="2" <%if(product_kind.equals("2")) {%> selected <%} %>>백차</option>
				<option value="3" <%if(product_kind.equals("3")) {%> selected <%} %>>홍차</option>
				<option value="4" <%if(product_kind.equals("4")) {%> selected <%} %>>우롱차</option>
				<option value="5" <%if(product_kind.equals("5")) {%> selected <%} %>>흑차</option>
				<option value="6" <%if(product_kind.equals("6")) {%> selected <%} %>>과일차</option>
				<option value="7" <%if(product_kind.equals("7")) {%> selected <%} %>>허브차</option>
				<option value="8" <%if(product_kind.equals("8")) {%> selected <%} %>>커피 원두</option>
				<option value="9" <%if(product_kind.equals("9")) {%> selected <%} %>>분쇄 원두</option>
				<option value="10" <%if(product_kind.equals("10")) {%> selected <%} %>>핫초코</option>
				<option value="11" <%if(product_kind.equals("11")) {%> selected <%} %>>다구</option>
				<option value="12" <%if(product_kind.equals("12")) {%> selected <%} %>>커피 기구</option>
				<option value="13" <%if(product_kind.equals("13")) {%> selected <%} %>>컵</option>
				<option value="14" <%if(product_kind.equals("14")) {%> selected <%} %>>그릇</option>
				<option value="15" <%if(product_kind.equals("15")) {%> selected <%} %>>기타</option>
		</select>
		</span>
	</div>
	<div class="d_kind2">상품 수: 총 <b class="s_kind21"><%=cnt %></b> 개</div>
	<%for (ProductDTO product : productList){ %>
	<div class="d_kind3">
			<div class="c_product">
				<div class="c_p1"><img src="/images_ezenmall/<%=product.getProduct_image()%>" width="200" height="280"></div>
				<div class="c_p2"><span title="<%=product.getProduct_name()%>"><%=product.getProduct_name()%></span></div>
				<div class="c_p3"><span title="<%=product.getManufacturing_com() %>"><%=product.getManufacturing_com() %></span> | <span title="<%=product.getManufacturing_date() %>"><%=product.getManufacturing_date() %></span></div>
				<div class="c_p4"><span><%=df.format(product.getProduct_price()) %>원 (</span><span class="s_p_discount"><%=product.getDiscount_rate() %>% 할인</span>)</div>
			</div>
			<div class="c_product2">
				<a href="#"><div class="c_p5">구매</div></a>
				<a href="shopContent.jsp?product_id=<%=product.getProduct_id() %>"><div class="c_p6">상세</div></a>
			</div>
	</div>
	<%} %>
	<%-- 하단 페이징 처리 --%>
	<div id="paging">
	<%
	if(cnt > 0){
		int pageCount = cnt / pageSize + (cnt%pageSize == 0 ? 0 : 1); // 전체 페이지 수
		int startPage = 1; // 시작 페이지 번호
		int pageBlock = 3; // 페이지의 개수
		
		// 시작 페이지 설정
		if(currentPage % 3 != 0) startPage = (currentPage/3) * 3 + 1;
		else startPage = (currentPage/3 - 1) * 3 + 1;
		
		// 끝 페이지 설정
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		
		// 처음 페이지 처리
		if(startPage > 3){ // currentPage > 10
			out.print("<a href='shopAll.jsp?pageNum=1&product_kind="+ product_kind +"'><div id='pBox' class='pBox_b' title='첫 페이지'>" + "〈〈" + "</div></a>");
		}
		
		// 이전 페이지 처리
		if(startPage > 3){ // startPage - 1 ==> 이전 페이지 처리 버튼 클릭 시, 1 페이지 전으로 이동
			out.print("<a href='shopAll.jsp?pageNum=" + (currentPage - 3) + "&product_kind="+ product_kind +"'><div id='pBox' class='pBox_b' title='이전 페이지'>" + "〈" + "</div></a>");
		}
		
		// 페이징 블럭 출력 처리
		for(int i = startPage; i <= endPage; i++){
			if(currentPage == i){ // 선택된 페이지가 현재 페이지일 때
				out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
			}else{ // 다른 페이지로 이동
				out.print("<a href='shopAll.jsp?pageNum=" + i + "&product_kind="+ product_kind +"'><div id='pBox'>" + i + "</div></a>");
			}
		}
		
		// 다음 페이지 처리
		if(endPage < pageCount){ // currentPage + 1 ==> 다음 페이지 처리 버튼 클릭 시, 1 페이지 다음으로 이동
			int movePage = currentPage + 3;
			if(movePage > pageCount) movePage = pageCount;
			out.print("<a href='shopAll.jsp?pageNum=" + movePage + "&product_kind="+ product_kind +"'><div id='pBox' class='pBox_b' title='다음 페이지'>" + "〉" + "</div></a>");
		}
		
		// 마지막 페이지 처리
		if(endPage < pageCount){ //currentPage < pageCount
			out.print("<a href='shopAll.jsp?pageNum=" + pageCount + "&product_kind="+ product_kind +"'><div id='pBox' class='pBox_b' title='마지막 페이지'>" + "〉〉" + "</div></a>");
		}
	}
	%>
	</div>
</div>
<hr>