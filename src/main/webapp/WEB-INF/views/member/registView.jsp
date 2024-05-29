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
    <c:if test="${not empty msg}">
		alert("${msg}");
	</c:if>
         $(document).ready(function(){

          $("#login_btn").click(function(){
              let val = $("#login_phone").val()
              console.log(val);
              
          })
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
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

         $(document).ready(function() {
	        		
        	 
        		//ID 중복 확인
        		//id를 입력할 수 있는 input text 영역을 벗어나면 동작한다.
        		$("#memId").on("focusout", function() {
        			
        			var id = $("#memId").val();
        			
        			if(id == '' || id.length == 0) {
        				$("#label1").css("color", "red").text("공백은 ID로 사용할 수 없습니다.");
        				return false;
        			}
        			
        	    	//Ajax로 전송
        	    	$.ajax({
        	    		url : './ConfirmId',
        	    		data : {
        	    			id : id
        	    		},
        	    		type : 'POST',
        	    		dataType : 'json',
        	    		success : function(result) {
        	    			if (result == true) {
        	    			/* 	$("#label1").css("color", "black").text("사용 가능한 ID 입니다."); */
        	    				$("#idCheck").css("color", "green").text('사용 가능한 아이디입니다!');
        	    			} else{
        	    				/* $("#label1").css("color", "red").text("사용 불가능한 ID 입니다."); */
        	    				alert($("#memId").val() + " 는 중복된 아이디 입니다..");
        	    				$("#memId").val('');
        	    				$("#memId").focus();
        	    				$("#idCheck").text('');	
        	    				$("#idCheck").css("color", "red").text('중복된 아이디입니다..');
        	    			}
        	    		}
        	    	}); //End Ajax
        		});
        	})
    </script>
</head>
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
			<p style="font-size: 30px; font-weight: bold; margin-top: -50px;">회원가입</p>
			<hr>
			<form class="regist_form needs-validation" novalidate
				style="margin-top: 10px;" method="post" action="<c:url value="/registDo"/>">
				<div class="form-group">
					<input id="memId" type="text" name="memId" placeholder="아이디"
						required class="form-control">
					<!-- <label id="idLabel" for="memId"></label> -->
					<div class="invalid-feedback" id="idCheck">아이디는 필수입니다!</div>
					<div class="valid-feedback"></div>
					<input id="memPw" type="password" name="memPw"
						placeholder="비밀번호" required class="form-control">
					<div class="invalid-feedback">비밀번호는 필수입니다!</div>
					<input id="memNm" type="text" name="memNm" placeholder="이름"
						required class="form-control">
					<div class="invalid-feedback">이름은 필수입니다!</div>
					<input id="memPhone" type="text" oninput="hypenTel(this)" name="memPhone"
						maxlength="13" placeholder="전화번호" required class="form-control">
					<div class="invalid-feedback">전화번호는 필수입니다!</div>
				</div>



				<button id="regist_btn" type="submit">회원가입</button>
			</form>

		</div>
	</div>


</body>
</html>