<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
	<script> var memId = "${sessionScope.login.memId}"; </script>
    <link href="css/calender.css" rel="stylesheet" >
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <script src="js/calrendar.js"></script>
</head>
<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

    <!-- 캘린더 도구 -->
    <div class="container-fluid">
            <div class="row flex-row">
            
              <div class="flex-col" style="flex: 1;" id="tool">
                <span class="sp" style="font-size: 30px; font-weight: bold;">${sessionScope.login.memNm }님의 캘린더</span>
                <hr>
                <div class="button-container">
                  <button  type="button" class="button-container" id="toolBtn">일정 등록</button>
                </div>
                <hr>
                <br>
                <br>
				<div class="button-container">
					<input type="text" class="form-control" id="messageInput" style="width:250px; border:1px solid;"
						placeholder="O월 O일 일정 추천해줘">
				</div>
				<div class="button-container">
					<button type="button" class="btn btn-primary" id="createCal" style="background-color:black; width: 250px; border-color:black;">
						GPT추천 일정</button>
				</div>

			</div>

              <div class="flex-col" style="flex: 4;" id='calendar'></div>
              
            </div>
            	
            	<div class="wrap-loading display-none">
					<div><img src="resources/assets/img/loading.gif" /></div>
				</div>
            
    </div>

	<!-- 일정관리 Modal -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" id="mdClose1" style="height: 30px;">
						<!-- &times; x 표시 -->
						<span aria-hidden="true" style="margin-top: -2px;">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="taskId" class="col-form-label">일정 내용</label> <input
							type="text" class="form-control" id="calendar_content"
							name="calendar_content"> <label for="taskId"
							class="col-form-label">시작 날짜</label> <input type="date"
							class="form-control" id="calendar_start_date"
							name="calendar_start_date"> <label for="taskId"
							class="col-form-label">종료 날짜</label> <input type="date"
							class="form-control" id="calendar_end_date"
							name="calendar_end_date">
						<div class="form-group">
							<label for="start">시작시간:</label> 
							<input type="time" class="form-control" id="calendar_start_time">
						</div>
						<div class="form-group">
							<label for="end">종료시간:</label> 
							<input type="time" class="form-control" id="calendar_end_time">
						</div>
						<div class="form-group">
							<label for="cs">배경색상</label>
							<input type="color" name="mycolor" id="colorSelect" value="#000000" class="form-control">
							<label for="cs">글씨색상</label>
							<input type="color" name="mycolor" id="t_colorSelect" value="#ffffff" class="form-control"> 
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<div class="form-check" style="margin-right: 250px;">
						<input class="form-check-input" type="checkbox" value=""
							id="alldayCheck" required> <label
							class="form-check-label" for="alldayCheck"> 하루종일 </label>
					</div>
					<button type="button" class="btn btn-secondary" id="addCalendar"
						style="background-color: #009;">추가</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" id="mdClose2" style="background: #900;">취소</button>
				</div>

			</div>
		</div>
	</div>


<div class="modal fade" id="editDeleteModal" tabindex="-1" role="dialog" aria-labelledby="editDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editDeleteModalLabel" style="font-weight: bold;">일정 수정/삭제</h5>
                <button type="button" id="mdClose3" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            	<span id="eventTitle" style="margin-bottom:20px; font-weight: bold; font-size:20px;"></span>
				<button type="button" class="btn btn-primary" id="editEventButton" style="width : 100px;">수정</button>
                <button type="button" class="btn btn-danger" id="deleteEventButton" style="width : 100px; margin-left:25px">삭제</button>
            </div>
            <div class="modal-footer">
                
            </div>
        </div>
    </div>
</div>


</body>
</html>