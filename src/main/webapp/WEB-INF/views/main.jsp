<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인</title>
    <link href="css/main.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<!-- 회원가입 성공 / 로그아웃 / 로그인 실패 -->
<c:if test="${not empty msg}">
    <script>alert("${msg}");</script>
</c:if>
<body>
<!-- nav 영역 -->
<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

<div style="text-align: center; margin-top: 80px;">
    <p class="pt">로그인하고</p>
    <p class="pt">아래의 기능과 함께</p>
    <p class="pt">모든 일정을 관리하세요!</p>

    <button id="btn" type="button" class="btn btn-dark" data-href="<c:url value='/calendarView'/>">지금 시작하기!</button>

    <div id="card" class="card text-bg-dark" style="width: 600px; margin-left: auto; margin-right: auto; margin-top: 50px;">
<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="resources/assets/img/cal.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="resources/assets/img/gpt.png" class="d-block w-100" alt="...">
    </div>
  </div>
</div>
        <div class="card-img-overlay">
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        $('p.pt').fadeIn(2000);
        $('#carouselExampleSlidesOnly').carousel();
    });

    // 버튼 요소에 대한 참조를 가져옵니다.
    var btn = document.getElementById('btn');

    // 'click' 이벤트 리스너 추가
    btn.addEventListener('click', function() {
        // data-href 속성에서 URL을 가져와 location.href로 페이지를 이동시킵니다.
        location.href = this.getAttribute('data-href');
    });

    // 마우스를 올리면 슬라이드쇼를 멈춥니다.
    $('#card').hover(
        function() {
            $(this).find('.carousel').carousel('pause');
        },
        function() {
            $(this).find('.carousel').carousel('cycle');
        }
    );

    // Bootstrap Carousel을 자동으로 시작합니다.
    $('.carousel').carousel({
        interval: 3000 // 각 슬라이드 간의 시간 간격 (3초)
    });

    // 이미지 사전 로딩
    $(document).ready(function() {
        var images = [
            "resources/assets/img/cal.png",
            "resources/assets/img/gpt.png"
            // 추가 이미지 URL 추가
        ];

        $.each(images, function(index, src) {
            var img = new Image();
            img.src = src;
        });
    });

    // 로딩 스피너를 항상 감추기
    $(window).on('load', function() {
        $('#loading-spinner').hide();
    });
</script>

</body>
</html>
