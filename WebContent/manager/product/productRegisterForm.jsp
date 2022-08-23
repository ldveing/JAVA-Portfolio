<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 폼</title>
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
table { width: 100%; border: 1px solid #2f9e77; border-collapse: collapse;
border-top: 3px solid #2f9e77; border-bottom: 3px solid #2f9e77; border-left: hidden; border-right: hidden;}
tr { height: 35px;}
td, th { border: 1px solid #2f9e77;}
th { background: #d8f4e6;}
td { padding-left: 5px;}
/* 중단 - 테이블 안의 입력 상자 */
input[type="number"] { width: 100px; margin-right: 5px;}
/* 하단 - 버튼 */
select { height: 24px;}
input::file-selector-button { width: 90px; height: 27px; background: #2f9e77; color: #fff; border: none;
border-radius: 4px; font-weight: bold; cursor: pointer;}
.btns { text-align: center; margin-top: 10px;}
.btns input { width: 100px; height: 37px; border: none; background: #495057; color: white;
font-weight: bold; margin: 5px;}
.btns input:nth-child(1) { background: #2f9e77;}
.btns input:nth-child(1):hover { border: 2px solid #2f9e77; background: #fff; color: #2f9e77; font-weight: bold; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.registerForm;
		
		// 상품 등록 페이지
		let btn_register = document.getElementById("btn_register");
		btn_register.addEventListener("click", function(){
			if(!form.product_name.value){
				alert('상품 이름 입력');
				form.product_name.focus();
				return;
			}
			
			if(!form.product_price.value){
				alert('상품 가격 입력');
				form.product_price.focus();
				return;
			}
			
			if(!form.product_count.value){
				alert('상품 수량 입력');
				form.product_count.focus();
				return;
			}
			
			if(!form.manufacturing_com.value){
				alert('제조사 입력');
				form.manufacturing_com.focus();
				return;
			}
			
			if(!form.manufacturing_date.value){
				alert('제조일 입력');
				return;
			}
			
			if(!form.discount_rate.value){
				alert('할인율 입력');
				form.discount_rate.focus();
				return;
			}
			form.submit();
		})
		
		// 상품 목록 페이지로 이동
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function(){
			location = 'productList.jsp';
		})
		
		// 관리자 페이지로 이동
		let btn_main = document.getElementById("btn_main");
		btn_main.addEventListener("click", function(){
			location = '../managerMain.jsp';
		})
		
	})
</script>
</head>
<body>
<%
String ID = (String)session.getAttribute("ID");
if(ID == null){
	out.print("<script>location='../logon/managerLoginForm.jsp'</script>");
}
%>
<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">TEA TIME</a></div>
	<div class="s_title">상품 등록</div>
	<form action="productRegisterPro.jsp" method="post" name="registerForm" enctype="multipart/form-data">
		<table>
			<tr>
				<th width="20%">상품 분류</th>
				<td width="80%">
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
				<th>상품 이름</th>
				<td><input type="text" name="product_name" size="56"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000">원</td>
			</tr>
			<tr>
				<th>상품 수량</th>
				<td><input type="number" name="product_count" min="0" max="10000">개</td>
			</tr>
			<tr>
				<th>제조사</th>
				<td><input type="date" name="manufacturing_com" size="56"></td>
			</tr>
			<tr>
				<th>제조일</th>
				<td><input type="text" name="manufacturing_date"></td>
			</tr>
			<tr>
				<th>상품 이미지</th>
				<td><input type="file" name="product_image"></td>
			</tr>
			<tr>
				<th>상품 내용</th>
				<td><input type="file" name="product_content"></td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90">%</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품 등록" id="btn_register">
			<input type="reset" value="초기화">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>