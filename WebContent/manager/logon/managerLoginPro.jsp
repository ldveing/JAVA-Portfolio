<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="manager.logon.ManagerDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
	String ID = request.getParameter("ID");
	String PW = request.getParameter("PW");

	// cnt = 1 로그인 성공, cnt = 0 로그인 실패
	ManagerDAO managerDAO = ManagerDAO.getInstance();
	int cnt = managerDAO.checkManager(ID, PW);

	out.print("<script>");
	if(cnt == 1) { // cnt = 1 로그인 성공, 세션 생성
		session.setAttribute("ID", ID);
		out.print("alert('로그인 성공'); location='../managerMain.jsp'");
	} else { // cnt = 0 로그인 실패
		out.print("alert('로그인 실패'); history.back();");
	}
	out.print("</script>");
%>
</body>
</html>