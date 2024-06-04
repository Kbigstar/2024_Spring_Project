let dt = '';
var calendar;
let action = 'x';

let calContent;
let content = ''; // 일정내용
let startDate = ''; // 시작일자
let endDate = ''; // 종료일자
let startTime = ''; // 시작 시간
let endTime = ''; // 종료시간
let colorSelect; // 배경색 (마커 색)
let t_colorSelect; // 글꼴 색 


let year,month,day;

let allday = false;

let currentPlan;

//  캘린더
document.addEventListener('DOMContentLoaded', function() {
 var calendarEl = document.getElementById('calendar');
     calendar = new FullCalendar.Calendar(calendarEl, {
     initialView: 'dayGridMonth'
     ,titleFormat: function (date) {
         year = date.date.year;
         month = date.date.month + 1;
         
         return year + "년 " + month + "월";
     }
     ,eventTimeFormat: { // 24시간 형식으로 시간 표시
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
    }
     ,headerToolbar: {
         left: 'prev,next today',
         center: 'title',
         right: 'dayGridMonth,timeGridWeek,timeGridDay'
     }
     ,themeSystem: 'bootstrap5'
     ,weekend : true
     ,dateClick : function(date){
         dt = date.dateStr;
//         alert('클릭: ' + date.dateStr);
         $("#calendar_start_date").val(dt);
         $("#calendarModal").modal("show");

         $('#addCalendar').off('click').on('click', function() { // 새일정 생성
              content = $("#calendar_content").val(); // 일정 내용
              startDate = $("#calendar_start_date").val(); // 시작 일자
        
              if($("#calendar_end_date").val() == ""){
                  endDate = startDate; // 종료일자를 지정하지 않으면 시작일자와 같음으로 취급
              }
              else{
                  endDate = $("#calendar_end_date").val(); // 지정 했다면 지정한 종료일자
              }
              
              let timeCheck1 = $("#calendar_start_time").val();
              timeCheck1 = timeCheck1.replace(":", "");
              let timeCheck2 = $("#calendar_end_time").val();
              timeCheck2 = timeCheck2.replace(":", "");
        
              
              // 시작시간 / 종료시간 비교
              if(Number(timeCheck1) > Number(timeCheck2) || Number(startDate) < Number(endDate)){
                alert("종료시간이 시작시간보다 빠릅니다!");
                
                $("#calendar_end_time").get(0).focus();
                
                return
              }

              if ($("#calendar_start_time").val() !== '') {
            	    startTime += 'T' + $("#calendar_start_time").val(); // T09:00과 같은 포맷
            	}
              if ($("#calendar_end_time").val() !== '') {
            	    endTime += 'T' + $("#calendar_end_time").val(); // T09:00과 같은 포맷
            	}
              
              
              if($("#alldayCheck").is(":checked")){ // 하루종일 체크 여부
                  startTime = '';
                  endTime = '';
            	  allday = true;
                  if(startDate < endDate){
                    let allEndDate = new Date(endDate)
                    year = allEndDate.getFullYear();
                    month = allEndDate.getMonth()+1;
                    day = allEndDate.getDate();
                    console.log("day:", day);
                    // Allday 기간이 하루가 아닐시 종료일자 +1을 해줘야함..
                    if(day < 10 && month <10) 
                    {
                      endDate = year+"-0"+month+"-0"+(day+1);
                      if(day == 9){
                    	  endDate = year+"-0"+month+"-"+(day+1);
                      }
                    }
                    else if(day < 10 && day != 9){
                      endDate = year+"-"+month+"-0"+(day+1);
                      if(day == 9){
                    	  endDate = year+"-"+month+"-"+(day+1);
                      }
                    }
                    else if(month<10){
                      endDate = year+"-0"+month+"-"+(day+1);
                    }
                    else{
                        endDate = year+"-"+month+"-"+(day+1);
                    }
                    
                  }
              }else{
            	  allday = false
              }
        
              // 변수에 값 담아주고 초기화
              $("#calendar_content").val("");
              $("#calendar_end_date").val("");
              $("#calendar_start_time").val("09:00");
              $("#calendar_end_time").val("09:30");
              colorSelect = $("#colorSelect").val();
              $("#colorSelect").val("#000000");
              t_colorSelect = $("#t_colorSelect").val();
              $("#t_colorSelect").val("#ffffff");
            
              calContent = {
                  title : content
                  ,start : startDate + startTime
                  ,end : endDate + endTime
                  ,backgroundColor: colorSelect
                  ,textColor : t_colorSelect
                  ,allDay : allday
                
              };
              
           // JSON 데이터 생성
              var eventData = {
                  "calTitle": content,
                  "calStartdt": startDate + startTime,
                  "calEnddt": endDate + endTime,
                  "calBgcolor": colorSelect,
                  "calTextcolor": t_colorSelect,
                  "calAllday": $("#alldayCheck").is(":checked"),
                  "memId": memId
              };
           // JSON 데이터를 서버로 전송
           addCalendarEvent(eventData);

          });
         
     }
     , eventClick : function(res){
    	 	 
             console.log(res.event.dateStr);
             console.log(calendar.getEventById(res.event.id).title);
//             alert("이벤트 내용 : " + res.event.title);
             // 수정/삭제 모달 열기
             $('#eventTitle').text(res.event.title);
             $("#editDeleteModal").modal("show");
             

             // 수정 버튼 클릭 시
             $("#editEventButton").off("click").on("click", function() {            	
            	 $("#editDeleteModal").modal("hide"); // 모달 닫기
                 $("#calendar_content").val(res.event.title);
                 $("#calendar_start_date").val(moment(res.event.start).format('YYYY-MM-DD'));
                 $("#calendar_end_date").val(moment(res.event.end).format('YYYY-MM-DD'));
                 $("#calendar_start_time").val(moment(res.event.start).format('HH:mm'));
                 $("#calendar_end_time").val(moment(res.event.end).format('HH:mm'));

                 
                 if(res.event.allDay === true){
                	 $("#alldayCheck").prop("checked", true);
                 }
                 
                 $("#calendarModal").modal("show");
                 
                 
                 $("#addCalendar").html("수정");

                // 모달을 여는 함수 혹은 로직 내부에서
                $('#addCalendar').off('click').on('click', function() {
                  content = $("#calendar_content").val(); // 일정 내용
                  startDate = $("#calendar_start_date").val(); // 시작 일자
                  
                  if($("#calendar_end_date").val() == ""){
                      endDate = startDate; // 종료일자를 지정하지 않으면 시작일자와 같음으로 취급
                  }
                  else{
                      endDate = $("#calendar_end_date").val(); // 지정 했다면 지정한 종료일자
                  }
                  
                  if($("#calendar_start_time").val() != null&&  $("#calendar_end_time").val() != null){
                  let timeCheck1 = $("#calendar_start_time").val();
                  timeCheck1 = timeCheck1.replace(":", "");
                  let timeCheck2 = $("#calendar_end_time").val();
                  timeCheck2 = timeCheck2.replace(":", "");
                  
               // 시작시간 / 종료시간 비교
                  if(Number(timeCheck1) > Number(timeCheck2) || Number(startDate) < Number(endDate)){
                    alert("종료시간이 시작시간보다 빠릅니다!");
                    
                    $("#calendar_end_time").get(0).focus();
                    
                    return
                  }
                  }
                  
                  
                  if($('#alldayCheck').is(':checked') == false){
                	  if($("#calendar_start_time").val() == null || $("#calendar_start_time").val() == ''){
                    	  starTime = '';
                    	  endTime = '';
                    	  alert("시작시간이 없습니다..");
                    	  return;
                      }
                  }
                  
                  
                  if($("#alldayCheck").is(":checked")){ // 하루종일 체크 여부
                      startTime = '';
                      endTime = '';
                      allday = true;
                      if(startDate < endDate){
                        let allEndDate = new Date(endDate)
                        year = allEndDate.getFullYear();
                        month = allEndDate.getMonth()+1;
                        day = allEndDate.getDate();
                        
                        // Allday 기간이 하루가 아닐시 종료일자 +1을 해줘야함..
                        if(day < 10 && month <10) 
                        {
                          endDate = year+"-0"+month+"-0"+(day+1);
                          if(day == 9){
                        	  endDate = year+"-0"+month+"-"+(day+1);
                          }
                        }
                        else if(day < 10 && day != 9){
                          endDate = year+"-"+month+"-0"+(day+1);
                          if(day == 9){
                        	  endDate = year+"-"+month+"-"+(day+1);
                          }
                        }
                        else if(month<10){
                          endDate = year+"-0"+month+"-"+(day+1);
                        }
                        else{
                            endDate = year+"-"+month+"-"+(day+1);
                        }
                        
            
                      }
                  } else{
                	  allday = false;
                  }
                  
                	if ($("#calendar_start_time").val() != '' && $("#calendar_start_time").val() != null) {
                	    startTime += 'T' + $("#calendar_start_time").val(); // T09:00과 같은 포맷
                	}
                	if ($("#calendar_end_time").val() != '' && $("#calendar_end_time").val() != null) {
                	    endTime += 'T' + $("#calendar_end_time").val(); // T09:00과 같은 포맷
                	}
                	else {
                        startTime = '';
                        endTime = '';
                	}
                	
               	  	colorSelect = $("#colorSelect").val();
               	  	t_colorSelect = $("#t_colorSelect").val();
               	  	
                    if(allday == true){
                    // 기존 이벤트 제거
                    // 아이디값을 지정해준적이 없음
                    // 아래와같이 하니 옆의 일정이 삭제되니
                    // 이벤트 자체를 삭제후 다시 만들기
                    res.event.remove();

                    // 새 이벤트 속성 설정
                    var newEvent = {
                      // 같은 ID를 사용할 수 있습니다.
                      title: content,
                      start: allday ? startDate : startDate+startTime,
                      end: allday ? endDate : endDate + endTime,
                      backgroundColor: colorSelect,
                      textColor : t_colorSelect,
                      allDay: allday
                    };
                    
                    // 새 이벤트 추가
                    calendar.addEvent(newEvent);
                  }
                  else if(allday == false){
                    res.event.remove();
                    if($("#calendar_end_date").val() == ""){
                      endDate = startDate; // 종료일자를 지정하지 않으면 시작일자와 같음으로 취급
                    }
                    else{
                        endDate = $("#calendar_end_date").val(); // 지정 했다면 지정한 종료일자
                    }

                    // 새 이벤트 속성 설정
                    var newEvent = {
                      // 같은 ID를 사용할 수 있습니다.
                      title: content,
                      start: allday ? startDate : startDate+startTime,
                      end: allday ? endDate : endDate + endTime,
                      backgroundColor: colorSelect,
                      textColor : t_colorSelect,
                      allDay: allday
                    };

                    // 새 이벤트 추가
                    calendar.addEvent(newEvent);
                  }


                  
               // 클릭한 이벤트의 groupId 가져오기
                  var calNo = res.event.groupId; // 클릭한 이벤트의 groupId를 가져옴
                  // JSON 데이터 생성
                  var eventData = {
                		    "calNo": calNo, // 클릭한 이벤트의 cal_no
                		    "calTitle": content,
                		    "calStartdt": startDate + startTime,
                		    "calEnddt": endDate + endTime,
                		    "calBgcolor": colorSelect,
                		    "calTextcolor": t_colorSelect,
                		    "calAllday": allday,
                		    "memId": memId
                		};
                  
                  // JSON 데이터를 서버로 전송
                  updateCalendarEvent(eventData);
                });
             });

             // 삭제 버튼 클릭 시
             $("#deleteEventButton").off("click").on("click", function() {
                 var calNo2 = res.event.groupId;
                 var calendarData = {
                         memId: memId, // 사용자 아이디
                         calNo: calNo2 // 삭제할 일정의 번호
                 };
                 deleteCalendarEvent(calendarData); // 함수 호출
                 res.event.remove();
            	 $("#editDeleteModal").modal("hide"); // 모달 닫기
             });
             
             console.log(action);
             

             $("#addCalendar").html("추가");
         }
     , events : []
     
 });
     
     // 서버에서 데이터를 가져와 변수에 저장한 후에 이를 events에 추가
     // 조회
     fetchCalendarEvent(memId);
     
	 calendar.render();
});


// 일정 삽입
function addCalendarEvent(eventData) {
    $.ajax({
        url: '/my/calendar',
        type: 'POST',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(eventData),
        success: function(response, status, xhr) {
            calContent.groupId = response.calNo
            
            if (xhr.status === 302) {
                var redirectUrl = xhr.getResponseHeader('Location');
                window.location.href = redirectUrl;
            } else {
                console.log(response);
                calendar.refetchEvents();
            }
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        },
        complete: function(a) {
            console.log(eventData);
            startTime = '';
            endTime = '';
            $("#alldayCheck").prop("checked", false);
            calendar.addEvent(calContent);
            $("#calendarModal").modal("hide");
        }
    });
}



// 일정 조회
function fetchCalendarEvent(memId) {
    // 서버에서 데이터를 가져와 변수에 저장한 후에 이를 events에 추가
    // 조회
    $.ajax({
        url: '/my/calendarData', // 서버에서 데이터를 가져올 URL
        type: 'POST',
        data: JSON.stringify({ 'memId': memId }),
        contentType: 'application/json',
        dataType: 'json',
        success: function(data) {
            console.log(data);
            // 받은 데이터를 변수에 저장
            currentPlan = data;
            var eventData = data.map(function(event) {
                return {
                    title: event.calTitle, // 일정 내용
                    start: event.calStartdt, // 시작일자
                    end: event.calEnddt, // 종료일자
                    allDay: (event.calAllday === "true"), // 하루종일 여부
                    backgroundColor: event.calBgcolor, // 배경색 설정
                    textColor: event.calTextcolor, // 텍스트색 설정
                    groupId: event.calNo
                };
            });
            console.log(eventData);
            // 저장된 데이터를 events 속성에 추가
            calendar.addEventSource(eventData);
        }
    });
}

// 일정 수정
function updateCalendarEvent(eventData) {
    $.ajax({
        url: '/my/' + eventData.calNo, // RESTful 엔드포인트
        type: 'PUT',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(eventData),
        success: function(response, status, xhr) {
            if (xhr.status === 302) {
                var redirectUrl = xhr.getResponseHeader('Location');
                if (redirectUrl) {
                    window.location.href = redirectUrl;
                } else {
                    calendar.refetchEvents();
                }
            } else {
                console.log(response);
                calendar.refetchEvents();
            }
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        },
        complete: function() {
            // 모달창 input val 초기화
            startTime = '';
            endTime = '';
            $("#calendar_content").val("");
            $("#calendar_end_date").val("");
            $("#calendar_start_time").val("09:00");
            $("#calendar_end_time").val("09:30");
            $("#colorSelect").val(""); // 색상 선택(input 태그)의 값을 초기화함
            $("#t_colorSelect").val("#ffffff"); // 글꼴색 선택(input 태그)의 값을 초기화함
            $("#addCalendar").html("추가");
            action = 'x';
            allday = false;
            $("#alldayCheck").prop("checked", false);
            $("#calendarModal").modal("hide");
        }
    });
}

// 일정 삭제
function deleteCalendarEvent(calendarData) {
    // 서버로 보낼 데이터를 JSON 형식으로 변환합니다.
    var jsonData = JSON.stringify(calendarData);

    // AJAX를 사용하여 서버로 요청을 보냅니다.
    $.ajax({
        url: '/my/' + calendarData.calNo, // RESTful 엔드포인트,
        type: 'DELETE', // HTTP 요청 메서드 (DELETE)
        contentType: 'application/json', // 요청 본문의 데이터 형식
        data: jsonData, // 요청 본문에 포함될 데이터
        success: function(response) {
            // 성공적으로 응답을 받은 경우 실행될 함수
            console.log(response);
            // TODO: 성공 메시지 처리 또는 화면 갱신 등의 작업을 수행합니다.
        },
        error: function(xhr, status, error) {
            // 요청이 실패한 경우 실행될 함수
            console.error(xhr.responseText);
            // TODO: 실패 메시지 처리 또는 오류 처리 등의 작업을 수행합니다.
        }
    });
}



//GPT 추천일정 삽입
function addCalendarEvent2(eventData) {
    $.ajax({
        url: '/my/addEvent',
        type: 'POST',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(eventData),
        success: function(response, status, xhr) {
            if (xhr.status === 302) {
                var redirectUrl = xhr.getResponseHeader('Location');
                window.location.href = redirectUrl;
            } else {
                console.log(response);
                // AJAX 요청이 성공적으로 완료된 후에 calendar.addEvent 호출
            }
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
            alert("일정 추가에 실패했습니다. 다시 시도해주세요.");
        },
        complete: function(a) {
            console.log(eventData);
            // 이 곳에서 필요한 작업 수행
            location.reload()
        }
    });
}



$(document).ready(function(){
 $("navbar").load('navbar.html'); // 네비 바
 $("#mdClose1").click(function(){ // 모달 종료 우측 상단 [x] 버튼
   // 값 모두 초기화
     $("#calendar_content").val("");
     $("#calendar_end_date").val("");
     $("#calendar_start_time").val("09:00");
     $("#calendar_end_time").val("09:30");
     $("#colorSelect").val("");
     $("#t_colorSelect").val("#ffffff");
     $("#addCalendar").html("추가");
     $("#calendarModal").modal("hide");
 });
 $("#mdClose2").click(function(){ // 모달 종료 우측 하단 [취소] 버튼
   // 값 모두 초기화
     $("#calendar_content").val("");
     $("#calendar_end_date").val("");
     $("#calendar_start_time").val("09:00");
     $("#calendar_end_time").val("09:30");
     $("#colorSelect").val("");
     $("#t_colorSelect").val("#ffffff");
     $("#addCalendar").html("추가");
     $("#calendarModal").modal("hide");
 });
 $("#mdClose3").click(function(){ // [수정/삭제] 모달 종료 우측 상단 [x] 버튼
	     $("#editDeleteModal").modal("hide");
	 });

 $("#toolBtn").click(function(){ // 좌측 [일정등록] 버튼 이벤트 처리
   $("#calendarModal").modal("show");
 })

	$("#createCal").click(function(){
        // messageInput 입력 필드의 값 확인
        var messageInputValue = $("#messageInput").val().trim();

        // 입력 값이 비어 있는 경우
        if (messageInputValue === "") {
            // 사용자에게 경고 메시지 표시
            alert("추천 받을 일정 내용을 입력하세요..");
            return; // 함수 종료
        }else{
        	var query = $("#messageInput").val();		
    		createPlan(query, currentPlan);
        }
	});
 
 $("#messageInput").keypress(function(event) {
	 // 눌린 키가 'Enter' 키인지 확인합니다.
	 if (event.keyCode === 13) {
		// messageInput 입력 필드의 값 확인
	       var messageInputValue = $("#messageInput").val().trim();

	        // 입력 값이 비어 있는 경우
	        if (messageInputValue === "") {
	            // 사용자에게 경고 메시지 표시
	            alert("추천 받을 일정 내용을 입력하세요..");
	            return; // 함수 종료
	        } else{
	        	// 입력한 내용으로 일정을 생성하는 함수를 호출합니다.
	        	createPlan($("#messageInput").val(), currentPlan);
	        }
	 }
 });

});



function createPlan(query, currentPlan){
	var plan = [];
	plan = currentPlan;
	$.ajax({
        type: "POST",
        url: "", // Flask url
        data :JSON.stringify({query:query, user_plan:plan}),
        dataType : 'json',
        beforeSend : function(){
        	$(".wrap-loading").removeClass('display-none');
        },
        success: function(res){
            console.log("gd",JSON.stringify(res));
            
            if (res && res.activity && res.activity.length > 0) {
                // activity 배열을 순회하면서 각 일정의 정보를 처리
                res.activity.forEach(activity => {
                    console.log("calStartdt:", activity.calStartdt);
                    console.log("calEnddt:", activity.calEnddt);
                    console.log("calTitle:", activity.calTitle);
                calTitle = activity.calTitle + " [GPT]";
                calStartdt = activity.calStartdt;
                calEnddt = activity.calEnddt;

                var eventData = {
                    "calTitle": calTitle,
                    "calStartdt": calStartdt,
                    "calEnddt": calEnddt,
                    "memId": memId
                };
                addCalendarEvent2(eventData);
            });}
        },
        error:function(e){
            console.log(e);
            alert("요청에 문제가 있습니다 다시 시도해주세요..\nO월 O일 일정 추천해줘 와 같이 질문하세요!")
        },
        complete : function(){
        	$(".wrap-loading").addClass('display-none');
        }
    });
}