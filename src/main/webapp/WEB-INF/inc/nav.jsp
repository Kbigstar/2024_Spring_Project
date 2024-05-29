<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
	#navBtn {
		width: 200px;
		background-color: #111;
		border: 2px solid;
		border-radius: 1px;
		border-color: white;
		font-weight: bold;
		color: white;
		-moz-transition: background, 1s;
		-o-transition: background, 1s;
		-webkit-transition: background, 1s;
		transition: background, 1s;
	}
	
	
	#navBtn:hover {
		background-color: white;
		color: black;
		border-color: black;
	}

.logo{
	width : 40px;
	
}
</style>    
<nav class="navbar bg-dark border-bottom border-body navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="<c:url value="/" />">
      	 <img class="logo" src="resources/assets/img/cal_logo.png" >
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="<c:url value="/" />">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="<c:url value="/calendarView" />">캘린더</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="<c:url value="/chatView" />">GPT</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link active dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              메뉴
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="<c:url value="/faqView" />">FAQ</a></li>
              <li><a class="dropdown-item" href="<c:url value="/logoutDo" />">로그아웃</a></li>
              
              
            </ul>
          </li>

        </ul>
        <form class="d-flex" role="search">
          <!-- <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" id="keyword"> -->
          <c:if test="${sessionScope.login == null }">
          <button class="btn btn-outline-success" type="button" id="navBtn" data-href="<c:url value='/loginView'/>">로그인</button>
          </c:if>
          <c:if test="${sessionScope.login != null }">
          <button class="btn btn-outline-success" type="button" id="navBtn" data-href="<c:url value='/mypageView'/>">
          	${sessionScope.login.memNm } 님
          </button>
          </c:if>
        </form>
      </div>
    </div>
  </nav>

<script>
  // onclick="location.href ="<c:url value='/loginView' />" " 해결	
  //버튼 요소에 대한 참조를 가져옵니다.
  var navBtn = document.getElementById('navBtn');
  // 'click' 이벤트 리스너 추가
  navBtn.addEventListener('click', function() {
      // data-href 속성에서 URL을 가져와 location.href로 페이지를 이동시킵니다.
      location.href = this.getAttribute('data-href');
  });
 </script>