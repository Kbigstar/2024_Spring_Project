<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<link href="css/member.css" rel="stylesheet" />
    <script>
         $(document).ready(function(){

          $("#login_btn").click(function(){
              let val = $("#login_phone").val()
              console.log(val);
              
          })
        const forms = document.querySelectorAll('.needs-validation')

        Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
            form.classList.add('was-validated')
            const inputs = form.querySelectorAll('input')
            inputs.forEach(input => {
                if (!input.validity.valid) {
                input.classList.add('is-invalid')
                }
            })
            }
        }, false)
        })

         })
         const hypenTel = (target) => {
            target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
             
            }
    </script>
</head>
	    <c:if test="${not empty msg2}">
    	<script>alert("${msg2}");</script>
    	</c:if>
<body>

	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
	<!-- nav 영역 끝 -->

	<div class="container-fluid"
		style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 100vh;">
		<div style="margin-top: 30px;">
			<span style="font-size: 45px; font-weight: bold;">Calendar</span>
		</div>
		<div class="regist_wrapper">
			<p style="font-size: 30px; font-weight: bold; margin-top: -50px;">마이페이지</p>
			<hr>
			<form class="regist_form needs-validation" novalidate
				style="margin-top: 10px;" method="post" action="<c:url value="/updateDo"/>">
				<div class="form-group">
					<input disabled value="${sessionScope.login.memId}" id="memId" type="text" name="memId" placeholder="아이디"
						required class="form-control">
					 <input type="hidden" name="memId" value="${sessionScope.login.memId}">
					<input id="memPw" type="password" name="memPw"
						placeholder="비밀번호" required class="form-control">
					<div class="invalid-feedback">비밀번호는 필수입니다!</div>
					<input id="memNm" type="text" name="memNm" placeholder="이름" value="${sessionScope.login.memNm}"
						required class="form-control">
					<div class="invalid-feedback">이름은 필수입니다!</div>
					<input id="memPhone" type="text" oninput="hypenTel(this)" name="memPhone" value="${sessionScope.login.memPhone}"
						maxlength="13" placeholder="전화번호" required class="form-control">
					<div class="invalid-feedback">전화번호는 필수입니다!</div>
				</div>

				<button id="regist_btn2" type="submit">수정하기</button>
				<a class="ac" href="<c:url value="/logoutDo" />">로그아웃</a>
			</form>


		</div>
	</div>

</body>
</html>