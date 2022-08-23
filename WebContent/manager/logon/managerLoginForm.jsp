<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Anton&family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Hammersmith+One&display=swap');
#container {width: 300px; margin: 0 auto;}
a{text-decoration: none; color: black;}
/* 상단 - 메인 & 서브 타이틀 */
.m_title {font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title {font-family: 'Hammersmith One', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px;}
/* 중단 - 로그인 박스 */
.b_box { border: 1px solid lightgray; padding: 5px; margin: 10px;}
.b_box input[type='text'], .b_box input[type='password']{ height: 30px; padding-left: 30px; border: none;}
/* input:focus{outline: none} */
.b_box input[type='text']:focus, .b_box input[type='password']:focus {outline: none}
.b_box input[type='text'] { background: url('../../icons/login_id.png') no-repeat;
background-size: 25px; background-position: left center;}
.b_box input[type='password'] { background: url('../../icons/login_pwd.png') no-repeat;
background-size: 25px; background-position: left center;}
.c_box { margin: 10px;}
.c_box input[type='button']{ width: 100%; height: 45px; border: none; background: #5e869c; color: #fff;
font-weight: bold; font-size: 1.03em;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
let form = document.managerLoginForm;
	
	let btn_login = document.getElementById("btn_login");
	btn_login.addEventListener("click", function(){
		if(!form.ID.value){
			alert('ID를 입력하시오');
			form.ID.focus();
			return;
		}
		if(!form.PW.value){
			alert('PW를 입력하시오');
			form.PW.focus();
			return;
		}
		form.submit();
	})
})
</script>
</head>
<body>
<div id="container">
	<div class="m_title"><a href="#">TEA TIME</a></div>
	<div class="s_title">관리자 로그인</div>
	
	<form action="managerLoginPro.jsp" method="post" name="managerLoginForm">
		<div class="a_box">
			<div class="b_box">
				<input type="text" name="ID" id="ID" placeholder="아이디" size="28">
			</div>
			<div class="b_box">
				<input type="password" name="PW" id="PW" placeholder="비밀번호" size="28">
			</div>
			<div class="c_box">
				<input type="button" name="로그인" id="btn_login" value="로그인">
			</div>
		</div>
	</form>
</div>
</body>
</html>