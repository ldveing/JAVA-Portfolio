<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 쇼핑몰 상단 페이지: 쇼핑몰의 모든 페이지의 상단에 포함되는 페이지 --%>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Monoton&display=swap');

/* 전체 레이아웃 */
.top a { text-decoration: none; color: #000;}
.t_box1, .t_box2, .t_box3, .t_box4 { display: inline-block; padding: 2%}
.t_box1, .t_box3 { width: 65%;}
.t_box2, .t_box4 { width: 25%;}

/* 구역 1(상단 좌측): 타이틀, 검색(?) */
.t_box1 .m_title { font-family: 'Monoton', cursive; font-size: 40px; text-align: center;}
.t_box1 .s_title { font-family: 'Nanum Pen Script', cursive; font-size: 20px; text-align: center;}
.t_box1 .t_search { width: 400px; text-align: center; margin-top: 15px; margin-left: 150px;
border: 1px solid black; border-radius: 35px; padding: 5px;}
.t_box1 .t_search #keyword { height: 38px; width: 300px; border: none; font-size: 0.9em;}
.t_box1 .t_search #keyword:focus { outline: none;}
.t_box1 .t_search button { border: none; background: #fff; cursor: pointer;}

/* 구역2(상단 우측): 마이 페이지, 구매 내역, 장바구니 */
.t_box2 { float: right; text-align: right; line-height: 50px;}
.t_box2 .t_b2_img1:hover { content: url('../../icons/user2.png')}
.t_box2 .t_b2_img2:hover { content: url('../../icons/buy2.png')}
.t_box2 .t_b2_img3:hover { content: url('../../icons/cart2.png')}


/* 구역3(하단 좌측): 메인 메뉴(하위 메뉴) */
.t_box3 { float: left; position: relative;}
.m_menu0 { display: inline-block; width: 30px;}
.m_menu0 .m_menu_img:hover { content: url('../../icons/menu2.png')}
.m_menu { display: inline-block;}
.m_menu a { font-family: 'Jua', sans-serif; font-size: 28px; color: #a6615a; width: 100px; padding: 5px; margin: 5px;}
.s_menu { display: none; position: absolute; top: 55px; width: 83px; z-index: 10; background: #e9e1f4;}
.sm1 { left: 60px;}
.sm2 { left: 150px;}
.sm3 { left: 280px;}
.sm4 { left: 400px;}
.sm5 { left: 480px;}
.sm6 { left: 540px;}
.m_menu:hover { color: purple; text-shadow: 1px 1px 1px lightgray;}
.m_menu:hover .s_menu { display: block;}
.s_menu div { padding: 10px 0;}
.s_menu div a { font-family: '고딕'; font-size: 0.9em; color: #000;}
.s_menu div a:hover { font-weight: bold; font-size: 0.9em; color: purple; text-shadow: 1px 1px 1px gray;}

/* 구역4(하단 우측): 로그인, 회원 가입, 고객 센터 */
.t_box4 { float: right; text-align: right;}
.t_box4 { color: gray; font-size: 0.9em; font-weight: bold;}
.top_end{ clear: both;}
</style>

<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null) { 
	
}

%>

<div class="top">	
	<div class="t_box1"> <%-- 구역 1(상단 좌측): 타이틀, 검색(?) --%>
		<div class="m_title"><a href="../shopping/shopAll.jsp">TEA TIME</a></div>
		<div class="s_title">삶에 한 잔의 여유를...</div>
		<div class="t_search">
			<form action="" method="post" name="searchForm">
				<input type="search" name="keyword" id="keyword" placeholder="검색어를 입력하시오">
				<button type="submit"><img src="../../icons/search.png" width="25" height="25"></button>
			</form>
		</div>
	</div>
	<div class="t_box2"> <%-- 구역 2(상단 우측): 마이 페이지, 구매 내역, 장바구니 --%>
		<a href="../member/memberInfoForm.jsp"><img src="../../icons/user1.png" width="40" title="회원정보" class="t_b2_img1"></a>&emsp;&emsp;
		<a href=""><img src="../../icons/buy1.png" width="40" title="구매정보" class="t_b2_img2"></a>&emsp;&emsp;
		<a href="../cart/cartList.jsp"><img src="../../icons/cart1.png" width="40" title="장바구니" class="t_b2_img3"></a>
	</div>
	<div class="t_box3"> <%-- 구역 3(하단 좌측): 메인 메뉴(하위 메뉴) --%>
		<div class="m_menu0"><a href="#"><img src="../../icons/menu1.png" width="25" class="m_menu_img"></a></div>
		<div class="m_menu mm1"><a href="#">TEA</a>
			<div class="s_menu sm1">
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=1#t_kind">녹차</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=2#t_kind">백차</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=3#t_kind">홍차</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=4#t_kind">우롱차</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=5#t_kind">흑차</a></div>
			</div>
		</div>
		<div class="m_menu mm2"><a href="#">블렌디드</a>
			<div class="s_menu sm2">
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=6#t_kind">과일차</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=7#t_kind">허브차</a></div>
			</div>
		</div>
		<div class="m_menu mm3"><a href="#">커피/핫초코</a>
			<div class="s_menu sm3">
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=8#t_kind">커피 원두</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=9#t_kind">분쇄 원두</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=10#t_kind">핫초코</a></div>
			</div>
		</div>
		<div class="m_menu mm4"><a href="#">기구</a>
			<div class="s_menu sm4">
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=11#t_kind">다구</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=12#t_kind">커피 기구</a></div>
			</div>
		</div>
		<div class="m_menu mm5"><a href="#">식기</a>
			<div class="s_menu sm5">
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=13#t_kind">컵</a></div>
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=14#t_kind">그릇</a></div>
			</div>
		</div>
		<div class="m_menu mm6"><a href="#">기타</a>
			<div class="s_menu sm6">
				<div><a href="/TeaTime/mall/shopping/shopAll.jsp?product_kind=15#t_kind">기타</a></div>
			</div>
		</div>
	</div>
	<div class="t_box4"> <%-- 구역 4(하단 우측): 로그인, 회원 가입, 고객 센터 --%>
		<%if(memberId == null) {%>
			<a href="../logon/memberLoginForm.jsp"><span>로그인</span></a> &ensp;|&ensp;
			<a href="../member/memberJoinForm.jsp"><span>회원가입</span></a> &ensp;|&ensp;
		<%} else {%>
			<a href="../member/memberInfoForm.jsp"><%=memberId %>님</a>&ensp;|&ensp;
			<a href="../logon/memberLogout.jsp">로그아웃</a>&ensp;|&ensp;
		<%} %>
		
		<a href=""><span>고객센터</span></a>
	</div>
</div>
<div class="top_end"></div>