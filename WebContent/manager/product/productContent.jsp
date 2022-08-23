<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="manager.product.*"%>
<%@page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세 보기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Anton&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
#container {width: 550px; margin: 0 auto;}
a{text-decoration: none; color: black;}
/* 상단 - 메인 & 서브 타이틀 */
.m_title {font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 20px;}
a { text-decoration: none; color: #59637f; font-size: 0.9em; font-weight: bold;}
.c_logout { text-align: center; margin-bottom: 10px;}
.c_logout a { color: #99424f;}
/* 중단 - 테이블 */
table { width: 100%; border: 1px solid #705e7b; border-collapse: collapse;
border-top: 3px solid #705e7b; border-bottom: 3px solid #705e7b; border-left: hidden; border-right: hidden;}
tr { height: 35px;}
td, th { border: 1px solid #705e7b;}
th { background: #e6c9e1;}
td { padding-left: 5px;}
/* 중단 - 테이블 안의 입력 상자 */
.c_p_id, .c_p_reg_date { background: #e9ecef;}
.s_p_id, .s_p_reg_date { color: #f00; font-size: 0.8em; font-weight: bold; margin-left: 10px}
.s_p_image { color: #00f; font-size: 0.8em;}
input[type="number"] { width: 100px; margin-right: 5px;}
textarea { margin-top: 5px;}
/* 하단 - 버튼 */
select { height: 24px;}
input::file-selector-button { width: 90px; height: 27px; background: #705e7b; color: #fff; border: none;
border-radius: 4px; font-weight: bold; cursor: pointer;}
.btns { text-align: center; margin-top: 10px;}
.btns input { width: 100px; height: 37px; border: none; background: #495057; color: #fff;
font-weight: bold; margin: 5px; cursor: pointer;}
.btns input:nth-child(1), .btns input:nth-child(2) { background: #705e7b;}
.btns input:nth-child(1):hover, .btns input:nth-child(2):hover { border: 2px solid #705e7b; background: #fff; color: #705e7b; font-weight: bold; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.updateForm;
		
		// 상품 분류가 선택되도록 설정 - ex) 녹차: 1
		let product_kind = form.product_kind;	// select
		let p_kind = form.p_kind;				// ex) 녹차: 1이 있는 input
		for(let i = 0; i < product_kind.length; i++) {
			if(p_kind.value == product_kind[i].value) {
				product_kind[i].selected = true;
				break;
			}
		}
		
		// 상품 수정 페이지
		let btn_update = document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
			if (!form.product_name.value) {
				alert('상품 이름 입력');
				form.product_name.focus();
				return;
			}

			if (!form.product_price.value) {
				alert('상품 가격 입력');
				form.product_price.focus();
				return;
			}

			if (!form.product_count.value) {
				alert('상품 수량 입력');
				form.product_count.focus();
				return;
			}

			if (!form.manufacturing_com.value) {
				alert('제조사 입력');
				form.manufacturing_com.focus();
				return;
			}

			if (!form.manufacturing_date.value) {
				alert('제조일 입력');
				return;
			}

			if (!form.discount_rate.value) {
				alert('할인율 입력');
				form.discount_rate.focus();
				return;
			}
			form.submit();
		})

		// 상품 삭제 페이지로 이동
		let product_id = form.product_id.value;
		let pageNum = form.pageNum.value;
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function() {
			location = 'productDeletePro.jsp?product_id=' + product_id + "&pageNum=" + pageNum;
		})

		// 상품 목록 페이지로 이동
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function() {
			location = 'productList.jsp?pageNum=' + pageNum;
		})

		// 관리자 페이지로 이동
		let btn_main = document.getElementById("btn_main");
		btn_main.addEventListener("click", function() {
			location = '../managerMain.jsp';
		})

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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


String pageNum = request.getParameter("pageNum");
int product_id = Integer.parseInt(request.getParameter("product_id"));

// DB 연결, 질의
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
%>
<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">TEA TIME</a></div>
	<div class="s_title">상품 정보 확인</div>

	<form action="productUpdatePro.jsp" method="post" name="updateForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table>
			<tr>
				<th>상품 번호</th>
				<td>
					<input type="text" name="product_id" value="<%=product.getProduct_id() %>" size="10" readonly class="c_p_id">
					<span class="s_p_id">상품 번호는 변경 불가</span>
				</td>
			</tr>
			<tr>
				<th width="20%">상품 분류</th>
				<td width="80%">
					<input type="hidden" name="p_kind" value="<%=product.getProduct_kind() %>">
					<select name="product_kind">
						<option value="1">녹차</option>
						<option value="2">백차</option>
						<option value="3">홍차</option>
						<option value="4">우롱차</option>
						<option value="5">흑차</option>
						<option value="6">과일차</option>
						<option value="7">허브차</option>
						<option value="8">커피 원두</option>
						<option value="9">분쇄 원두</option>
						<option value="10">핫초코</option>
						<option value="11">다구</option>
						<option value="12">커피 기구</option>
						<option value="13">컵</option>
						<option value="14">그릇</option>
						<option value="15">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품 제목</th>
				<td><input type="text" name="product_name" size="56" value="<%=product.getProduct_name() %>"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000" value="<%=product.getProduct_price() %>">원</td>
			</tr>
			<tr>
				<th>상품 수량</th>
				<td><input type="number" name="product_count" min="0" max="10000" value="<%=product.getProduct_count() %>">개</td>
			</tr>
			<tr>
				<th>제조사</th>
				<td><input type="text" name="manufacturing_com" size="56" value="<%=product.getManufacturing_com() %>"></td>
			</tr>
			<tr>
				<th>제조일</th>
				<td><input type="date" name="manufacturing_date" value="<%=product.getManufacturing_date() %>"></td>
			</tr>
			<tr>
				<th>상품 이미지</th>
				<td>
					<input type="file" name="product_image"><br>
					<span class="s_p_image">상품 이미지를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>상품 내용</th>
				<td>
					<input type="file" name="product_content"><br>
					<span class="s_p_image">상품 이미지를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate() %>">%</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>
					<input type="text" name="reg_date" value="<%=sdf.format(product.getReg_date()) %>" readonly class="c_p_reg_date">
					<span class="s_p_reg_date">등록일은 변경 불가</span>
				</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품 정보 수정" id="btn_update">
			<input type="button" value="상품 삭제" id="btn_delete">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>