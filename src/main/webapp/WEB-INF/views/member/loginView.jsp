<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
	<link href="css/login.css" rel="stylesheet" />
</head>
    <!-- 회원가입 성공 / 로그아웃 / 로그인 실패 -->
    <c:if test="${not empty msg}">
    	<script>alert("${msg}");</script>
    </c:if>
<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
	<!-- nav 영역 끝 -->

	      <div class="container-fluid" style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 90vh;">
        <div>
            <span style="font-size: 45px; font-weight: bold;">Calendar</span>
        </div>
      <div class="login_wrapper">
		<img class="logo2" src="resources/assets/img/cal_logo2.png" >
            <hr>
            <form class="login_form" style="margin-top: 40px;"
            	method="post" action="<c:url value="/loginDo"/>">
                <input id="memId" required type="text" name="memId" placeholder="아이디" 
                			value="${cookie.rememberId.value }">
                <input id="memPw" required type="password" name="memPw" placeholder="비밀번호">
                <div>
                  <label>
                  <input ${cookie.rememberId.value == null ? "" : "checked"} id="keep" type="checkbox" name="remember">
                  <span>아이디 기억</span>
                  </label>
                </div>
                
                <button id="login_btn" type="submit" >로그인</button>
            </form>
            <div style="display: flex; justify-content: space-between; width: 300px; margin: 0 auto;">
              <a class="ac" href="<c:url value='/registView'/>" >회원가입</a>
              <a class="ac" href="#" onclick="alert('작업 예정 입니다..')">아이디 / 비밀번호 찾기</a>
          </div>

        
      </div>
    </div>


</body>
</html>